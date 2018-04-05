function! s:on_load_pre()
	let g:gista#client#user_git_config_github_username=1
endfunction

function! s:on_load_post()
endfunction

function! s:loaded_on()
  return 'start'
endfunction

function! s:depends()
  return []
endfunction
