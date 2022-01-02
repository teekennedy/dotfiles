set number " show line numbers
set mouse=a " support the mouse even in the terminal

" Vim's built-in netrw plugin places .netrwhist files in the current directory
" when invoked. Turn off these files by setting history to 0.
let g:netrw_dirhistmax = 0

" Indent automatically depending on filetype
set sts=4 ts=4 sw=4 expandtab

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Only auto wrap lines if line exceeds textwidth during current insert
set formatoptions+=b

set tw=79 " Wrap lines longer than 79 characters
set cc=+1 " highlight vertical column at textwidth + 1

set hidden " Allow for switching buffers without saving

" Save swap files under a central location. The // suffix will include the full
" path to each swapfile to avoid filename collisions.
set dir=~/.swp//

" Smart case search
set ic
set smartcase

" Tab-complete the longest prefix common to all matches, then tab again will
" provide a list, and further tabs will cycle through completion options.
set wildmode=longest,list,full

set lbr " Wrap text visually (does not insert '\n') (lbr|nolbr)

" Use gruvbox colorscheme
set termguicolors " Allows true 24 bit color setting
autocmd vimenter * colorscheme gruvbox
let g:gruvbox_contrast_dark='hard'

" custom commands

" select last pasted text
nnoremap <expr> gp '`[' . strpart(getregtype(), 0, 1) . '`]'

" command to change all indentation-related values simultaneously
fun! SetTabWidth( width ) "{{{
    execute "setlocal sts=".a:width." ts=".a:width." sw=".a:width
endfunction "}}}

command! -nargs=* SetTabWidth call SetTabWidth( '<args>' )

" map leader key to space bar
let mapleader=" "

" build a project. Only useful if makeprg is set
nmap <leader>r :make<CR>

" Toggle highlight search
nmap <silent> <leader>h :set invhls<CR>

" Remove trailing whitespace
nmap <silent> <leader>w :%s/\s\+$<CR>

" Run GoTest on the current buffer
nmap <silent> <leader>t :GoTest<CR>

" Toggle paste mode
nmap <silent> <leader>p :set invpaste<CR>

" CtrlP plugin settings

" Ignore files that are also ignored by git and my custom .ctrlpignore
let g:ctrlp_user_command = ['.git', 'cd %s' .
    \ '&& git ls-files -co --exclude-standard' .
    \ '| ([ -f .ctrlpignore ] && grep -vf .ctrlpignore || cat)']

" search in Files, Buffers and MRU files at the same time.
let g:ctrlp_cmd = 'CtrlPMixed'

" turn off working path detection and just use vim's cwd
let g:ctrlp_working_path_mode = 0

" Jsonnet plugin settings

let g:jsonnet_command='jsonnet'
let g:jsonnet_fmt_command='jsonnetfmt'
let g:jsonnet_fmt_options='--comment-style h'

" Markdown plugin settings

let g:vim_markdown_folding_disabled=1
let g:vim_markdown_auto_insert_bullets=1
let g:vim_markdown_new_list_item_indent=2

" Airline plugin settings

" use powerline patched font symbols
let g:airline_powerline_fonts = 1
" Set the timeout for waiting for another key to be pressed in milliseconds.
" This prevents a noticeable delay after hitting ESC to leave insert mode.
set ttimeoutlen=7
" Cache changes to highlighting groups. Makes switching between modes faster
let g:airline_highlighting_cache = 1
" Let vim-airline set the tabline when there are no tabs
let g:airline#extensions#tabline#enabled = 1
" Show ALE diagnostics in the statusline
let g:airline#extensions#ale#enabled = 1

" waf syntax
au BufNewFile,BufRead wscript set filetype=python

" Jenkinsfiles are groovy
au BufNewFile,BufRead *.jenkinsfile,Jenkinsfile set filetype=groovy

" Some repos use dockerfile as a prefix
au BufNewFile,BufRead Dockerfile.* set filetype=dockerfile

" vim-go settings

" No gofmt or goimports on save. Coc does this.
let g:go_fmt_autosave = 0
let g:go_imports_autosave = 0
" Coc handles code completion as well
let g:go_code_completion_enabled = 0

" ALE uses location list, vim-go uses quickfix list by default. Having both
" open produces weird UI issues (see https://vi.stackexchange.com/q/14166)
let g:go_list_type = 'locationlist'

" vim-jsx-pretty settings

let g:vim_jsx_pretty_colorful_config = 1 " requires vim-javascript

" vim-terraform settings

let g:terraform_fmt_on_save=1

" ALE (asynchronous lint engine) settings
let g:ale_sign_error = 'E'
let g:ale_sign_warning = 'w'
let g:ale_linters = {
        \'python': ['flake8'],
    \}

" Show errors in the number column. Requires NeoVim 0.5.0+
set signcolumn=number

" Go to next warning / error
nnoremap <leader>e :ALENext<cr>

" Use coc.nvim for language server protocol support
let g:ale_disable_lsp = 1

" Format code for me on :w
let g:ale_fix_on_save = 1

" Auto import where supported
let g:ale_completion_autoimport = 1

" Formatters / fixers for various file types
let g:ale_fixers = {
        \'go': ['goimports', 'gofmt'],
        \'python': ['black', 'isort'],
    \}

" coc.nvim settings

" Extensions to install
let g:coc_global_extensions = ['coc-json', 'coc-jedi', 'coc-pyright', 'coc-go']

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add (Neo)Vim's native statusline support.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" EasyAlign plugin

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)
