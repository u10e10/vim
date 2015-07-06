if &compatible
  set nocompatible
endif

function! Source_rc(path)
  execute 'source' fnameescape(expand('~/.vim/rc/' . a:path))
endfunction

function! IsMac()
  return has('mac') || has('macunix') || has('gui_mac')
endfunction

filetype off
filetype plugin indent off
set viminfo+=n~/.vim/tmp/info.txt
set path+=/usr/include/c++/HEAD/

" #base config "{{{
set encoding=utf-8
set number
set cursorline
set nocursorcolumn
set showmatch
set matchtime=1
set laststatus=2
set cmdheight=2
set cmdwinheight=4
set timeout
set ttimeout   " なくても同じ
set timeoutlen=3000
set ttimeoutlen=100
set nobackup
set mouse=a
set showcmd " 入力中のキーマップを表示する
"}}}

" #action config " {{{
set autoindent
set smartindent
set ignorecase
set smartcase
set wrapscan  "最後尾まで検索を終えたら次の検索で先頭に戻る
set backspace=start,eol,indent
set whichwrap=b,s,[,],<,>,~
set matchpairs+=<:>
"set virtualedit=onemore
set wildmenu
set wildmode=longest:full,full
set iskeyword+=$,@-@  "設定された文字が続く限り単語として扱われる @は英数字を表す
set nrformats-=octal  " 加減算で数値を8進数として扱わない
" }}}

" #tab
set expandtab     "Tabキーでスペース挿入
set tabstop=2     "Tab表示幅
set softtabstop=2 "Tab押下時のカーソル移動量
set shiftwidth=2  "インデント幅

" #fold
set foldmethod=marker
set foldlevel=0
set foldnestmax=2
set foldtext=FoldCCtext()

let &clipboard = IsMac()? 'unnamed' : 'unnamedplus'
set nohidden


au BufReadPost  * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
au BufEnter     * lcd %:p:h
au VimResized   * wincmd =

" windowの行数の20%にセットする scrolloffはglobal-option
command! SmartScrolloff let &scrolloff=float2nr(winheight('')*0.2)
au VimEnter * SmartScrolloff
au WinEnter * SmartScrolloff

" #Capture {{{
" cmdをクォートなしでとれる
command! -nargs=+ -bang -complete=command
      \ Capture call Capture(<q-args>)

" cmdをクォートで囲んでとる
function! Capture(cmd)
  redir => l:out
  silent execute a:cmd
  redir END
  let g:capture = substitute(l:out, '\%^\n', '', '')
  return g:capture
endfunction
" }}}

" #Capture New window {{{
command! -nargs=+ -bang -complete=command
      \ CaptureWin call CaptureWin(<q-args>)

function! CaptureWin(cmd)
  redir => result
  silent execute a:cmd
  redir END

  let bufname = 'Capture: ' . a:cmd
  new
  setlocal bufhidden=unload
  setlocal nobuflisted
  setlocal buftype=nofile
  setlocal noswapfile
  silent file `=bufname`
  silent put =result
  1,2delete _
endfunction
" }}}

" #MoveToTab "{{{
command! Movett call s:MoveToTab()
function! s:MoveToTab()
    tab split
    tabprevious

    if winnr('$') > 1
        close
    elseif bufnr('$') > 1
        buffer #
    endif

    tabnext
endfunction
"}}}

" #EraseSpace "{{{
au BufWritePre  * EraseSpace
command! EraseSpace :call EraseSpace()
command! EraseSpaceEnable :let g:erase_space_on=1
command! EraseSpaceDisable :let g:erase_space_on=0
function! EraseSpace()
  if exists("g:erase_space_on") && g:erase_space_on != 1
    return
  endif

  " filetypeが一致したらreturn
  if index(['markdown', 'gitcommit'], &filetype) != -1
    return
  endif

  let l:cursor = getpos(".")
  %s/^\s\+$//ge
  %s/\s\+$//ge
  call setpos(".", l:cursor)
endfunction
"}}}

" #CurrentOnly {{{
" カレントバッファ以外をデリートして、その数を表示する
command! Conly call CurrentOnly()
command! CurrentOnly call CurrentOnly()
function! CurrentOnly()
  Capture buffers

  let l:current=bufnr('%')
  let l:count=0
  for b in split(substitute(g:capture, '\s', '', 'g'), '\n')
    let n = matchstr(b, '^\d*')
    if l:n != l:current
      execute 'bdelete' l:n
      let l:count+=1
    endif
  endfor
  echo l:count "buffer deleted"
endfunction
"}}}

command! BufferCount ruby print VIM::Buffer.count
function! BufferCount()
  return Capture("BufferCount")
endfunction

" #source
source ~/.vim/neobundle.vim
source ~/.vim/keymap.vim
source ~/.vim/filetype.vim

filetype plugin indent on
syntax enable
set t_Co=256
set background=dark

augroup call_functions
  autocmd!
  au FileType * call s:set_colors()
  au FileType * call s:only_once()
  au FileType * call s:set_highlight_sub()
augroup END

" TODO 動作検証
" cmdは文字列とれるようにした方がいいかも
function! OneShotAutocmd(name, event, pattern, cmd) "{{{
  function l:tmp_func()
    {a:cmd}
    autocmd! {a:name}
  endfunction

  augroup a:name
    autocmd!
    autocmd {a:event} {a:pattern} call l:tmp_func()
  augroup END
endfunction "}}}

function! s:set_colors() "{{{
  if exists("g:set_colors")
    return 0
  end

  if &filetype == 'cpp' || &filetype == 'c'
    colorscheme lettuce
    " colorscheme kalisi
  elseif &filetype == 'ruby' || &filetype == 'gitcommit'
    colorscheme railscasts_u10
  elseif &filetype == 'vimfiler'
    " 一度だけ実行するautocmd
    augroup set_airline_color
      autocmd!
      autocmd FileType * colorscheme airline_color | autocmd! set_airline_color
    aug END

    colorscheme vimfiler_color
    return 0
  else
    colorscheme molokai
  endif

  colorscheme vimfiler_color

  let g:set_colors=1
endfunction "}}}

function! s:set_highlight_sub() " {{{
  highlight Search          ctermfg=39 ctermbg=56
  highlight IncSearch       ctermfg=39 ctermbg=50
  highlight Visual          cterm=reverse
  highlight Todo            ctermfg=16 ctermbg=220
  highlight YankRoundRegion cterm=italic
endfunction " }}}

function! s:only_once() "{{{
  if exists("g:only_once")
    return 0
  endif

  SpeedDatingFormat! %v
  SpeedDatingFormat! %^v

  let g:only_once = 1
endfunction "}}}

