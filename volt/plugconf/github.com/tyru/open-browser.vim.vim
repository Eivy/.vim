function! s:config()
	nmap goo <Plug>(openbrowser-open)
	xmap goo <Plug>(openbrowser-open)
	nmap gos <Plug>(openbrowser-smart-search)
	xmap gos <Plug>(openbrowser-smart-search)
endfunction

function! s:loaded_on()
  return 'start'
endfunction

function! s:depends()
  return []
endfunction
