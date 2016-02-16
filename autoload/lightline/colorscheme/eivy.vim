" =============================================================================
" Filename: autoload/lightline/colorscheme/eivy.vim
" Version: 0.0
" Author: Eivy
" License: MIT License
" Last Change: 15-Dec-2015.
" =============================================================================
let s:base03 = [ '#242424', 235 ]
let s:base023 = [ '#888888 ', 236 ]
let s:base02 = [ '#303030 ', 233 ]
let s:base01 = [ '#585858', 238 ]
let s:base00 = [ '#666666', 242  ]
let s:base0 = [ '#808080', 244 ]
let s:base1 = [ '#eeeeee', 247 ]
let s:base2 = [ '#dedede', 248 ]
let s:base3 = [ '#d0d0d0', 252 ]
let s:yellow = [ '#cae682', 180 ]
let s:orange = [ '#f2c68a', 216 ]
let s:red = [ '#e5786d', 203 ]
let s:blue = [ '#8ac6f2', 117 ]
let s:green = [ '#95e454', 119 ]
let s:p = {'normal': {}, 'inactive': {}, 'insert': {}, 'replace': {}, 'visual': {}, 'tabline': {}}
let s:p.normal.left = [ [ s:base02, s:blue ], [ s:base02, s:red ], [ s:base3, s:base03 ] ]
let s:p.normal.middle = [ [ s:base2, s:base02 ] ]
let s:p.normal.right = [ [ s:base02, s:base0 ], [ s:base1, s:base01 ] ]
let s:p.inactive.left =  [ [ s:base02, s:red ], [ s:base0, s:base02 ] ]
let s:p.inactive.middle = [ [ s:base2, s:base02 ] ]
let s:p.inactive.right = [ [ s:base0, s:base02 ], [ s:base00, s:base02 ] ]
let s:p.insert.left = [ [ s:base02, s:green ], [ s:base3, s:base01 ] ]
let s:p.replace.left = [ [ s:base023, s:red ], [ s:base3, s:base01 ] ]
let s:p.visual.left = [ [ s:base02, s:orange ], [ s:base02, s:red ], [ s:base3, s:base01 ] ]
let s:p.tabline.left = [ [ s:base3, s:base00 ] ]
let s:p.tabline.tabsel = [ [ s:base2, s:base023 ] ]
let s:p.tabline.middle = [ [ s:base02, s:base1 ] ]
let s:p.tabline.right = [ [ s:base2, s:base01 ] ]
let s:p.normal.error = [ [ s:base03, s:red ] ]
let s:p.normal.warning = [ [ s:base023, s:yellow ] ]

let g:lightline#colorscheme#eivy#palette = lightline#colorscheme#flatten(s:p)
