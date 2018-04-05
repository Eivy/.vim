function! s:on_load_pre()
endfunction

function! s:on_load_post()
	call unite#custom#profile('default', 'context', {'direction': 'belowright', 'winheight':10, 'auto-resize': 1, 'start_insert': 1})
	call unite#custom#source('neomru/file', 'ignore_pattern', '+$\|.git/\|.svn/\|\%(^\%(fugitive\)://\)')
	call unite#filters#matcher_default#use(['matcher_fuzzy'])
	nnoremap <silent> gum :Unite neomru/file<CR>
	nnoremap <silent> gub :Unite buffer<CR>
	nnoremap <silent> guv :VimFilerExplorer<CR>
	nnoremap <silent> <C-p> :Unite file_rec/async<CR>
endfunction

function! s:loaded_on()
	return 'start'
endfunction

function! s:depends()
	return []
endfunction
