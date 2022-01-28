" Settings for jsonnet files

" Only execute this script once for the current buffer
if exists("b:jsonnet_ftplugin_loaded")
  finish
endif
let b:jsonnet_ftplugin_loaded = 1

" Jsonnet indentation rules (default for jsonnetfmt)
setlocal sts=2 ts=2 sw=2 expandtab
