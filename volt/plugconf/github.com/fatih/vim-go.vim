function! s:on_load_pre()
	let g:go_highlight_functions=1
	let g:go_highlight_methods=1
	let g:go_highlight_structs=1
	let g:go_fmt_command='goimports'
endfunction

function! s:on_load_post()
endfunction

function! s:loaded_on()
  return 'start'
endfunction

function! s:depends()
  return []
endfunction
