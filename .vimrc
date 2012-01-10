" Turn on line numbering. Turn it off with "set nonu" 
set nu 

" Set syntax on
syntax on

" Indent automatically depending on filetype
filetype on
filetype indent on
filetype plugin on
set autoindent
set smartindent
set smarttab

" Allow for switching buffers without saving
set hidden

" Don't update display while executing macros
set lazyredraw

" Case insensitive search
set ic

" display the mode you're in
set showmode

" enhanced command-line completion
set wildmenu

" Higlhight search
set hls

" Wrap text instead of being on one line
set lbr

" Automatically change working directory to that of current file.
" While a little more cryptic, this command has greater plugin
" Compatibility than its more obvious counterpart (set autochdir)
autocmd BufEnter * silent! lcd %:p:h

colorscheme molokai

" My favorite font"
if has("gui_running")
	if has("gui_gtk2")
		set guifont=Envy\ Code\ R\ 11
	elseif has("gui_win32")
		set guifont=Envy\ Code\ R:h10:w6
	endif
endif

" ruby
autocmd FileType ruby,eruby set omnifunc=rubycomplete#Complete
autocmd FileType ruby,eruby let g:rubycomplete_buffer_loading = 1
autocmd FileType ruby,eruby let g:rubycomplete_rails = 1
autocmd FileType ruby,eruby let g:rubycomplete_classes_in_global = 1

