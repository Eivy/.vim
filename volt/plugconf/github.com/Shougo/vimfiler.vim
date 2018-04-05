function! s:on_load_pre()
endfunction

function! s:on_load_post()
	let g:vimfiler_as_default_explorer=1
	call vimfiler#custom#profile('default', 'context', {'safe': 0, 'simple': 1})
endfunction

function! s:loaded_on()
  return 'start'
endfunction

function! s:depends()
  return ['github.com/Shougo/unite.vim']
endfunction
