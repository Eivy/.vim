function! s:config()
	let g:clang_complete_auto=0
	let g:clang_auto_select=2
	let g:clang_library_path='/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/lib'
endfunction

function! s:loaded_on()
  return 'filetype=c,h,cpp,hpp'
endfunction

function! s:depends()
  return []
endfunction
