
let s:is_windows = has('win32') || has('win64')

function! IsWindows() abort
  return s:is_windows
endfunction


let mapleader = "\<Space>"

" Release keymappings for plug-in.
nnoremap ;  <Nop>
xnoremap ;  <Nop>
nnoremap m  <Nop>
xnoremap m  <Nop>
nnoremap ,  <Nop>
xnoremap ,  <Nop>


if IsWindows()
  set shellslash
endif

let $CACHE = expand('~/.cache')

if !isdirectory(expand($CACHE))
    call mkdir(expand($CACHE), 'p')
endif

" release autogroup in Myautocmd
augroup MyAutoCmd
    autocmd!
augroup END


" Load dein.
let s:dein_dir = finddir('dein.vim', '.;')
if s:dein_dir != '' || &runtimepath !~ '/dein.vim'
    if s:dein_dir == '' && &runtimepath !~ '/dein.vim'
        let s:dein_dir = expand('$CACHE/dein')
                    \. '/repos/repos/github.com/Shougo/dein.vim'

        if !isdirectory(s:dein_dir)
            execute '!git clone https://github.com/Shougo/dein.vim' s:dein_dir
        endif
    endif

    execute 'set runtimepath^=' . fnamemodify(s:dein_dir, ':p')
endif
