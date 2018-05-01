function! s:on_load_pre()
	let g:LanguageClient_serverCommands = {
	\ 'dart': ['dart_language_server'],
	\ 'typescript': ['typescript-language-server','-stdio'],
	\ 'vue': ['vls'],
	\ 'html': [],
	\ 'css': [],
	\ }
endfunction

function! s:on_load_post()
endfunction

function! s:loaded_on()
  return 'start'
endfunction

function! s:depends()
  return ['Shougo/deoplete.nvim']
endfunction
