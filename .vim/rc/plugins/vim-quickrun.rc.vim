set splitright
set splitbelow
let g:quickrun_config = {
            \   '_' : {
            \       'split' : '',
            \       'hook/close_quickfix/enable_success' : 1,
            \       'hook/close_buffer/enable_failure' : 1,
            \       'outputter' : 'multi:buffer:quickfix',
            \       'hook/neco/enable' : 1,
            \       'hook/neco/wait' : 20,
            \       'hook/time/enable': 1,
            \       'runner' : 'vimproc',
            \       'runner/vimproc/updatetime' : 60,
            \       'runner/vimproc/sleep' : 60,
            \   },
            \   'tex' : {
            \       'command' : 'latexmk',
            \       'cmdopt' : '-pvc',
            \       'exec' : ['%c %o %s']
            \   }
            \ }
" Stop the quickrun
nnoremap <expr><silent> <C-c> quickrun#is_running() ?
            \ quickrun#sweep_sessions() : "\<C-c>"
