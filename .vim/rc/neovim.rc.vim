"---------------------------------------------------------------------------
" For neovim:
"---------------------------------------------------------------------------


tnoremap <ESC> <C-\><C-n>
tnoremap jj <C-\><C-n>
tnoremap j<Space> j


let $NVIM_TUI_ENABLE_CURSOR_SHAPE = 1

if has('mac')
  let g:python_host_prog = '/usr/local/bin/python2'
  let g:python3_host_prog = '/usr/local/bin/python3'
else
  let g:python_host_prog = '/usr/bin/python2'
  let g:python3_host_prog = '/usr/bin/python3'
endif
