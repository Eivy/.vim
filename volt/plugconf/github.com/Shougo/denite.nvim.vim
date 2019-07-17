function! s:on_load_pre()
endfunction

function! s:on_load_post()
	nnoremap <silent> <C-p>o :Denite -start-filter file/old<CR>
	nnoremap <silent> <C-p>b :Denite -start-filter buffer<CR>
	nnoremap <silent> <C-p>f :Denite -start-filter file/rec<CR>
	call denite#custom#var('grep', 'command', ['jvgrep'])
	call denite#custom#var('grep', 'default_opts', ['-i'])
	call denite#custom#var('grep', 'recursive_opts', ['-R'])
	call denite#custom#var('grep', 'pattern_opt', [''])
	call denite#custom#var('grep', 'separator', [])
	call denite#custom#var('grep', 'final_opts', [])
	autocmd FileType denite call s:denite_my_settings()
	function! s:denite_my_settings() abort
		nnoremap <silent><buffer><expr> <TAB> denite#do_map('choose_action')
		nnoremap <silent><buffer><expr> <CR> denite#do_map('do_action')
		nnoremap <silent><buffer><expr> o denite#do_map('do_action', 'open')
		nnoremap <silent><buffer><expr> s denite#do_map('do_action', 'split')
		nnoremap <silent><buffer><expr> v denite#do_map('do_action', 'vsplit')
		nnoremap <silent><buffer><expr> t denite#do_map('do_action', 'tabopen')
		nnoremap <silent><buffer><expr> d denite#do_map('do_action', 'delete')
		nnoremap <silent><buffer><expr> p denite#do_map('do_action', 'preview')
		nnoremap <silent><buffer><expr> q denite#do_map('quit')
		nnoremap <silent><buffer><expr> i denite#do_map('open_filter_buffer')
		nnoremap <silent><buffer><expr> <Space> denite#do_map('toggle_select').'j'
	endfunction
endfunction

function! s:loaded_on()
	return 'start'
endfunction

function! s:depends()
  return ['roxma/vim-yarp', 'roxma/vim-hug-neovim-rpc.vim']
endfunction
