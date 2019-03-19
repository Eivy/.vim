" vim:et:sw=2:ts=2

function! s:on_load_pre()
  " if executable('gopls')
  "   augroup LSPGo
  "     au User lsp_setup call lsp#register_server({
  "          \ 'name': 'gopls',
  "          \ 'cmd': {server_info->['gopls', '-mode', 'stdio']},
  "          \ 'whitelist': ['go'],
  "          \ })
  "     autocmd FileType go setlocal omnifunc=lsp#complete
  "   augroup END
  " endif
  if executable('dart_language_server')
    augroup LSPDart
      au!
      au User lsp_setup call lsp#register_server({
            \ 'name': 'dart_language_server',
            \ 'cmd': {server_info->[&shell, &shellcmdflag, 'dart_language_server']},
            \ 'whitelist': ['dart'],
            \ })
      autocmd FileType dart setlocal omnifunc=lsp#complete
    augroup END
  endif
  if executable('typescript-language-server')
    augroup LSPTypescript
      au User lsp_setup call lsp#register_server({
            \ 'name': 'typescript-language-server',
            \ 'cmd': {server_info->[&shell, &shellcmdflag, 'typescript-language-server --stdio']},
            \ 'root_uri':{server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), 'tsconfig.json'))},
            \ 'whitelist': ['typescript'],
            \ })
      autocmd FileType typescript setlocal omnifunc=lsp#complete
    augroup END
  endif
endfunction

function! s:on_load_post()
endfunction

function! s:loaded_on()
  return 'start'
endfunction

function! s:depends()
  return []
endfunction
