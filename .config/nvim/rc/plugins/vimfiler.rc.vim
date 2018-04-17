let g:vimfiler_as_default_explorer = 1
let g:vimfiler_enable_auto_cd = 1
" '.' and '.pyc' ignore.
let g:vimfiler_ignore_pattern='\(^\.\|\~$\|\.pyc$\|\.[oad]$\)'
" use R to refresh
nmap <buffer> R <Plug>(vimfiler_resdasasraw_screen)
" overwrite C-l
" nmap <buffer> <C-l> <C-w>l
" Enter expand tree
map <buffer> <CR> <Plug>(vimfiler_expand_or_edit)
