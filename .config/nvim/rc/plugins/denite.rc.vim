if executable('rg')
  call denite#custom#var('file/rec', 'command',
        \ ['rg', '--files', '--glob', '!.git'])
  call denite#custom#var('grep', 'command', ['rg', '--threads', '1'])
  call denite#custom#var('grep', 'recursive_opts', [])
  call denite#custom#var('grep', 'final_opts', [])
  call denite#custom#var('grep', 'separator', ['--'])
  call denite#custom#var('grep', 'default_opts',
        \ ['--vimgrep', '--no-heading'])
else
  call denite#custom#var('file/rec', 'command',
        \ ['ag', '--follow', '--nocolor', '--nogroup', '-g', ''])
endif

call denite#custom#source('file/old', 'matchers',
      \ ['matcher/fuzzy', 'matcher/project_files'])
call denite#custom#source('tag', 'matchers', ['matcher/substring'])
if has('nvim')
  call denite#custom#source('file/rec,grep', 'matchers',
        \ ['matcher/cpsm'])
endif
call denite#custom#source('file/old', 'converters',
      \ ['converter/relative_word'])


call denite#custom#map('insert', '<C-a>', '<Home>')
call denite#custom#map('insert', '<C-e>', '<End>')
call denite#custom#map('insert', '<C-f>', '<Right>')

call denite#custom#map('insert', '<C-b>', '<Left>')
call denite#custom#map('insert', "'", '<denite:enter_mode:normal>')
call denite#custom#map('normal', 'r', '<denite:do_action:quickfix', 'noremap')

call denite#custom#map('normal', '<C-n>', '<denite:move_to_next_line>')
call denite#custom#map('normal', '<C-p>', '<denite:move_to_previous_line>')
call denite#custom#map('insert', '<C-n>', '<denite:move_to_next_line>')
call denite#custom#map('insert', '<C-p>', '<denite:move_to_previous_line>')


call denite#custom#map('insert', '<C-r>',
      \ '<denite:toggle_matchers:matcher_substring>', 'noremap')
call denite#custom#map('insert', '<C-s>',
      \ '<denite:toggle_sorters:sorter_reverse>', 'noremap')

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

call denite#custom#alias('source', 'file/rec/git', 'file/rec')
call denite#custom#var('file/rec/git', 'command',
      \ ['git', 'ls-files', '-co', '--exclude-standard'])


call denite#custom#option('default', {
      \ 'auto_accel': 1,
      \ 'prompt: ': '>',
      \ 'short_source_names': 1
      \ })

let s:menus = {}
let s:menus.vim = {
    \ 'description': 'Vim',
    \ }
let s:menus.vim.file_candidates = [
    \ ['    > Edit configuation file (init.vim)', '~/.config/nvim/init.vim']
    \ ]
call denite#custom#var('menu', 'menus', s:menus)

call denite#custom#filter('matcher/ignore_globs', 'ignore_globs',
      \ [
      \ '.git/', '.ropeproject/', '__pycache__/',
      \ 'venv/',
      \ 'vender/',
      \ '.direnv/*',
      \ 'images/',
      \ '*.min.*',
      \ 'img/', 'fonts/'])
