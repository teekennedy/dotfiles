set number " show what line I'm on
set relativenumber " show relative line numbers
set mouse=a " support the mouse even in the terminal

" Vim's built-in netrw plugin places .netrwhist files in the current directory
" when invoked. Turn off these files by setting history to 0.
let g:netrw_dirhistmax = 0

" Indent automatically depending on filetype
set sts=4 ts=4 sw=4 expandtab

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

" Airline plugin settings

" use powerline patched font symbols
let g:airline_powerline_fonts = 1
" Set the timeout for waiting for another key to be pressed in milliseconds.
" This prevents a noticeable delay after hitting ESC to leave insert mode.
set ttimeoutlen=7
" Let vim-airline set the tabline when there are no tabs
let g:airline#extensions#tabline#enabled = 1

" waf syntax
au BufNewFile,BufRead wscript set filetype=python

" Jenkinsfiles are groovy
au BufNewFile,BufRead *.jenkinsfile,Jenkinsfile set filetype=groovy

" Some repos use dockerfile as a prefix
au BufNewFile,BufRead Dockerfile.* set filetype=dockerfile

" vim-go settings

" No gofmt on save. ALE does this.
let g:go_fmt_autosave = 0

" ALE uses location list, vim-go uses quickfix list by default. Having both
" open produces weird UI issues (see https://vi.stackexchange.com/q/14166)
let g:go_list_type = 'locationlist'

" vim-jsx-pretty settings

let g:vim_jsx_pretty_colorful_config = 1 " requires vim-javascript

" vim-terraform settings

let g:terraform_fmt_on_save=1

" easy-align settings

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)
