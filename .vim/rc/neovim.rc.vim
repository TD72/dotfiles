"---------------------------------------------------------------------------
" For neovim:
"---------------------------------------------------------------------------


tnoremap <ESC> <C-\><C-n>
tnoremap jj <C-\><C-n>
tnoremap j<Space> j

" nnoremap <Leader><CR> :<C-u>terminal<CR>
" nnoremap <silent> <Leader>s :e term://zsh<CR> i

" let $NVIM_TUI_ENABLE_CURSOR_SHAPE = 1


" augroup MyAutoCmd
"   autocmd CursorHold * if exists(':rshada') | rshada | wshada | endif
" augroup END
"
" autocmd BufEnter * call s:init_neovim_qt()
"
" function! s:init_neovim_qt() abort
"   if $NVIM_GUI == ''
"     return
"   endif
"
"   " Neovim-qt Guifont command
"   command! -nargs=? Guifont call rpcnotify(0, 'Gui', 'SetFont', '<args>')
"         \ | let g:Guifont = '<args>'
"
"   " Set the font
"   if !exists('g:Guifont')
"     Guifont Courier 10 Pitch:h14
"   endif
"
"   " if &columns < 170
"   "   " Width of window.
"   "    set columns=170
"   " endif
"   " if &lines < 40
"   "   " Height of window.
"   "    set lines=40
"   " endif
" endfunction
