
let g:lightline = {
	\ 'colorscheme': 'solarized',
	\ 'mode_map': {'c': 'NORMAL'},
	\ 'active': {
	\   'left': [ [ 'mode', 'paste' ], [ 'fugitive', 'filename' ], [ 'filepath'] ],
	\   'right': [
        \     [ 'filetype', 'fileencoding', 'fileformat', 'lineinfo', 'percent'], 
        \     ['linter_errors', 'linterwarnings', 'linter_ok'],
        \   ],
	\ },
	\ 'component': {
	\   'lineinfo': ' %3l:%-2v',
	\ },
	\ 'component_function': {
	\   'modified': 'MyModified',
	\   'readonly': 'MyReadonly',
	\   'fugitive': 'MyFugitive',
	\   'filepath': 'MyFilepath',
	\   'filename': 'MyFilename',
	\   'fileformat': 'MyFileformat',
	\   'filetype': 'MyFiletype',
	\   'fileencoding': 'MyFileencoding',
	\   'mode': 'MyMode',
	\ },
	\ 'separator': { 'left': "", 'right': "" },
	\ 'subseparator': { 'left': "", 'right': "" }
	\ }

function! MyDate()
return strftime("%Y/%m/%d %H:%M")
endfunction

function! MyModified()
return &ft =~ 'help\|vimfiler\|gundo' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! MyReadonly()
return &ft !~? 'help\|vimfiler\|gundo' && &readonly ? '' : ''
endfunction

function! MyFilepath()
return substitute(getcwd(), $HOME, '~', '')
endfunction

function! MyFilename()
return ('' != MyReadonly() ? MyReadonly() . ' ' : '') .
	    \ (&ft == 'vimfiler' ? vimfiler#get_status_string() :
	    \  &ft == 'unite' ? unite#get_status_string() :
	    \  &ft == 'vimshell' ? vimshell#get_status_string() :
	    \ '' != expand('%:t') ? expand('%:t') : '[No Name]') .
	    \ ('' != MyModified() ? ' ' . MyModified() : '')
endfunction

function! MyFugitive()
try
    if &ft !~? 'vimfiler\|gundo' && exists('*fugitive#head')
	let _ = fugitive#head()
	return strlen(_) ? ' '._ : ''
    endif
catch
endtry
return ''
endfunction

function! MyFileformat()
return winwidth(0) > 70 ? &fileformat : ''
endfunction

function! MyFiletype()
return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype : 'NONE') : ''
endfunction

function! MyFileencoding()
return winwidth(0) > 70 ? (strlen(&fenc) ? &fenc : &enc) : ''
endfunction

function! MyMode()
return winwidth(0) > 60 ? lightline#mode() : ''
endfunction



let g:indentLine_faster = 1

