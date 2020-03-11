let s:blue    = ['#6EA4FF', 141]
let s:green   = ['#26EBAF', 156]
let s:magenta = ['#D285FF', 214]
let s:yellow  = ['#FFEF4A', 136]
let s:red     = ['#FF375F', 124]

let s:tab_active   = ['#6EA4FF', 141]
let s:tab_inactive = ['#9aa09a', 244]
let s:nocontent    = ['#202020', 235]
let s:text_fg      = ['#202000', 0]

let s:black  = ['#202000', 0]
let s:gray   = ['#20202f', 234]
let s:base03 = ['#102b26', 234]
let s:base02 = ['#202632', 235]
let s:base01 = ['#586060', 239]
let s:base00 = ['#6a7073', 240]
let s:base0  = ['#8a9090', 244]
let s:base1  = ['#93a1a1', 245]
let s:base2  = ['#eee8d5', 187]
let s:base3  = ['#fdf6e3', 230]


" base
let s:p = {
  \   'normal': {},
  \   'inactive': {},
  \   'insert': {},
  \   'replace': {},
  \   'visual': {},
  \   'tabline': {}
  \ }

" format
"   name = [[first_pos], [second_pos], [third_pos], ...]

" tab
let s:p.tabline.left   = [[s:text_fg, s:tab_inactive]]
let s:p.tabline.middle = [[s:text_fg, s:nocontent]]
let s:p.tabline.right  = [[s:text_fg, s:tab_active], [s:tab_active, s:tab_inactive]]
let s:p.tabline.tabsel = [[s:text_fg, s:tab_active]]

" middle
let s:p.normal.middle   = [[s:base1,  s:black]]
let s:p.inactive.middle = [[s:base01, s:nocontent]]

" inactive
let s:p.inactive.left  = [[s:text_fg, s:base00], [s:text_fg, s:base00], [s:base0, s:nocontent]]
let s:p.inactive.right = [[s:text_fg, s:base00], [s:base0,   s:nocontent]]

" each mode colors
let s:p.normal.left   = [[s:text_fg, s:blue],    [s:text_fg, s:blue],    [s:blue,    s:gray]]
let s:p.normal.right  = [[s:text_fg, s:blue],    [s:blue,    s:gray]]
let s:p.insert.left   = [[s:text_fg, s:green],   [s:text_fg, s:green],   [s:green,   s:gray]]
let s:p.insert.right  = [[s:text_fg, s:green],   [s:green,   s:gray]]
let s:p.replace.left  = [[s:text_fg, s:red],     [s:text_fg, s:red],     [s:red,     s:gray]]
let s:p.replace.right = [[s:text_fg, s:red],     [s:red,     s:gray]]
let s:p.visual.left   = [[s:text_fg, s:magenta], [s:text_fg, s:magenta], [s:magenta, s:gray]]
let s:p.visual.right  = [[s:text_fg, s:magenta], [s:magenta, s:gray]]

let s:p.normal.error   = [[s:black,   s:red]]
let s:p.normal.warning = [[s:text_fg, s:yellow]]
let s:p.normal.git     = [[s:red,     s:gray]]

let g:lightline#colorscheme#refreshing#palette = lightline#colorscheme#flatten(s:p)
