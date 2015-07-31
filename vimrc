" Note: Skip initialization for vim-tiny or vim-small.
if 0 | endif

if &compatible
  set nocompatible
endif

function! IsMac()
  return (has('mac') || has('macunix') || has('gui_macvim') ||
        \   (!executable('xdg-open') && system('uname') =~? '^darwin'))
endfunction

function! s:source_rc(path)
  execute 'source' fnameescape(expand('~/.vim/rc/' . a:path))
endfunction

augroup uAutoCmd
  autocmd!
augroup END

command! -nargs=1 Source
      \ execute 'source' expand('~/.vim/' . <args> . '.vim')

let $CACHE = expand('~/.cache')
set viminfo+=n~/.vim/tmp/info.txt
set undodir=~/.vim/tmp/undo.txt
set path+=/usr/include/c++/HEAD/

if filereadable(expand('~/.vimrc_local_before'))
  source $HOME/.vimrc_local_before
endif

" #Release keymaps"{{{
let mapleader = ";"
nnoremap Q <Nop>
nnoremap ; <Nop>
xnoremap ; <Nop>
nnoremap , <Nop>
xnoremap , <Nop>
nnoremap s <Nop>
xnoremap s <Nop>
nnoremap gs <Nop>
xnoremap gs <Nop>
nnoremap gr <Nop>
xnoremap gr <Nop>
nnoremap gR <Nop>
xnoremap gR <Nop>
nnoremap gh <Nop>
xnoremap gh <Nop>
nnoremap gm <Nop>
xnoremap gm <Nop>
nnoremap g8 <Nop>
xnoremap g8 <Nop>
nnoremap g<C-G> <Nop>
xnoremap g<C-G> <Nop>
nnoremap g<C-A> <Nop>
xnoremap g<C-A> <Nop>
"}}}

Source 'neobundle'
filetype plugin indent on
syntax enable

if has('vim_starting')
  NeoBundleCheck
endif

language message C
scriptencoding=utf-8
set encoding=utf-8
set fileformats=unix,dos,mac
" set fileencodings=ucs-bom,utf-8,iso-2022-jp-3,iso-2022-jp,eucjp-ms,euc-jisx0213,euc-jp,sjis,cp932

" set undofile
set report=0  " コマンドで0行以上変更されたらmessage
set number
set hidden
set showcmd
set cursorline
set showmatch
set matchtime=0 " 括弧を入力した時に移動しないようにする
set laststatus=2
set cmdheight=2 cmdwinheight=4
set mouse=a
set nobackup
set modeline
set cedit=<C-L> " move to cmdwin key

set nowrap
set sidescroll=1
set sidescrolloff=12

" Keymapping timeout.
set timeout timeoutlen=3000 ttimeoutlen=100
" CursorHold time.
set updatetime=1000

set autoindent smartindent
set ignorecase smartcase

set backspace=start,eol,indent
set whichwrap=b,s,[,],<,>
set matchpairs+=<:>
set iskeyword+=$,@-@  "設定された文字が続く限り単語として扱われる @は英数字を表す

" Enable virtualedit in visual block mode.
set virtualedit=block

" #menu
set wildmenu
set wildmode=longest:full,full
set nrformats-=octal  " 加減算で数値を8進数として扱わない

" #search
set incsearch
set hlsearch | nohlsearch "Highlight search patterns, support reloading

" #tab
set shiftround
set expandtab     "Tabキーでスペース挿入
set tabstop=2     "Tab表示幅
set softtabstop=2 "Tab押下時のカーソル移動量
set shiftwidth=2  "インデント幅
" set smarttab

" #fold
set foldmethod=marker
set foldcolumn=1
set foldtext=FoldCCtext()
set foldlevel=0     " どのレベルから折りたたむか
set foldnestmax=2   " どの深さまで折りたたむか
" set foldenable
" set foldclose=all " 折りたたんでるエリアからでると自動で閉じる

" set list
set listchars=tab:❯\ ,trail:˼,extends:»,precedes:«,nbsp:%

let &clipboard = IsMac()? 'unnamed' : 'unnamedplus'
set cpoptions-=m

set t_Co=256
set background=dark

" Change cursor shape.
if &term =~ "xterm"
  let &t_SI = "\<Esc>]12;lightgreen\x7"
  let &t_EI = "\<Esc>]12;white\x7"
endif

Source 'function'
Source 'keymap'

" #auto commands
au uAutoCmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
au uAutoCmd VimEnter    * if argc() == 1 | lcd %:p:h | endif
au uAutoCmd VimResized  * wincmd =

" windowの行数の20%にセットする scrolloffはglobal-option
command! SmartScrolloff let &scrolloff=float2nr(winheight('')*0.2)
au uAutoCmd VimEnter * SmartScrolloff
au uAutoCmd WinEnter * SmartScrolloff

" _を除くと*での検索がやりずらい
au uAutoCmd FileType vim setl iskeyword-=#
au uAutoCmd FileType * setl formatoptions-=ro
" r When type <return> in insert-mode auto insert commentstring
" o	ノーマルモードで'o'、'O'を打った後に、現在のコメント指示を自動的に挿入する。

au uAutoCmd FileType * nested call s:set_colors()
au uAutoCmd ColorScheme * call s:set_highlights()
"au uAutoCmd CursorMoved * nohlsearch

function! s:set_colors() "{{{
  if exists("g:set_colors")
    return
  end

  if &filetype == 'cpp' || &filetype == 'c'
    colorscheme lettuce
    " colorscheme kalisi
  elseif &filetype == 'ruby' || &filetype == 'gitcommit'
    colorscheme railscasts_u10
  elseif &filetype == 'vimfiler'
    let g:set_airline_color = 1
    return
  else
    colorscheme molokai
  endif

  let g:set_colors=1
endfunction "}}}

function! s:set_highlights() "{{{
  hi Visual  cterm=reverse
  hi Todo    ctermfg=201     ctermbg=56
  hi QFError cterm=undercurl ctermfg=198
  colorscheme vimfiler_color

  if exists("g:set_airline_color") && g:set_airline_color
   colorscheme airline_color
  endif
endfunction "}}}

" each filetype config
au uAutoCmd FileType c,cpp,ruby,zsh,php,perl set cindent
au uAutoCmd FileType c,cpp set commentstring=//\ %s
au uAutoCmd FileType html,css set foldmethod=indent
au uAutoCmd FileType diff nnoremap <silent><buffer> q :q<CR>

au uAutoCmd FileType help call s:help_config()
function! s:help_config()
  nnoremap <silent><buffer> q :q<CR>
  setlocal foldmethod=indent
  setlocal number
endfunction

" u10 autosave "{{{
let g:u10_autosave = 0
command! U10AutoSave let g:u10_autosave = !g:u10_autosave | echo "autosave" g:u10_autosave? "enabled" : "disabled"
nnoremap <silent><buffer> <F2> :U10AutoSave<CR>
au uAutoCmd InsertLeave,TextChanged * nested if g:u10_autosave != 0 | write | endif
"}}}

if filereadable(expand('~/.vimrc_local_after'))
  source $HOME/.vimrc_local_after
endif

