" Settings for go files

" Only execute this script once for the current buffer
if exists("b:go_ftplugin_loaded")
  finish
endif
let b:go_ftplugin_loaded = 1

set tabstop=4 shiftwidth=4 textwidth=99
