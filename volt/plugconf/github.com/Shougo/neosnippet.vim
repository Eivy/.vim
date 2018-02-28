function! s:config()
	imap <C-k> <Plug>(neosnippet_expand_or_jump)
	smap <C-k> <Plug>(neosnippet_expand_or_jump)
	command! -nargs=0 SnipEdit NeoSnippetEdit
	let g:neosnippet#snippets_directory='~/.vim/snip'
endfunction

function! s:loaded_on()
  return 'start'
endfunction

function! s:depends()
  return []
endfunction
