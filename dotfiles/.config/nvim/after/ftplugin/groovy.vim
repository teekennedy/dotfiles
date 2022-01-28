" Settings for groovy files

" Only execute this script once for the current buffer
if exists("b:groovy_ftplugin_loaded")
  finish
endif
let b:groovy_ftplugin_loaded = 1

" Groovy indentation rules
setlocal sts=2 ts=2 sw=2
