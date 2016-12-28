call denite#custom#var('file_rec', 'command',
    \ ['ag', '--follow', '--nocolor', '--nogroup', '-g', ''])

call denite#custom#source(
    \ 'file_mru', 'matchers', ['matcher_fuzzy', 'matcher_project_files'])

call denite#custom#source('grep', 'matchers',
      \ ['matcher_ignore_globs', 'matcher_cpsm'])
" call denite#custom#source('file_mru', 'converters',
      " \ ['converter_relative_word'])

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
" call denite#custom#map('_', "\<C-f>", 'enter_mode:normal')

call denite#custom#alias('source', 'file_rec/git', 'file_rec')
call denite#custom#var('file_rec/git', 'command',
      \ ['git', 'ls-files', '-co', '--exclude-standard'])

call denite#custom#option('default', 'prompt', '>')

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
      \ '.direnv/*',
      \ 'images/',
      \ '*.min.*',
      \ 'img/', 'fonts/'])
