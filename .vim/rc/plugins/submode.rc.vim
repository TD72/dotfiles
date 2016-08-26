
" Window size
call submode#enter_with('bufmove', 'n', '', 'sl', '<C-w>>')
call submode#enter_with('bufmove', 'n', '', 'sh', '<C-w><')
call submode#enter_with('bufmove', 'n', '', 'sj', '<C-w>+')
call submode#enter_with('bufmove', 'n', '', 'sk', '<C-w>-')
call submode#map('bufmove', 'n', '', 'l', '<C-w>>')
call submode#map('bufmove', 'n', '', 'h', '<C-w><')
call submode#map('bufmove', 'n', '', 'j', '<C-w>+')
call submode#map('bufmove', 'n', '', 'k', '<C-w>-')


" Tab swith
call submode#enter_with('changetab', 'n', '', 'tl', 'gt')
call submode#enter_with('changetab', 'n', '', 'th', 'gT')
call submode#map('changetab', 'n', '', 'l', 'gt')
call submode#map('changetab', 'n', '', 'h', 'gT')
