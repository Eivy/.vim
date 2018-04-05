function! s:on_load_pre()
	let g:user_emmet_leader_key='<C-g>'
endfunction

function! s:on_load_post()
endfunction

function! s:loaded_on()
  return 'filetype=html,xml,vue,markdown,liquid'
endfunction

function! s:depends()
  return []
endfunction
