augroup my_filetypedetect
  au!
  au BufRead,BufNewFile $ZSH_DOT_DIR/* lcd %:h
  au BufRead,BufNewFile $HOME/Documents/notes/* setf note | lcd %:h
  au BufRead * if isdirectory(expand('%')) | setf vimfiler | endif
  au VimEnter * if &l:ft == '' | filetype detect | endif

  " for ftplugin.toml
  au FileType toml if expand('%:p') =~# expand('~/.vim') |
        \ let b:context_filetype_filetypes = {'toml': [ 
        \   { 'start': '\s*=\s*\('."'''".'\|"""\)',  
        \     'end': '\1', 'filetype': 'vim', },  
        \ ]} |
        \ endif
augroup END
