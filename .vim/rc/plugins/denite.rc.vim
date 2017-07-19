if executable('rg')
  call denite#custom#var('file_rec', 'command',
        \ ['rg', '--files', '--glob', '!.git'])
  call denite#custom#var('grep', 'command', ['rg', '--threads', '1'])
  call denite#custom#var('grep', 'recursive_opts', [])
  call denite#custom#var('grep', 'final_opts', [])
  call denite#custom#var('grep', 'separator', ['--'])
  call denite#custom#var('grep', 'default_opts',
        \ ['--vimgrep', '--no-heading'])
else
  call denite#custom#var('file_rec', 'command',
        \ ['ag', '--follow', '--nocolor', '--nogroup', '-g', ''])
endif

call denite#custom#source('file_old', 'matchers',
      \ ['matcher_fuzzy', 'matcher_project_files'])
call denite#custom#source('tag', 'matchers', ['matcher_substring'])
if has('nvim')
  call denite#custom#source('file_rec,grep', 'matchers',
        \ ['matcher_cpsm'])
endif
call denite#custom#source('file_old', 'converters',
      \ ['converter_relative_word'])


call denite#custom#map(
      \ 'insert',
      \ '<C-n>',
      \ '<denite:move_to_next_line>',
      \ 'noremap')

call denite#custom#map(
      \ 'insert',
      \ '<C-p>',
      \ '<denite:move_to_previous_line>',
      \ 'noremap')

call denite#custom#map('insert', '<C-a>', '<Home>')
call denite#custom#map('insert', '<C-e>', '<End>')
call denite#custom#map('insert', '<C-f>', '<Right>')

call denite#custom#map('insert', '<C-b>', '<Left>')
call denite#custom#map('insert', "'", '<denite:enter_mode:normal>')
call denite#custom#map('normal', 'n', '<denite:move_to_next_line')
call denite#custom#map('normal', 'p', '<denite:move_to_previous_line')
call denite#custom#map('normal', 'r', '<denite:do_action:quickfix', 'noremap')

call denite#custom#alias('source', 'file_rec/git', 'file_rec')
call denite#custom#var('file_rec/git', 'command',
      \ ['git', 'ls-files', '-co', '--exclude-standard'])

" Denite git
call denite#custom#map(
      \ 'normal',
      \ 'a',
      \ '<denite:do_action:add>',
      \ 'noremap'
      \)

call denite#custom#map(
      \ 'normal',
      \ 'd',
      \ '<denite:do_action:delete>',
      \ 'noremap'
      \)

call denite#custom#map(
      \ 'normal',
      \ 'r',
      \ '<denite:do_action:reset>',
      \ 'noremap'
      \)

call denite#custom#option('default', {
      \ 'prompt: ': '>', 'short_source_names': 1
      \ })

let s:menus = {}
let s:menus.vim = {
    \ 'description': 'Vim',
    \ }
let s:menus.vim.file_candidates = [
    \ ['    > Edit configuation file (init.vim)', '~/.config/nvim/init.vim']
    \ ]
call denite#custom#var('menu', 'menus', s:menus)

call denite#custom#filter('matcher_ignore_globs', 'ignore_globs',
      \ [
      \ '.git/', '.ropeproject/', '__pycache__/',
      \ 'venv/',
      \ 'vender/',
      \ '.direnv/*',
      \ 'images/',
      \ '*.min.*',
      \ 'img/', 'fonts/'])
