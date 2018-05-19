
let s:is_windows = has('win32') || has('win64')

function! IsWindows() abort
  return s:is_windows
endfunction

function! IsMac() abort
  return !s:is_windows && !has('win32unix')
        \ && (has('mac) || has('macunix') || has('gui_macvim')
        \     || (!executeable('xdg-optn') && system('uname') =~? '^darwin'))
endfunction

let g:mapleader = "\<Space>"

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



" Load dein.
let s:dein_dir = finddir('dein.vim', '.;')
if s:dein_dir != '' || &runtimepath !~ '/dein.vim'
    if s:dein_dir == '' && &runtimepath !~ '/dein.vim'
        let s:dein_dir = expand('$CACHE/dein')
                    \. '/repos/github.com/Shougo/dein.vim'

        if !isdirectory(s:dein_dir)
            execute '!git clone https://github.com/Shougo/dein.vim' s:dein_dir
        endif
    endif

    execute 'set runtimepath^=' . fnamemodify(s:dein_dir, ':p')
endif

" Disable packpath
set packpath=

let g:loaded_gzip              = 0
let g:loaded_tar               = 0
let g:loaded_tarPlugin         = 0
let g:loaded_zip               = 0
let g:loaded_zipPlugin         = 0
let g:loaded_rrhelper          = 0
let g:loaded_2html_plugin      = 0
let g:loaded_vimball           = 0
let g:loaded_vimballPlugin     = 0
let g:loaded_getscript         = 1
let g:loaded_getscriptPlugin   = 1
let g:loaded_netrw             = 0
let g:loaded_netrwPlugin       = 0
let g:loaded_netrwSettings     = 0
let g:loaded_netrwFileHandlers = 0
let g:loaded_matchparen        = 1
let g:loaded_LogiPat           = 0
let g:loaded_logipat           = 0
let g:loaded_tutor_mode_plugin = 0
let g:loaded_spellfile_plugin  = 1
let g:loaded_man               = 1
let g:loaded_matchit           = 1
