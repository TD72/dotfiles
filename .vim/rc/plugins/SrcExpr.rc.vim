nnoremap [srce]u :call g:SrcExpl_UpdateTags()<CR>
nnoremap [srce]a :call g:SrcExpl_UpdateAllTags()<CR>
nnoremap [srce]n :call g:SrcExpl_NextDef()<CR>
nnoremap [srce]p :call g:SrcExpl_PrevDef()<CR>

let g:SrcExpl_pluginList = [
            \ '_Vim_Filer_',
            \ '_Vim_Shell_'
            \ ]
" When move the cursor.
let g:SrcExpl_RefreshTime=1000
" Auto update
let g:SrcExpl_isUpdateTags=0
" Refer to only opened file now.
" let g:SrcExpl_updateTagsCmd='ctags --sort=foldcase %'
" Conflict key mapping.
let g:SrcExpl_gobackKey = '<Nop>' 
