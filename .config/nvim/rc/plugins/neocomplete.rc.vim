let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_smart_case = 1
let g:neocomplete#enable_camel_case = 1
let g:neocomplete#enable_fuzzy_completion = 1
let g:acp_enableAtStartup = 0
let g:neocomplete#disable_auto_select_buffer_name_pattern =
            \ '\[Command Line\]'

if !exists('g:neocomplete#force_omni_input_patterns')
    let g:neocomplete#force_omni_input_patterns = {}
endif
let g:neocomplete#sources#omni#input_patterns = {
            \ 'ruby' : '[^. *\t]\.\w*\|\h\w*::',
            \}
let g:neocomplete#force_omni_input_patterns = {
            \ 'python': '\%([^. \t]\.\|^\s*@\|^\s*from\s.\+import \|^\s*from \|^\s*import \)\w*'
            \}

" key mappings
inoremap <expr><TAB> pumvisible()? "\<C-n>":"\<TAB>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
" inoremap <expr><Space> pumvisible() ? neocomplete#close_popup():"\<Space>"
