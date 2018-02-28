function! s:config()
	let g:quickrun_config={}
	let g:quickrun_config['_']={'runner': 'vimproc', 'runner/updatetime': '200', 'outputter/buffer/split': '20'}
	let g:quickrun_config['applescript']={'exec': 'osascript ~/Code/AppleScript/quickrun.applescript %s'}
	let g:quickrun_config['c']={'command': 'clang'}
	let g:quickrun_config['cpp']={'command': 'clang++'}
	let g:quickrun_config['lua']={'command': 'luajit'}
	let g:quickrun_config['markdown']={'type': 'markdown/pandoc', 'cmdopt': '-t html5 -s', 'outputter': 'browser'}
	let g:quickrun_config['asciidoc']={'command': 'asciidoc', 'cmdopt': '-o - ', 'outputter': 'browser'}
	let g:quickrun_config['objc']={'exec': ['clang -framework cocoa %s -o %s:p:r','%s:p:r %a'], 'tempfile': '%{tempname()}.m', 'hook/sweep/files': '%S:p:r' }
	let g:quickrun_config['html']={'command': 'cat', 'outputter': 'browser'}
	let g:quickrun_config['xhtml']=g:quickrun_config.html
	nnoremap <expr><silent> <C-c> quickrun#is_running() ? quickrun#sweep_sessions() : "\<C-c>"
endfunction

function! s:loaded_on()
  return 'start'
endfunction

function! s:depends()
  return []
endfunction
