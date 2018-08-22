"---------------------------------------------------------------------------
" For neovim:
"---------------------------------------------------------------------------
tnoremap <ESC> <C-\><C-n>

let g:python_host_prog = expand('$PYG_ROOT') . '/default/bin/python'
let g:python3_host_prog = expand('$PYG_ROOT') . '/default/bin/python'

autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif

autocmd MyAutoCmd CursorHold *
      \if exists(':rshada') | rshada | wshada | endif

set inccommand=split

