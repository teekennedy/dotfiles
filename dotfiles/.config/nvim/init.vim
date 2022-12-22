" Remove trailing whitespace
nmap <silent> <leader>w :%s/\s\+$<CR>

" Toggle paste mode
nmap <silent> <leader>p :set invpaste<CR>

" Jsonnet plugin settings

let g:jsonnet_command='jsonnet'
let g:jsonnet_fmt_command='jsonnetfmt'
let g:jsonnet_fmt_options='--comment-style h'

" Markdown plugin settings

let g:vim_markdown_folding_disabled=1
let g:vim_markdown_auto_insert_bullets=1
let g:vim_markdown_new_list_item_indent=2
