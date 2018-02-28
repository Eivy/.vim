function! s:config()
	let g:deoplete#enable_at_startup=1
	let g:deoplete#omni_patterns={}
	let g:deoplete#omni_patterns.go = '\h\w\+\.\w*'
endfunction

function! s:loaded_on()
  return 'start'
endfunction

function! s:depends()
  return ['roxma/vim-yarp', 'roxma/vim-hug-neovim-rpc.vim']
endfunction
