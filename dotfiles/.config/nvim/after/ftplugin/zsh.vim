" Settings for zsh files

" Only execute this script once for the current buffer
if exists("b:zsh_ftplugin_loaded")
  finish
endif
let b:zsh_ftplugin_loaded = 1

" Indentation settings (personal preference)
set softtabstop=4 shiftwidth=4 expandtab
