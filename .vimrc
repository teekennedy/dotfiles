" All plugins managed using git submodules and added using pathogen,
" which is a submodule itself.
runtime bundle/pathogen/autoload/pathogen.vim
call pathogen#infect()
call pathogen#helptags()

set nocp " turn off vi compatibility
set nu " Turn on line numbering. (nu|nonu)

syntax on " Set syntax on
" Don't flag curly braces inside parenthesis (i.e. C++11 syntax) as error
let c_no_curly_error=1

" Indent automatically depending on filetype
set sts=4 ts=4 sw=4 expandtab
filetype plugin indent on
set autoindent
set smartindent
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

" ruby
autocmd FileType ruby,eruby set omnifunc=rubycomplete#Complete
autocmd FileType ruby,eruby let g:rubycomplete_buffer_loading = 1
autocmd FileType ruby,eruby let g:rubycomplete_rails = 1
autocmd FileType ruby,eruby let g:rubycomplete_classes_in_global = 1

" function to insert a C/C++ header file guard
function! s:InsertGuard()
    let randlen = 7
    let randnum = system("xxd -c " . randlen * 2 . " -l " . randlen . " -p /dev/urandom")
    let randnum = strpart(randnum, 0, randlen * 2)
    let fname = expand("%")
    let lastslash = strridx(fname, "/")
    let date = system('date "+%Y-%m-%d"')
    let date = strpart( date, 0, len(date) - 1 )
    if lastslash >= 0
        let fname = strpart(fname, lastslash+1)
    endif
    norm ggO/**
    exec 'norm o@file ' . fname
    silent !git rev-parse --git-dir
    if v:shell_error == 0 " only attempt to add author if we're in a git dir
        let authorname = system("git config user.name")
        let authorname = strpart( authorname, 0, len(authorname) - 1 )
        let authoremail = system("git config user.email")
        let authoremail = strpart( authoremail, 0, len(authoremail) - 1 )
        let author = authorname . ' <' . authoremail . '>'
        exec 'norm o@author ' . author
    endif
    exec 'norm o@date ' . date
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
" let g:ycm_autoclose_preview_window_after_completion = 1

" Thanks to JazzCore for this UltiSnips and YCM compatibility function:
" https://github.com/Valloric/YouCompleteMe/issues/36#issuecomment-15451411

" UltiSnips completion function that tries to expand a snippet. If there's no
" snippet for expanding, it checks for completion window and if it's
" shown, selects first element. If there's no completion window it tries to
" jump to next placeholder. If there's no placeholder it just returns TAB key
function! g:UltiSnips_Complete()
    call UltiSnips_ExpandSnippet()
    if g:ulti_expand_res == 0
        if pumvisible()
            return "\<C-n>"
        else
            call UltiSnips_JumpForwards()
            if g:ulti_jump_forwards_res == 0
               return "\<TAB>"
            endif
        endif
    endif
    return ""
endfunction

au BufEnter * exec "inoremap <silent> " .
        \ g:UltiSnipsExpandTrigger . " <C-R>=g:UltiSnips_Complete()<cr>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsListSnippets="<c-e>"
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

" Vim sessions Plugin Settings

let g:session_autoload='no'
let g:session_autosave='no'
let g:session_persist_globals=['&makeprg']
