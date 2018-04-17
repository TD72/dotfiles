if executable('ag')
    let g:unite_source_grep_command = 'ag'
    let g:unite_source_grep_default_opt = '--no group --nocolor --column'
    let g:unite_source_grep_recursive_opt = ''
    let g:unite_source_rec_async_command =
    \ ['ag', '--follow', '--nocolor', '--nogroup',
    \  '--hidden', '-g', '']
endif

let g:unite_enable_start_insert=1
let g:unite_source_history_yank_enable =1
" let g:unite_source_history_yank_enable =0
let g:unite_split_rule="dynamictop"
