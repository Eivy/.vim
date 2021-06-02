" vim:et:sw=2:ts=2

function! s:on_load_pre()
  let g:lsp_diagnostics_echo_cursor = 1
  if executable('gopls')
    au User lsp_setup call lsp#register_server({
          \ 'name': 'gopls',
          \ 'cmd': {server_info->['gopls', '-mode', 'stdio']},
          \ 'whitelist': ['go'],
          \ 'workspace_config' : {'gopls': {
          \   'staticcheck': v:true,
          \   'completeUnimported': v:true,
          \   'caseSensitiveCompletion': v:true,
          \   'usePlaceholders': v:true,
          \   'completeDocumentation': v:true,
          \   'watchFileChanges': v:true,
          \   'hoverKind': 'SingleLine',
          \ }},
          \ })
  endif
  if executable('dart_language_server')
    augroup LSPDart
      au!
      au User lsp_setup call lsp#register_server({
            \ 'name': 'dart_language_server',
            \ 'cmd': {server_info->[&shell, &shellcmdflag, 'dart_language_server']},
            \ 'whitelist': ['dart'],
            \ })
      augroup LSP
        autocmd BufWritePre * silent LspDocumentFormatSync
      augroup END
    augroup END
  endif
  if executable('typescript-language-server')
    augroup LSPTypescript
      au User lsp_setup call lsp#register_server({
            \ 'name': 'typescript-language-server',
            \ 'cmd': {server_info->[&shell, &shellcmdflag, 'typescript-language-server --stdio']},
            \ 'root_uri':{server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), 'tsconfig.json'))},
            \ 'whitelist': ['typescript', 'vue'],
            \ })
      augroup LSP
        autocmd BufWritePre * silent LspDocumentFormatSync
      augroup END
    augroup END
  endif
endfunction

function! s:on_load_post()
  function! s:on_lsp_buffer_enabled() abort
    setlocal omnifunc=lsp#complete   " オムニ補完を有効化
    " LSP用にマッピング
    nmap <silent> <buffer> <C-]> <plug>(lsp-definition)
    nmap <silent> <buffer> ggd <plug>(lsp-peek-definition)
    nmap <silent> <buffer> ggD <plug>(lsp-references)
    nmap <silent> <buffer> ggs <plug>(lsp-document-symbol-search)
    nmap <silent> <buffer> ggS <plug>(lsp-workspace-symbol-search)
    nmap <silent> <buffer> == <plug>(lsp-document-format)
    vmap <silent> <buffer> == <plug>(lsp-document-range-format)
    nmap <silent> <buffer> <C-j> <plug>(lsp-next-diagnostic-nowrap)
    nmap <silent> <buffer> <C-k> <plug>(lsp-previous-diagnostic-nowrap)
    nmap <silent> <buffer> K <plug>(lsp-hover)
    nmap <silent> <buffer> <F1> <plug>(lsp-implementation)
    nmap <silent> <buffer> <F2> <plug>(lsp-rename)
  endfunction
  augroup lsp_install
    au!
    autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
  augroup END
endfunction

function! s:loaded_on()
  return 'start'
endfunction

function! s:depends()
  return ['prabirshrestha/async.vim']
endfunction
