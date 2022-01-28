" Settings for shell files

" Only execute this script once for the current buffer
if exists("b:sh_ftplugin_loaded")
  finish
endif
let b:sh_ftplugin_loaded = 1

" Indentation settings (personal preference)
set sts=4 ts=4 sw=4 expandtab
