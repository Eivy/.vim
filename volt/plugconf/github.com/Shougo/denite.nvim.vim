function! s:on_load_pre()
endfunction

function! s:on_load_post()
	nnoremap <silent> gdm :Denite file_mru<CR>
	nnoremap <silent> gdb :Denite buffer<CR>
	nnoremap <silent> <C-p> :Denite file/rec<CR>
	call denite#custom#var('file/rec', 'command', ['ag', '--follow', '--nocolor', '--nogroup', '-g', ''])
	call denite#custom#map('insert', '<C-n>', '<denite:move_to_next_line>')
	call denite#custom#map('insert', '<C-p>', '<denite:move_to_previous_line>')
endfunction

function! s:loaded_on()
	return 'start'
endfunction

function! s:depends()
	return []
endfunction
