function! s:on_load_pre()
endfunction

function! s:on_load_post()
	nnoremap <silent> gdm :Denite file_mru<CR>
	nnoremap <silent> gdb :Denite buffer<CR>
	nnoremap <silent> <C-p> :Denite file/rec<CR>
	call denite#custom#var('file/rec', 'command', ['ag', '--follow', '--nocolor', '--nogroup', '-g', ''])
	call denite#custom#map('insert', '<C-n>', '<denite:move_to_next_line>')
	call denite#custom#map('insert', '<C-p>', '<denite:move_to_previous_line>')
	autocmd FileType denite call s:denite_my_settings()
	function! s:denite_my_settings() abort
		nnoremap <silent><buffer><expr> <CR> denite#do_map('do_action')
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
