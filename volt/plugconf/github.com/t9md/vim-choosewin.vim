function! s:on_load_pre()
	nmap <C-w><C-w> <Plug>(choosewin)
	let g:choosewin_statusline_replace=0
	let g:choosewin_blink_on_land=0
	let g:choosewin_overlay_enable=1
	let g:choosewin_overlay_clear_multibyte=1
	let g:choosewin_color_overlay={'gui': ['#000dcc'], 'cterm': ['darkcyan']}
	let g:choosewin_color_overlay_current={'gui': ['#0033ff'], 'cterm': ['cyan']}
endfunction

function! s:on_load_post()
endfunction

function! s:loaded_on()
  return 'start'
endfunction

function! s:depends()
  return []
endfunction
