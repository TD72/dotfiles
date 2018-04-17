"---------------------------------------------------------------------------
" deoplete.nvim
"
"let g:deoplete#_context = {}

set completeopt+=noselect

" <TAB>: completion.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ deoplete#mappings#manual_complete()
function! s:check_back_space() abort "{{{
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction"}}}

" <S-TAB>: completion back.
inoremap <expr><S-TAB>  pumvisible() ? "\<C-p>" : "\<C-h>"

" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> deoplete#mappings#smart_close_popup()."\<C-h>"
inoremap <expr><BS> deoplete#mappings#smart_close_popup()."\<C-h>"

" inoremap <expr><C-g> deoplete#mappings#undo_completion()
" <C-l>: redraw candidates
" inoremap <expr><C-l>       deoplete#mappings#refresh()
inoremap <expr><C-g> deoplete#refresh()
inoremap <silent><expr><C-l> deoplete#complete_common_string()

" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function() abort
  return deoplete#cancel_popup() . "\<CR>"
endfunction

inoremap <expr> '  pumvisible() ? deoplete#mappings#close_popup() : "'"

call deoplete#custom#source('ghc', 'sorters', ['sorter_word'])
" call deoplete#custom#source('_', 'matchers', ['matcher_head'])
" call deoplete#custom#source('_', 'matchers', ['matcher_full_fuzzy'])
" call deoplete#custom#source('_', 'disabled_syntaxes', ['Comment', 'String'])
" call deoplete#custom#source('buffer', 'mark', '*')

" Use auto delimiter
" call deoplete#custom#source('_', 'converters',
"       \ ['converter_auto_paren',
"       \  'converter_auto_delimiter', 'remove_overlap'])
call deoplete#custom#source('_', 'converters', [
      \ 'converter_remove_paren',
      \ 'converter_remove_overlap',
      \ 'converter_truncate_abbr',
      \ 'converter_truncate_menu',
      \ 'converter_auto_delimiter',
      \ ])

" call deoplete#custom#set('buffer', 'min_pattern_length', 9999)
call deoplete#custom#source('clang', 'input_pattern', '\.\w*|\.->\w*|\w+::\w*')
call deoplete#custom#source('clang', 'max_pattern_length', -1)

let g:deoplete#keyword_patterns = {}
let g:deoplete#keyword_patterns._ = '[a-zA-Z_]\k*\(?'
let g:deoplete#keyword_patterns.tex = '[^\w|\s][a-zA-Z_]\w*'

let g:deoplete#omni#input_patterns = {}
let g:deoplete#omni#input_patterns.python = ''
let g:deoplete#omni#functions = {}
" let g:deoplete#omni#functions.lua = 'xolox#lua#omnifunc'

" inoremap <silent><expr> <C-t> deoplete#mappings#manual_complete('file')

let g:deoplete#enable_refresh_always = 0
let g:deoplete#enable_camel_case = 1
" let g:deoplete#auto_complete_start_length = 3
"
let g:deoplete#skip_chars = ['(', ')']
let g:deoplete#auto_complete_delay = 0
let g:deoplete#file#enable_buffer_path = 1
let g:deoplete#auto_refresh_delay = 100
let g:deoplete#max_list = 10

let g:deoplete#ignore_sources = {}
let g:deoplete#ignore_sources.python = 
      \ ['buffer', 'dictionary', 'member', 'omni', 'tag', 'sylntax', 'around']

let g:deoplete#sources#jedi#statement_length = 0
let g:deoplete#sources#jedi#short_types = 0
let g:deoplete#sources#jedi#show_docstring = 1
let g:deoplete#sources#jedi#worker_threads = 2
let g:deoplete#sources#jedi#python_path = g:python3_host_prog




" deoplete-go "{{{
" Path to python interpreter for neovim
" Skip the check of neovim module
let g:python3_host_skip_check = 1
let g:deoplete#sources#go#gocode_binary = $GOPATH.'/bin/gocode'
let g:deoplete#sources#go#sort_class = ['package', 'func', 'type', 'var', 'const']
let g:deoplete#sources#go#use_cache = 1
if has('mac')
  let g:deoplete#sources#go#json_directory = expand('~/.cache/deoplete/go/darwin_amd64')
  let g:deoplete#sources#go#cgo#libclang_path = '/usr/local/Cellar/llvm/5.0.0/lib/libclang.dylib'
else
  let g:deoplete#sources#go#json_directory = expand('~/.cache/deoplete/go/linux_amd64')
  let g:deoplete#sources#go#cgo#libclang_path = '/usr/lib/libclang.so'
endif

let g:deoplete#sources#go#cgo = 1
"}}}


" call deoplete#enable_logging('DEBUG', 'deoplete.log')