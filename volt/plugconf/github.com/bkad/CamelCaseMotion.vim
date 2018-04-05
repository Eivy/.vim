function! s:on_load_pre()
	nmap <silent> <leader>w <Plug>CamelCaseMotion_w
	xmap <silent> <leader>w <Plug>CamelCaseMotion_w
	omap <silent> <leader>w <Plug>CamelCaseMotion_w
	omap <silent> i<leader>w <Plug>CamelCaseMotion_iw

	nmap <silent> <leader>b <Plug>CamelCaseMotion_b
	xmap <silent> <leader>b <Plug>CamelCaseMotion_b
	omap <silent> <leader>b <Plug>CamelCaseMotion_b
	omap <silent> i<leader>b <Plug>CamelCaseMotion_ib

	nmap <silent> <leader>e <Plug>CamelCaseMotion_e
	xmap <silent> <leader>e <Plug>CamelCaseMotion_e
	omap <silent> <leader>e <Plug>CamelCaseMotion_e
	omap <silent> i<leader>e <Plug>CamelCaseMotion_ie
endfunction

function! s:on_load_post()
endfunction

function! s:loaded_on()
  return 'start'
endfunction

function! s:depends()
  return []
endfunction
