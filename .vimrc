" All plugins managed using git submodules and added using pathogen,
" which is a submodule itself.
runtime bundle/pathogen/autoload/pathogen.vim
call pathogen#infect()

set nocp " turn off vi compatibility
set nu " Turn on line numbering. (nu|nonu)

syntax on " Set syntax on
" Don't flag curly braces inside parenthesis (i.e. C++11 lambda) as error
let c_no_curly_error=1

" Indent automatically depending on filetype
set sts=4 ts=4 sw=4 expandtab
filetype plugin indent on
set autoindent
set smarttab

set tw=79 " Wrap lines longer than 79 characters

set hidden " Allow for switching buffers without saving

set lazyredraw " Don't update display while executing macros

" Smart case search
set ic
set smartcase

" The following help avoid 'Hit ENTER to continue' status messages:
set shortmess=a " Shorten status messages
set cmdheight=2 " More status message lines (default is 1)

set wildmenu " enhanced command-line completion

set hls " Higlhight search

set lbr " Wrap text visually (does not insert '\n') (lbr|nolbr)

colorscheme molokai

if has("gui_running")
    set cc=+1 " highlight vertical column at textwidth + 1
    set incsearch " I only want incremental search in the GUI
    " I'm not a fan of the toolbar I never use stealing screen real estate
    set guioptions=ac
    if has("gui_gtk2")
        set guifont=Terminus\ 9
    elseif has("gui_win32")
        set guifont=Envy\ Code\ R:h10:w6
    endif
endif

" function to insert a C/C++ header file guard
function! s:InsertGuard()
    let randlen = 7
    let randnum = system("xxd -c " . randlen * 2 . " -l " . randlen . " -p /dev/urandom")
    let randnum = strpart(randnum, 0, randlen * 2)
    let fname = expand("%")
    let lastslash = strridx(fname, "/")
    if lastslash >= 0
        let fname = strpart(fname, lastslash+1)
    endif
    norm ggO/**
    exec 'norm o@file ' . fname
    norm o/
    let fname = substitute(fname, "[^a-zA-Z0-9]", "_", "g")
    let randid = toupper(fname . "_" . randnum)
    exec 'norm o#ifndef ' . randid
    exec 'norm o#define ' . randid
    exec 'norm o'
    let origin = getpos('.')
    exec '$norm Go#endif /* ' . randid . ' */'
    norm O
    call setpos('.', origin)
    norm w
endfunction

noremap <silent> <F12>  :call <SID>InsertGuard()<CR>
inoremap <silent> <F12>  <Esc>:call <SID>InsertGuard()<CR>

" generate ctags recursively at the current working directory
nmap <silent> <F8> :silent !ctags -R<CR>

" build a project. Only useful if makeprg is set
nmap <F6> :make<CR>

" Toggle highlight search
nmap ,n :set invhls<CR>:set hls?<CR>

" Remove trailing whitespace
nmap <silent> ,w :%s/\s\+$<CR>

" You complete me plugin settings

let g:ycm_extra_conf_globlist = [ '~/projects/*', '!~/*' ]
let g:ycm_add_preview_to_completeopt = 1

" Map UltiSnips to Ctrl+k
let g:UltiSnipsExpandTrigger="<c-k>"
let g:UltiSnipsJumpForwardTrigger="<c-k>"
let g:UltiSnipsJumpBackwardTrigger="<s-c-j>"

" NERD Tree Plugin Settings

" Toggle the NERD Tree on an off with F7
nmap <F7> :NERDTreeToggle<CR>

let NERDTreeShowBookmarks=1 " Show the bookmarks table on startup

" Don't display these kinds of files
let NERDTreeIgnore=[ '\.o$', '\.a$', '\.exe$', '\.pyc$',
                   \ '^Thumbs\.db$', '^\.sconsign\.dblite$',
                   \ '\.swp$', '\.lib$' ]

" scons syntax
au BufNewFile,BufRead SCons* set filetype=scons

" waf syntax
au BufNewFile,BufRead wscript set filetype=python

" Vim sessions Plugin Settings

let g:session_autoload='no'
let g:session_autosave='no'
let g:session_persist_globals=['&makeprg']
