function! outline#vb#outline_info()
  return s:outline_info
endfunction

let s:Ctags = unite#sources#outline#import('Ctags')
let s:Util  = unite#sources#outline#import('Util')

let s:Ctags.lang_info.vb = {
      \ 'name': 'Basic',
      \ 'ctags_options': " '--basic-kinds=cdgnsmt' ",
      \ 'scope_kinds'  : ['namespace', 'class', 'enum'],
      \ 'scope_delim'  : '.',
      \ }


"-----------------------------------------------------------------------------
" Outline Info

let s:outline_info = {
      \ 'heading_groups': {
      \   'namespace': ['namespace'],
      \   'type'     : ['class', 'enum', 'struct', 'typedef'],
      \   'function' : ['function', 'macro'],
      \ },
      \
      \ 'not_match_patterns': [
      \   s:Util.shared_pattern('*', 'parameter_list'),
      \ ],
      \
      \ 'highlight_rules': [
      \   { 'name'   : 'parameter_list',
      \     'pattern': '/(.*)/' },
      \   { 'name'   : 'type',
      \     'pattern': '/\S\+\ze\%( #\d\+\)\= : \%(class\|enum\|struct\|typedef\)/' },
      \   { 'name'   : 'function',
      \     'pattern': '/\%(=> .*\)\@<!\(operator\>.*\|\h\w*\)\ze\s*(/' },
      \   { 'name'   : 'macro',
      \     'pattern': '/\h\w*\ze .*=> /' },
      \   { 'name'   : 'expanded',
      \     'pattern': '/ => \zs.*/' },
      \   { 'name'   : 'id',
      \     'pattern': '/ \zs#\d\+/' },
      \ ],
      \}

function! s:outline_info.extract_headings(context)
  return s:Ctags.extract_headings(a:context)
endfunction
