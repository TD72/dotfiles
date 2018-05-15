set t_Co=256
syntax enable

set termguicolors
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
let g:solarized_visibility="low"
let g:solarized_diffmode = "bold"
let g:solarized_termtrans=1
let g:solarized_statusline = "normal"
let g:solarized_term_italic=1
let g:solarized_extra_hi_groups = 1
let g:solarized_use16 = 0
set background=dark
colorscheme solarized8_flat

" if exists('g:nyaovim_version')
    " colorscheme molokai
" endif


" colorscheme molokai

set guifont=Ricty\ for\ Powerline\ Regular\ 12
set guifontwide=Ricty\ for\ Powerline\ Regular\ 12

" Row Number display & highlight
" set number
" set cursorline

set synmaxcol=200

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
