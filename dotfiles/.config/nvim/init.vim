set number " show line numbers
set mouse=a " support the mouse even in the terminal

" Vim's built-in netrw plugin places .netrwhist files in the current directory
" when invoked. Turn off these files by setting history to 0.
let g:netrw_dirhistmax = 0

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Only auto wrap lines if line exceeds textwidth during current insert
set formatoptions+=b

set textwidth=99 " Wrap lines longer than 99 characters
set colorcolumn=+1 " highlight vertical column at textwidth + 1

" Defaults for whitespace and tabwidth. Overridden for specific filetypes.
set softtabstop=4 shiftwidth=4 expandtab

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

" when saving a buffer that starts with a shebang, make it executable
au BufWritePost * if getline(1) =~ "^#!.*/bin/" | silent !chmod a+x % | endif

" select last pasted text
nnoremap <expr> gp '`[' . strpart(getregtype(), 0, 1) . '`]'

" map leader key to space bar
let mapleader=" "

" build a project. Only useful if makeprg is set
nmap <leader>r :make<CR>

" Toggle highlight search
nmap <silent> <leader>h :set invhls<CR>

" Remove trailing whitespace
nmap <silent> <leader>w :%s/\s\+$<CR>

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
" Show CoC diagnostics in the statusline
let g:airline#extensions#coc#enabled = 1

" vim-go settings

" Coc handles code completion
let g:go_code_completion_enabled = 0

" Run gometalinter on save
let g:go_metalinter_autosave = 1

" Set command for metalinter
let g:go_metalinter_command = 'golangci-lint'

" vim-jsx-pretty settings

let g:vim_jsx_pretty_colorful_config = 1 " requires vim-javascript

" vim-terraform settings

let g:terraform_fmt_on_save=1

" Show errors in the number column. Requires NeoVim 0.5.0+
set signcolumn=number

" coc.nvim settings

" Extensions to install
let g:coc_global_extensions = ['coc-json', 'coc-jedi', 'coc-pyright', 'coc-go']

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Use <cr> (return) to confirm selected completion
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Use tab for trigger completion with characters ahead and navigate.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
" Go to next diagnostic
nmap <silent> <leader>e <Plug>(coc-diagnostic-next)
nmap <silent> <leader>E <Plug>(coc-diagnostic-prev)

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

" Add mapping to format current buffer.
nmap <leader>f  <Plug>(coc-format)
" Add mapping to organize imports.
nmap <leader>i call CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" EasyAlign plugin

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" nvim-treesitter plugin
lua <<EOF
require'nvim-treesitter.configs'.setup {
  -- One of "all", "maintained", or list of languages
  -- https://github.com/nvim-treesitter/nvim-treesitter#supported-languages
  ensure_installed = "all",

  -- List of parsers to ignore installing. I'm ignoring everything that's
  -- marked as experimental or unofficially maintained except markdown
  ignore_install = { "d", "elm", "fortran", "haskell", "swift", "phpdoc" },

  -- Install languages synchronously (only applied to `ensure_installed`)
  sync_install = false,

  highlight = {
    -- `false` will disable the whole extension
    enable = true,

    -- list of language that will be disabled
    disable = {},
  },
}
EOF
