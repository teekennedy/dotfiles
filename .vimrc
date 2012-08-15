" Turn on line numbering. Turn it off with set nonu
set nu

" Set syntax on
syntax on

" Indent automatically depending on filetype
set sts=4 ts=4 sw=4 expandtab
filetype on
filetype indent on
filetype plugin on
set autoindent
set smartindent
set smarttab

" Wrap lines longer than 79 characters
set tw=79

" Allow for switching buffers without saving
set hidden

" Don't update display while executing macros
set lazyredraw

" Case insensitive search
set ic
set smartcase

" display the mode you're in
set showmode

" enhanced command-line completion
set wildmenu

" Higlhight search
set hls

" Wrap text instead of being on one line
set lbr

colorscheme molokai

" Turn off highlight search
nmap  ,n :set invhls<CR>:set hls?<CR>

if has("gui_running")
    set cc=+1
    " I only want incremental search in the GUI
    set incsearch
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
    if lastslash >= 0
        let fname = strpart(fname, lastslash+1)
    endif
    let fname = substitute(fname, "[^a-zA-Z0-9]", "_", "g")
    let randid = toupper(fname . "_" . randnum)
    exec 'norm O#ifndef ' . randid
    exec 'norm o#define ' . randid
    exec 'norm o'
    let origin = getpos('.')
    exec '$norm o#endif /* ' . randid . ' */'
    norm o
    -norm O
    call setpos('.', origin)
    norm w
endfunction

noremap <silent> <F12>  :call <SID>InsertGuard()<CR>
inoremap <silent> <F12>  <Esc>:call <SID>InsertGuard()<CR>

" generate ctags recursively at the current working directory
nmap <silent> <F8> :silent !ctags -R<CR>
" remove trailing whitespace from a file
nmap <silent> ,w :%s/\s\+$<CR>

"-----------------------------------------------------------------------------
" NERD Tree Plugin Settings
"-----------------------------------------------------------------------------
" Toggle the NERD Tree on an off with F7
nmap <F7> :NERDTreeToggle<CR>

" Close the NERD Tree with Shift-F7
nmap <S-F7> :NERDTreeClose<CR>

" Show the bookmarks table on startup
let NERDTreeShowBookmarks=1

" Don't display these kinds of files
let NERDTreeIgnore=[ '\.o$', '\.a$', '\.exe$', '\.pyc$',
                   \ '^Thumbs\.db$', '^\.sconsign\.dblite$',
                   \ '\.swp$', '\.lib$' ]

" scons syntax
au BufNewFile,BufRead SCons* set filetype=scons
