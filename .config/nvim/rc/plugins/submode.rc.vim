
" Window size
call submode#enter_with('bufmove', 'n', '', 'sL', '<C-w>>')
call submode#enter_with('bufmove', 'n', '', 'sH', '<C-w><')
call submode#enter_with('bufmove', 'n', '', 'sJ', '<C-w>+')
call submode#enter_with('bufmove', 'n', '', 'sK', '<C-w>-')
call submode#map('bufmove', 'n', '', 'L', '<C-w>>')
call submode#map('bufmove', 'n', '', 'H', '<C-w><')
call submode#map('bufmove', 'n', '', 'L', '<C-w>+')
call submode#map('bufmove', 'n', '', 'K', '<C-w>-')


" Tab swith
call submode#enter_with('changetab', 'n', '', 'sp', 'gt')
call submode#enter_with('changetab', 'n', '', 'sn', 'gT')
call submode#map('changetab', 'n', '', 'p', 'gt')
call submode#map('changetab', 'n', '', 'n', 'gT')
