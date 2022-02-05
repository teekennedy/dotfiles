" Settings for go files

" Only execute this script once for the current buffer
if exists("b:go_ftplugin_loaded")
  finish
endif
let b:go_ftplugin_loaded = 1

" Run GoTest on the current buffer
nnoremap <buffer> <silent> <leader>t :GoTest<CR>

" Run GoCoverageToggle on the current buffer
nnoremap <buffer> <silent> <leader>c :GoCoverageToggle<CR>

" Tabs for indentation is the gofmt standard.
" While gofmt doesn't enforce line length, 99 characters is a good default.
set tabstop=4 shiftwidth=4 noexpandtab textwidth=99
