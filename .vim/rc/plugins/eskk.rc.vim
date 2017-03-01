let g:eskk#directory = expand('$CACHE/eskk')
let g:eskk#dictionary = {
      \   'path': expand('$CACHE/skk-jisyo'),
      \   'sorted': 0,
      \   'encoding': 'utf-8',
      \}
let g:eskk#enable_completion = 1

let g:eskk#large_dictionary = {
      \ 'path': "$HOME/Library/Application\ Support/AquaSKK/SKK-JISYO.L",
      \ 'sorted': 1,
      \ 'encoding': 'euc-jp',
      \ }

" let g:eskk_revert_henkan_style = "okuri"
" Use <> instead of ▽.
let g:eskk#marker_henkan = '<>'
" Use >> instead of ▼.
let g:eskk#marker_henkan_select = '>>'

let g:eskk#keep_state = 0
let g:eskk#debug = 0
let g:eskk#show_annotation = 1
let g:eskk#rom_input_style = 'msime'
let g:eskk#egg_like_newline = 1
let g:eskk#egg_like_newline_completion = 1
let g:eskk#tab_select_completion = 1
let g:eskk#start_completion_length = 2

autocmd MyAutoCmd User eskk-initialize-post
      \ EskkMap -remap jj <ESC>
autocmd MyAutoCmd User eskk-initialize-pre call s:eskk_initial_pre()
function! s:eskk_initial_pre() abort "{{{
  let t = eskk#table#new('rom_to_hira*', 'rom_to_hira')
  call t.add_map('z ', '　')
  call t.add_map('~', '〜')
  call t.add_map('zc', '©')
  call t.add_map('zr', '®')
  call t.add_map('z9', '（')
  call t.add_map('z0', '）')
  call eskk#register_mode_table('hira', t)
endfunction "}}}
