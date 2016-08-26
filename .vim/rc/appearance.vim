set t_Co=256
syntax enable

let g:solarized_termtrans=1
let g:solarized_termcolors=16
let g:solarized_bold=1
let g:solarized_italic=1
let g:solarized_underline=1
let g:solarized_visibility="normal"
let g:solarized_contrast="normal"
colorscheme solarized
set background=dark

" if exists('g:nyaovim_version')
    " colorscheme molokai
" endif


" colorscheme molokai

set guifont=Ricty\ for\ Powerline\ Regular\ 12
set guifontwide=Ricty\ for\ Powerline\ Regular\ 12

" Row Number display & highlight
set number
set cursorline

" Matchpairs highlight and flashing per a second.
set matchpairs& matchpairs+=<:>
set showmatch
set matchtime=1
" Display the input commands.
set showcmd
set cmdheight=2

" Secure the top and bottom view.
set scrolloff=20
set laststatus=2

let g:tex_conceal=''
let g:tex_flavor='latex'



" Anywhere SID.
function! s:SID_PREFIX()
    return matchstr(expand('<sfile>'), '<SNR>\d\+_\zeSID_PREFIX$')
endfunction

" Set tabline.
function! s:my_tabline()  
    let s = ''
    for i in range(1, tabpagenr('$'))
        let bufnrs = tabpagebuflist(i)
        let bufnr = bufnrs[tabpagewinnr(i) - 1]  " first window, first appears
        let no = i  " display 0-origin tabpagenr.
        let mod = getbufvar(bufnr, '&modified') ? '!' : ' '
        let title = fnamemodify(bufname(bufnr), ':t')
        let title = '[' . title . ']'
        let s .= '%'.i.'T'
        let s .= '%#' . (i == tabpagenr() ? 'TabLineSel' : 'TabLine') . '#'
        let s .= no . ':' . title
        let s .= mod
        let s .= '%#TabLineFill# '
    endfor
    let s .= '%#TabLineFill#%T%=%#TabLine#'
    return s
endfunction 
let &tabline = '%!'. s:SID_PREFIX() . 'my_tabline()'

set showtabline=2
