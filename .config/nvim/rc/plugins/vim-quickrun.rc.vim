set splitright
set splitbelow
let g:quickrun_config = {
            \   '_' : {
            \       'outputter' : 'error',
            \       'outputter/error/success' : 'buffer',
            \       'outputter/error/error' : 'quickfix',
            \       'outputter/buffer/split' : 'rightbelow 8sp',
            \       'outputter/buffer/close_on_empty' : 1,
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
