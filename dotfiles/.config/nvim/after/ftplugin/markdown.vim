" Only do this when not done yet for this buffer
if exists("b:markdown_ftplugin_loaded")
  finish
endif
let b:markdown_ftplugin_loaded = 1

set sts=2 ts=2 sw=2 expandtab
" Allow rewrapping of bullet points by telling vim to treat the bullet
" characters as 'first line only' comment strings.
" https://github.com/plasticboy/vim-markdown/issues/390#issuecomment-578459147
set comments=n:>
set formatoptions-=q
set formatlistpat=^\\s*\\d\\+\\.\\s\\+\\\|^\\s*\[-*+]\\s\\+
