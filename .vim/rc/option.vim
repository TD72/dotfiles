" Enable mouse controll.
set mouse=a
"" encofing
set encoding=utf-8
set fileformat=unix
set fileformats=unix,dos,mac
set fileencodings=utf-8,iso-2022-jp,cp932,sjis,euc-jp

set autoindent
set smartindent
set expandtab
set shiftwidth=4
set tabstop<
set softtabstop=4
set smarttab

" modeline ex) vim: fenc=utf-8
set modeline

set autoread
set autowrite

" use opened buffer, instead of  open new file
set switchbuf=useopen

" fast escape
set timeout timeoutlen=1000 ttimeoutlen=75

" w!! save file as SuperUser.
cnoreabbrev  w!! w !sudo tee > /dev/null %


if (!has('nvim') || $DISPLAY != '') && has('clipboard')
  if has('unnamedplus')
    set clipboard& clipboard+=unnamedplus
  else
    set clipboard& clipboard+=unnamed
  endif
endif

" Search:
" Doesn't tell uppercase apart lowercase.
set ignorecase
" If use a uppercase, tell uppercase apart lowercase.
set smartcase
" Highlight texts, matching search pattern.
set hlsearch
" incremental search
set incsearch



set viminfo+=n~/.cache/vim/viminfo

" Folding
set foldenable
set foldmethod=marker
set foldlevel=0
set foldcolumn=1
set fillchars=vert:\|
set commentstring=%s

" wrap
set wrap
set linebreak
set showbreak=+\ 
set breakat=\ \ ;:,!?
set breakindent

set hidden

" Octal notation -> Demical Number
set nrformats=alpha,hex

set wildmenu
set wildmode=list:longest,full

" Completion setting.
set completeopt=menuone
" Don't complete from other buffer.
set complete=.

set iminsert=0 imsearch=0
set noimcmdline

set ttyfast

set display=lastline
set previewheight=8
set helpheight=12
set conceallevel=2 concealcursor=niv
set colorcolumn=79
set synmaxcol=200

autocmd MyAutoCmd BufNewFile,BufRead .tmux.conf setf tmux
autocmd MyAutoCmd BufNewFile,BufRead .envrc setf sh
autocmd MyAutoCmd BufNewFile,BufRead *.fish setf fish


" Restore Position:
" When open a file, move the cursor to last position.
autocmd MyAutoCmd BufReadPost *
            \ if line("'\'") > 0 && line("'\'") <= line("$") | 
            \   exe "normal g`\"" | 
            \ endif

" Auto mkdir:
" When open a file, auto make a directory if doesn't exist a directory.
function! s:mkdir(dir, force)
    if !isdirectory(a:dir) && (a:force ||
                \ input(printf('"%s" does not exist. Create? [y/N]',
                \ a:dir)) =~? '^y\%[es]$')
        call mkdir(iconv(a:dir, &encoding, &termencoding), 'p')
    endif
endfunction
autocmd MyAutoCmd BufWritePre * call s:mkdir(expand('<afile>:p:h'), v:cmdbang)

" BackUp:
set swapfile
let $SWAP = expand('~/.cache/vim/.swap')
set directory=$SWAP
if !isdirectory(expand($SWAP))
    call mkdir(expand($SWAP), 'p')
endif
" open as readonly when open swapfile.
autocmd MyAutoCmd SwapExists * let v:swapchoice = 'o'

" Persistent Undo:
if has('persistent_undo')
    set undodir=~/.cache/vim/undo
    set undofile
endif

" Google Suggest:
set completefunc=GoogleComplete
function! GoogleComplete(findstart, base)
    if a:findstart
        let line = getline('.')
        let start = col('.') - 1
        while start > 0 && line[start - 1] =~ '\S'
            let start -= 1
        endwhile
        return start
    else
        let ret = system('curl -s -G --data-urlencode "q='
                    \ . a:base . '" "http://suggestqueries.google.com/complete/search?&client=firefox&hl=ja&ie=utf8&oe=utf8"')
        let res = split(substitute(ret,'\[\|\]\|"',"","g"),",")
        return res
    endif
endfunction
