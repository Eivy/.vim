function! s:config()
	let g:ale_lint_on_text_changed = 'never'
	let g:ale_set_quickfix=0
	let g:ale_open_list=0
	let g:ale_keep_list_window_open=0
endfunction

function! s:loaded_on()
  return 'start'
endfunction

function! s:depends()
  return []
endfunction
