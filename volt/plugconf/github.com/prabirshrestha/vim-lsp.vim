" vim:et:sw=2:ts=2

function! s:on_load_pre()
  if executable('gopls')
    au User lsp_setup call lsp#register_server({
          \ 'name': 'gopls',
          \ 'cmd': {server_info->['gopls', '-mode', 'stdio']},
          \ 'whitelist': ['go'],
          \ })
    autocmd FileType go call s:configure_lsp()
  endif
  if executable('dart_language_server')
    augroup LSPDart
      au!
      au User lsp_setup call lsp#register_server({
            \ 'name': 'dart_language_server',
            \ 'cmd': {server_info->[&shell, &shellcmdflag, 'dart_language_server']},
            \ 'whitelist': ['dart'],
            \ })
      autocmd FileType dart call s:configure_lsp()
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
      autocmd FileType typescript call s:configure_lsp()
    augroup END
  endif
  function! s:configure_lsp() abort
    setlocal omnifunc=lsp#complete   " オムニ補完を有効化
    " LSP用にマッピング
    nnoremap <buffer> <C-]> :<C-u>LspDefinition<CR>
    nnoremap <buffer> ggd :<C-u>LspDefinition<CR>
    nnoremap <buffer> ggD :<C-u>LspReferences<CR>
    nnoremap <buffer> ggs :<C-u>LspDocumentSymbol<CR>
    nnoremap <buffer> ggS :<C-u>LspWorkspaceSymbol<CR>
    nnoremap <buffer> ggQ :<C-u>LspDocumentFormat<CR>
    vnoremap <buffer> ggQ :LspDocumentRangeFormat<CR>
    nnoremap <buffer> K :<C-u>LspHover<CR>
    nnoremap <buffer> <F1> :<C-u>LspImplementation<CR>
    nnoremap <buffer> <F2> :<C-u>LspRename<CR>
    augroup LSP
      autocmd BufWritePre * silent LspDocumentFormatSync
    augroup END
  endfunction
endfunction

function! s:on_load_post()
endfunction

function! s:loaded_on()
  return 'start'
endfunction

function! s:depends()
  return ['prabirshrestha/async.vim']
endfunction
