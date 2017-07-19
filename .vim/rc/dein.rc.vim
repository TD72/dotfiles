" dein configurations.

let g:dein#install_progress_type = 'title'
" let g:dein#install_message_type = 'none'
let g:dein#enable_notification = 1
let g:dein#notification_icon = '~/.config/nvim/rc/signs/warn.png'


let s:path = expand('$CACHE/dein')
if !dein#load_state(s:path)
    finish
endif


call dein#begin(s:path, [expand('<sfile>')]
        \ + split(glob('~/.config/nvim/rc/*.toml'), '\n'))

call dein#load_toml('~/.config/nvim/rc/dein.toml', {'lazy': 0})
call dein#load_toml('~/.config/nvim/rc/deinlazy.toml', {'lazy': 1})
if has('nvim')
    call dein#load_toml('~/.config/nvim/rc/deineo.toml', {})
endif
call dein#load_toml('~/.config/nvim/rc/deinft.toml')
call dein#end()

call dein#save_state()

if has('vim_starting') && dein#check_install(['vimproc'])
    call dein#install(['vimproc'])
endif

if has('vim_starting') && dein#check_install()
    call dein#install()
endif


