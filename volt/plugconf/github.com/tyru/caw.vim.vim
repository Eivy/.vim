function! s:config()
	let g:caw_no_default_keymappings=1
	nmap <silent> <leader>g <Plug>(caw:hatpos:toggle:operator)
	nmap <silent> <leader>gg <Plug>(caw:hatpos:toggle)
	vmap <silent> <leader>g <Plug>(caw:hatpos:toggle)
	nmap <silent> <leader>G <Plug>(caw:wrap:toggle:operator)
	nmap <silent> <leader>GG <Plug>(caw:wrap:toggle)
	vmap <silent> <leader>G <Plug>(caw:wrap:toggle)
endfunction

function! s:loaded_on()
  return 'start'
endfunction

function! s:depends()
  return ['github.com/kana/vim-operator-user']
endfunction
