
" #AutoSave "{{{
let g:u10_autosave = 0
command! EnableAutoSave let g:u10_autosave = 1
command! DisableAutoSave let g:u10_autosave = 0
nnoremap <silent><F2> :call ToggleAutoSave()<CR>
function! ToggleAutoSave() abort
  silent update
  let g:u10_autosave = !g:u10_autosave
  echo 'autosave' g:u10_autosave? 'enabled' : 'disabled'
endfunction

function! DoAutoSave() abort
  if g:u10_autosave != 0
    silent! update
  endif
endfunction
"}}}

let g:erase_space_on = 1
command! EraseSpace        call EraseSpace()
command! EraseSpaceEnable  let g:erase_space_on=1
command! EraseSpaceDisable let g:erase_space_on=0
function! EraseSpace() abort "{{{
  if g:erase_space_on != 1
    return
  endif

  " filetypeが一致したらreturn
  if index(['markdown', 'gitcommit', 'help'], &filetype) != -1
    return
  endif

  " for vim-precious
  if expand('%') =~# '.md$'
    return
  endif

  let l:cursor = getpos(".")
  %s/\s\+$//e
  call setpos(".", l:cursor)
endfunction "}}}

" #Blank "{{{
nnoremap <silent><Plug>(BlankUp)   :<c-u>call <SID>BlankUp(v:count1)<cr>
nnoremap <silent><Plug>(BlankDown) :<c-u>call <SID>BlankDown(v:count1)<cr>

function! s:BlankUp(count) abort
  put! =repeat(nr2char(10), a:count)
  ']+1
  silent! call repeat#set("\<Plug>(BlankUp)", a:count)
endfunction

function! s:BlankDown(count) abort
  put =repeat(nr2char(10), a:count)
  '[-1
  silent! call repeat#set("\<Plug>(BlankDown)", a:count)
endfunction
"}}}

" #Misc
function! Ruby(str) abort
  return vimrc#capture('ruby ' . a:str)
endfunction

function! ResetHightlights() abort
  " nohlsearch " 関数内では動作しない
  silent! call clever_f#reset()
  silent! LinediffReset
  silent! QuickhlManualReset
  silent! RCReset
  call clearmatches()
endfunction

command! HTMLalign call HTMLalign()
function! HTMLalign() abort
  %s/\v\>\</>\r</
  setfiletype html
  normal gg=G
endfunction

" call from snippets
function! Filename() abort
  return expand('%:t:r')
endfunction

" TODO rubyが動かない -> Vital.Random
function! DummyArray(start, last, times) abort
  return Ruby(printf("print Array.new(%d){ Random.rand(%d..%d)}.join(', ')", a:times, a:start, a:last))
endfunction
