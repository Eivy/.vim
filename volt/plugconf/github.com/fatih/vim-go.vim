function! s:config()
	let g:go_highlight_functions=1
	let g:go_highlight_methods=1
	let g:go_highlight_structs=1
	let g:go_fmt_command='goimports'
endfunction

function! s:loaded_on()
  return 'start'
endfunction

function! s:depends()
  return []
endfunction
