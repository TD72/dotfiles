"---------------------------------------------------------------------------
" For neovim:
"---------------------------------------------------------------------------
tnoremap <ESC> <C-\><C-n>

let $NVIM_TUI_ENABLE_CURSOR_SHAPE = 1

let g:python_host_prog = expand('$HOME') . '/.virtualenvs/default/bin/python'
let g:python3_host_prog = expand('$HOME') . '/.virtualenvs/default/bin/python'

autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif

