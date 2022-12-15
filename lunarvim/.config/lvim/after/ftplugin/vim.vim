" Settings for vim files

" Only execute this script once for the current buffer
if exists("b:vim_ftplugin_loaded")
  finish
endif
let b:vim_ftplugin_loaded = 1

" Indentation settings (personal preference)
setlocal sts=2 ts=2 sw=2 expandtab
