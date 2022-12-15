" Settings for groovy files

" Only execute this script once for the current buffer
if exists("b:groovy_ftplugin_loaded")
  finish
endif
let b:groovy_ftplugin_loaded = 1

" Groovy indentation rules
set softtabstop=2 shiftwidth=2 expandtab
