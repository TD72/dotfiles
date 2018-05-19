" Swap ';' and ':' 
nnoremap ; :
nnoremap : ;

" jk key is mapped <Esc> on insert mode.
inoremap jj <Esc>
inoremap j<Space> j

nnoremap > >>
nnoremap < <<
xnoremap > >gv
xnoremap < <gv

" emacs bind on insert mode
inoremap <C-h> <BS>
inoremap <C-b> <LEFT>
inoremap <C-l> <RIGHT>
inoremap <C-f> <RIGHT>
inoremap <C-a> <HOME>
inoremap <C-e> <END>
inoremap <C-d> <DELETE>

" vv select to end line.
vnoremap v $h

" Jumping to matchpair.
nnoremap <Tab> %
vnoremap <Tab> %

" Window:
nnoremap s <Nop>
" split
nnoremap ss :split<CR>
nnoremap sv :vsplit<CR>
nnoremap st :tabnew<CR>
nnoremap sp :tabnext<CR>
" nnoremap <C-l> :tabnext<CR>
nnoremap sn :tabprevious<CR>
" nnoremap <C-h> :tabprevious<CR>
nnoremap sw :tabclose<CR>

nmap sj <SID>(split-to-j)
nmap sk <SID>(split-to-k)
nmap sh <SID>(split-to-h)
nmap sl <SID>(split-to-l)
nnoremap <SID>(split-to-j) :<C-u>execute 'belowright' (v:count == 0 ? '' : v:count) 'split'<CR>
nnoremap <SID>(split-to-k) :<C-u>execute 'aboveleft'  (v:count == 0 ? '' : v:count) 'split'<CR>
nnoremap <SID>(split-to-h) :<C-u>execute 'topleft'    (v:count == 0 ? '' : v:count) 'vsplit'<CR>
nnoremap <SID>(split-to-l) :<C-u>execute 'botright'   (v:count == 0 ? '' : v:count) 'vsplit'<CR>

inoremap {{ {}<LEFT>
inoremap [[ []<LEFT>
inoremap (( ()<LEFT>
inoremap "" ""<LEFT>
inoremap '' ''<LEFT>
inoremap %% %%<LEFT>


" Clipboad:
set clipboard+=unnamedplus
vnoremap <Leader>y "+y
nnoremap <Leader>Y "+yg_
nnoremap <Leader>y "+y
nnoremap <Leader>yy "+yy
nnoremap <Leader>p "+p
nnoremap <Leader>P "+P
vnoremap <Leader>p "+p
vnoremap <Leader>P "+P

nmap gp <SID>(revisual-pasted)
nnoremap <expr> <SID>(revisual-pasted) '`[' . strpart(getregtype(), 0, 1) . '`]'

" Toggle Paste Mode
nnoremap <silent> ,p :<C-u>set paste!<CR>
            \:<C-u>echo("Toggle PasteMode => " . (&paste == 0 ? "off" : "On"))<CR>


" Commandline:
cnoremap <C-n> <DOWN>
cnoremap <C-p> <UP>
cnoremap <C-b> <LEFT>
cnoremap <C-f> <RIGHT>
cnoremap <C-h> <BS>
cnoremap <C-d> <DELETE>
cnoremap <C-a> <HOME>
cnoremap <C-e> <END>

" Search:

" Stop highlight.
nnoremap <silent> <Esc><Esc> :nohlsearch<CR>

" '*' search a term under the cursor.
vnoremap <silent> * "vy/\v<C-r>=substitute(escape(@v, '\/'), "\n", '\\n', 'g')<C

" All Indent
nnoremap <Leader>= ggvG=

" Change current word and repeatable
nnoremap cn *``cgn
nnoremap cN *``cgN
vnoremap <expr> cn "y/\\V\<C-r>=escape(@\", '/')\<CR>\<CR>" . "``cgn"
vnoremap <expr> cN "y/\\V\<C-r>=escape(@\", '/')\<CR>\<CR>" . "``cgN"


" ESC fcitx OFF
" function! ImInActivate()
"     call system('fcitx-remote -c')
" endfunction
" inoremap <silent> <ESC> <ESC>:call ImInActivate()<CR>

