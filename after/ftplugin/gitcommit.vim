
setl spell
setl nofoldenable
setl foldcolumn=0
setl textwidth=0
" after InsertEnter for committia.vim
au InsertEnter * setl lazyredraw
nnoremap <silent><buffer>a gga
nnoremap <silent><buffer>A ggA
nnoremap <silent><buffer>i ggi
nnoremap <silent><buffer>I ggI
nnoremap <silent><buffer>c ggc
nnoremap <silent><buffer>d ggd
goto
