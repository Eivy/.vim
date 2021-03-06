function! s:on_load_pre()
	let g:tagbar_type_go = {
				\'ctagstype' : 'go',
				\'kinds'     : [
				\	'p:package',
				\	'i:imports:1',
				\	'c:constants',
				\	'v:variables',
				\	't:types',
				\	'n:interfaces',
				\	'w:fields',
				\	'e:embedded',
				\	'm:methods',
				\	'r:constructor',
				\	'f:functions'
				\],
				\'sro' : '.',
				\'kind2scope' : {
				\	't' : 'ctype',
				\	'n' : 'ntype'
				\},
				\'scope2kind' : {
				\	'ctype' : 't',
				\	'ntype' : 'n'
				\},
				\'ctagsbin'  : 'gotags',
				\'ctagsargs' : '-sort -silent'
				\}
endfunction

function! s:on_load_post()
endfunction

function! s:loaded_on()
  return 'start'
endfunction

function! s:depends()
  return []
endfunction
