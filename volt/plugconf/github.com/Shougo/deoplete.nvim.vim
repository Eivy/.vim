function! s:on_load_pre()
	let g:deoplete#enable_at_startup=1
endfunction

function! s:on_load_post()
	call deoplete#custom#option({
		\'deoplete-options-auto_complete_delay': 0,
		\'deoplete-options-yarp': 1,
	\})
	call deoplete#custom#option('omni_patterns', {
	\ 'go': '\h\w\+\.\w*',
	\})
endfunction

function! s:loaded_on()
  return 'start'
endfunction

function! s:depends()
  return ['roxma/vim-yarp', 'roxma/vim-hug-neovim-rpc.vim']
endfunction
