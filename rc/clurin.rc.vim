" http://qiita.com/syngan/items/0dd647e0f08557bbd633
" https://github.com/syngan/vim-clurin

" match order
" 1. g:clurin[&filetype]
" 2. g:clurin['-']
" 3. clurin.vim デフォルトの &filetype 用定義
" 4. clurin.vim デフォルト定義 (-)

" search order
" 1. g:clurin[&filetype]
" 2. g:clurin['-']
" 3. clurin.vim デフォルトの &filetype 用定義
" 4. clurin.vim デフォルト定義 (-)


" replaceは引数3つ
function! g:CountUp(str, cnt, def) abort
  " a:str: matched_text
  " a:cnt: non zero.
  " a:def: definition
  return str2nr(a:str) + a:cnt
endfunction

" nomatchは引数1つ
function! g:CtrlAX(cnt) abort
	if a:cnt >= 0
		execute 'normal!' a:cnt . "\<C-A>"
	else
		execute 'normal!' (-a:cnt) . "\<C-X>"
	endif
endfunction

function g:RubyBlockOneline(str, cnt, def) abort
  s/\v\s*do\s*(\|.*\|)?\_s*(.*)\_s*end/{\1 \2}
endfunction

function g:RubyBlockMultiline(str, cnt, def) abort
  let save_pos = getpos('.')
  " s/\v\s*do\s*(\|.*\|)?\_s*(.*)\_s*end/{\1 \2}
  " \1周りのスペースは=regで対応?
  s/\v\s*\{(\|.*\|)?\_s*(.*)\_s*\}$/ do \1\r\2\rend
  call setpos('.', save_pos)
endfunction

let g:clurin = {
      \ '-': {'def': [
      \   ['true', 'false'], ['on', 'off'], ['enable', 'disable'],
      \   ['&&', '||'], ['yes', 'no'], ['Left', 'Right'], ['Up', 'Down'],
      \   [' < ', ' > '], [' <= ', ' >= '], [' == ', ' != '],
      \   ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'],
      \   ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'],
      \   ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday'],
      \   [{'pattern': '\v''([^'']+)''', 'replace': '''\1'''},
      \    {'pattern': '\v"([^"]+)"', 'replace': '"\1"'},],
      \ ], 'use_default': 0},
      \
      \ 'markdown': {'def': [
      \   ['[ ]', '[x]'],
      \   ['#', '##', '###', '####', '#####', ],
      \   ["-", "\t-", "\t\t-", "\t\t\t-", ],
      \   ["+", "\t+", "\t\t+", "\t\t\t+", ],
      \ ]},
      \
      \ 'gitrebase': {'def': [
      \   [ 'pick', 'reword', 'edit', 'squash', 'fixup', 'exec'],
      \ ]},
      \
      \ 'toml': {'def': [
      \   ['hook_add', 'hook_source', 'hook_post_source'],
      \   [{'pattern': '\v''(.+)''$', 'replace': "'''\\1'''" },],
      \ ]},
      \
      \ 'vim': {'def': [
      \   ['echo ', 'echomsg '],
      \   ['nnoremap ', 'nmap '],
      \   ['inoremap ', 'imap '],
      \   ['cnoremap ', 'cmap '],
      \   ['xnoremap ', 'xmap '],
      \   ['BufWritePre', 'BufWritePost', 'BufWriteCmd'],
      \   ['BufReadPre', 'BufReadPost', 'BufReadCmd'],
      \   ['==#', '!=#' ],
      \   ['==?', '!=?' ],
      \   ['=~#', '!~#' ],
      \   ['=~?', '!~?' ],
      \   ['if', 'elseif', 'else'],
      \   [{'pattern': '\[''\(\k\+\)''\]', 'replace': '[''\1'']'},
      \    {'pattern': '\["\(\k\+\)"\]',   'replace': '["\1"]'},
      \    {'pattern': '\.\(\k\+\)',       'replace': '.\1'}],
      \ ]},
      \
      \ 'cpp': {'def': [
      \   [{'pattern': '\(\k\+\)\.', 'replace': '\1.'},
      \    {'pattern': '\(\k\+\)->', 'replace': '\1->'}],
      \ ]},
      \
      \ 'ruby': {'def': [
      \   [{'pattern': '\v:(\k+)\s*\=\>\s*', 'replace': ':\1 => '},
      \    {'pattern': '\v(\k+)\:\s*', 'replace': '\1: '},
      \   ],
      \   [{'pattern': '\v"(\w+)"', 'replace': '"\1"'},
      \    {'pattern': '\v''(\w+)''', 'replace': '''\1'''},
      \    {'pattern': '\v:(\w+)@>(\s+\=\>)@!', 'replace': ':\1'}],
      \   {'quit': 1, 'group': [
      \     {'pattern': '\v\s*do\s*(\|.*\|)?', 'replace': function('g:RubyBlockMultiline')},
      \     {'pattern': '\v\s*\{(\|.*\|)?\_s*.*\_s*\}$', 'replace': function('g:RubyBlockOneline')},
      \   ]},
      \   [{'pattern': '\vlambda\s*\{%(\|(.*)\|)?\s*(.*)\s*\}', 'replace': 'lambda{|\1| \2}'},
      \    {'pattern': '\v-\>\s*\((.*)\)\s*\{\s*(.*)\s*\}', 'replace': '->(\1){ \2}'},
      \    {'pattern': '\vproc\s*\{%(\|(.*)\|)?\s*(.*)\s*\}', 'replace': 'proc{|\1| \2}'},
      \   ],
      \   ['if', 'unless' ],
      \   ['while', 'until' ],
      \   ['.blank?', '.present?' ],
      \   ['include', 'extend' ],
      \   ['class', 'module' ],
      \   ['.inject', '.reject' ],
      \   ['.map', '.map!' ],
      \   ['.sub', '.sub!', '.gub', '.gub!' ],
      \   ['.clone', '.dup' ],
      \   ['.any?', '.none?' ],
      \   ['.all?', '.one?' ],
      \   ['p ', 'puts ', 'print '],
      \   ['attr_accessor', 'attr_reader', 'attr_writer' ],
      \   ['File.exist?', 'File.file?', 'File.directory?' ],
      \ ]},
      \
      \ 'zsh': {'def': [
      \   ['chpwd', 'periodic', 'precmd', 'preexec', 'zshaddhistory', 'zshexit', 'zsh_directory_name'],
      \ ]},
      \
      \ 'zsh sh': {'def':[
      \   ['if', 'elif', 'else'],
      \   [' -a ', ' -o '],
      \   [' -z ', ' -n '],
      \   [' -eq ', ' -ne '],
      \   [' -lt ', ' -le ', ' -gt ', ' -ge '],
      \   [' -e ', ' -f ', ' -d '],
      \   [' -r ', ' -w ', ' -x '],
      \   [{'pattern': '\v\$(\w+)', 'replace': '$\1'},
      \    {'pattern': '\V"\@<!${\(\w\+\)}"\@!', 'replace': '${\1}'},
      \    {'pattern': '\V"${\(\w\+\)}"', 'replace': '"${\1}"'},],
      \ ]},
      \ }

" TODO ruby(:a => b, a: file)配置順序注意
" 改行が含まれてたらsplitしてリストを渡せばいいかも
  " appendと違って置換されてしまう

" 改行するときは関数を呼ぶ?
" 複数のファイルタイプに同じ設定はできない
" エラーが出ても出力が分かりづらい(dein)
" []では正規表現が使えない
" [{pattern,replace}]を複数指定すると次の要素のreplaceに置換される
" 既存の設定を個別に無効に出来きない -> ifを変える
