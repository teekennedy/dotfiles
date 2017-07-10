" This file contains filetype mappings used as fallback for when vim cannot
" automatically determine filetype, or as overrides for the detected filetype.
if exists("did_load_filetypes_userafter")
  finish
endif
let did_load_filetypes_userafter = 1

augroup filetypedetect
    " fallback filetypes use this format
    au BufRead,BufNewFile *.zsh-theme setfiletype zsh
    " override filetypes use this format
    " au BufRead,BufNewFile *.zsh-theme set filetype=zsh
augroup END
