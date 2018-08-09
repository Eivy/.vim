function! s:on_load_pre()
	let g:savevers_types="*"
	let g:savevers_dirs=&backupdir
	let g:versdiff_no_resize=1
	let g:savevers_max=30
	nnoremap <silent> gdp :VersDiff -<CR>
	nnoremap <silent> gdn :VersDiff +<CR>
	nnoremap <silent> gde :VersDiff -c<CR>
endfunction

function! s:on_load_post()
endfunction

function! s:loaded_on()
  return 'start'
endfunction

function! s:depends()
  return []
endfunction
