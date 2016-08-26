let g:ref_cache_dir = expand('$CACHE/ref')
let g:ref_use_vimproc = 1


let g:ref_phpmanual_path = '~/.vim/ref/php-chunked-xhtml'
let g:ref_source_webdict_sites = {
            \ 'je': {
            \		'url': 'http://dictionary.infoseek.ne.jp/jeword/%s',
            \},
            \	'ej': {
            \		'url': 'http://dictionary.infoseek.ne.jp/ejword/%s',
            \},
            \ 'wiki': {
            \		'url': 'http://ja.wikipedia.org/wiki/%s',
            \},}
" Filtering the output. Delete the waste clumns
function! g:ref_source_webdict_sites.je.filter(output)
    return join(split(a:output, "\n")[15 :], "\n")
endfunction
function! g:ref_source_webdict_sites.ej.filter(output)
    return join(split(a:output, "\n")[15 :], "\n")
endfunction
function! g:ref_source_webdict_sites.wiki.filter(output)
    return join(split(a:output, "\n")[17 :], "\n")
endfunction
let g:ref_source_webdict_sites.default = 'ej'

