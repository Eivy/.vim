"Author: Eivy
" vi:tw=0 ts=4 sw=4
set enc=utf-8
scriptencoding utf-8

if &compatible
	set nocompatible
endif

let vimpath=''
if has('win32')
	let vimpath = '~/vimfiles/'
else
	let vimpath = '~/.vim/'
endif

filetype plugin indent on

if has('autocmd') && has('syntax')
	fun! <SID>ZenkakuSpace()
		hi ZenkakuSpace cterm=underline ctermfg=gray gui=underline guifg=#AAAAAA
	endf
	aug Eivy
		au!
		au FileType help,vimfiler,tagbar setl nonu
		au FileType quickrun setl nowrap
		au FileType * set fo-=c fo-=r fo-=o
		au FileType go nmap <leader>d <Plug>(go-def-split)
		au FileType go nmap <leader>do <Plug>(go-doc)
		au FileType go nmap <leader>i <Plug>(go-implements)
		au FileType go nmap <leader>re <Plug>(go-rename)
		au BufRead,WinEnter,VimEnter * match ZenkakuSpace /　/
		au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exec "normal! g'\"" | endif
		au BufReadPost,WinEnter,VimEnter * if &ft !~ 'fugitiveblame\|tagbar\|vimfiler\|help' | set nu | endif
		au ColorScheme * call <SID>ZenkakuSpace()
		au InsertEnter,InsertLeave * set imi=0 ims=0
		if exists("+omnifunc")
			au Filetype * if &ofu == "" | setlocal ofu=syntaxcomplete#Complete | endif
		endif
	aug END
endif

"option
set t_Co=256
set bk bdir=~/.cache/vim pm=+ noswf nocul noudf
set dy=lastline fo=BqljmM go=C hi=50 ls=2 hls
set nu ic scs sm sw=4 ts=4 nf=hex sc ch=1
set wmnu wim=longest:full,full is nows wrap
set list lcs=trail:«,tab:»\ ,extends:>,precedes:>
set grepprg=ag\ --nogroup\ --nocolor
set dip=filler,vertical
set ambiwidth=single
set ai backspace=indent,eol,start
set fencs=utf-8,euc-jp,ucs-bom,cp932,utf-16le,utf-16be,default
set iskeyword=_,-,a-z,A-Z,48-57,128-167,224-235
set vi='100,<50,s10,h
exe 'set vi+=n'.vimpath.'info'
set synmaxcol=300
set visualbell t_vb=
set noerrorbells
set pyx=3
set cot+=noselect
set wildignorecase
colo eivy
syntax enable

"折り畳みの表示方式変更
set fdm=manual
set foldtext=FoldText()
fun! FoldText()
	let lines=string(v:foldend - v:foldstart +1)
	let top=substitute(getline(v:foldstart), '\t', repeat(' ', &ts), 'g')
	let foldinfo=repeat('*',v:foldlevel) . repeat(' ',5-strwidth(lines)) . lines . 'L'
	let line=strpart(top,0,winwidth(0) - strdisplaywidth(foldinfo))
	let nuwidth=&nuw > len(line('$')) ? &nuw : len(line('$')) + 1
	return line . repeat(' ', winwidth(0)-(strwidth(line)+strwidth(foldinfo)+nuwidth)) . foldinfo
endf

command! Term call term_start($SHELL, {'vertical': 1, 'term_finish': 'close', 'term_cols': 40})

"mapping
nnoremap & :&&<CR>

cnoremap <C-p> <Up>
cnoremap <C-n> <Down>
cnoremap <Up> <C-p>
cnoremap <Down> <C-n>

cnoremap <C-x> <C-r>=substitute(expand('%:h'), ' ', '\\ ', 'g').'/'<CR>

"command
command! -nargs=+ -complete=file VDsplit vertical diffsplit <args>
command! -nargs=0 Scratch 20new | setl bt=nofile noswf

"search seleceted by Visual Mode
xnoremap <silent> * "vy/\V<C-r>=substitute(escape(@v, '/\'),"\n", '\\n', 'g')<CR><CR>
xnoremap <silent> # "vy?\V<C-r>=substitute(escape(@v, '/\'),"\n", '\\n', 'g')<CR><CR>

"Markdown Hightlight
let g:markdown_fenced_languages = [
	\'c',
	\'cs',
	\'c#=cs',
	\'css',
	\'dart',
	\'go',
	\'html',
	\'javascript',
	\'js=javascript',
	\'json=javascript',
	\'makefile=make',
	\'make',
	\'python',
	\'ruby',
	\'sql',
	\'vb',
	\'vim',
	\'xml',
\]

"MatchIt
ru macros/matchit.vim

call plug#begin()

Plug 'zhaocai/DirDiff.vim'
Plug 'w0rp/ale'
Plug 'tyru/open-browser.vim'
Plug 'tyru/caw.vim'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-liquid'
Plug 'tpope/vim-fugitive'
Plug 'thinca/vim-quickrun'
Plug 't9md/vim-choosewin'
Plug 'ryanoasis/vim-devicons'
Plug 'roxma/vim-hug-neovim-rpc'
Plug 'roxma/nvim-yarp'
Plug 'rhysd/vim-gfm-syntax', { 'for': 'markdown' }
Plug 'prabirshrestha/async.vim'
Plug 'mattn/webapi-vim'
Plug 'mattn/vim-goimports', { 'for': 'go' },
Plug 'mattn/emmet-vim'
Plug 'majutsushi/tagbar'
Plug 'kristijanhusak/defx-icons'
Plug 'kristijanhusak/defx-git'
Plug 'mattn/vim-molder'

Plug 'itchyny/lightline.vim'
Plug 'hotwatermorning/auto-git-diff'
Plug 'haya14busa/vim-migemo'
Plug 'editorconfig/editorconfig-vim'
Plug 'bkad/CamelCaseMotion'
Plug 'Shougo/deoplete.nvim'
Plug 'Shougo/context_filetype.vim'
Plug 'Eivy/vim-html_ruby', { 'for': 'html' }
Plug 'Eivy/vim-gotham'
Plug 'Eivy/savevers.vim'
Plug 'Eivy/Align'

Plug 'kana/vim-metarw'
Plug 'emonkak/vim-metarw-gist'
Plug 'Eivy/vim-metarw-simplenote'

Plug 'kana/vim-operator-user'
Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-function'

Plug 'prabirshrestha/vim-lsp'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
Plug 'mattn/vim-lsp-settings'

call plug#end()

"CamelCaseMoiton
nmap <silent> <leader>w <Plug>CamelCaseMotion_w
xmap <silent> <leader>w <Plug>CamelCaseMotion_w
omap <silent> <leader>w <Plug>CamelCaseMotion_w
omap <silent> i<leader>w <Plug>CamelCaseMotion_iw

nmap <silent> <leader>b <Plug>CamelCaseMotion_b
xmap <silent> <leader>b <Plug>CamelCaseMotion_b
omap <silent> <leader>b <Plug>CamelCaseMotion_b
omap <silent> i<leader>b <Plug>CamelCaseMotion_ib

nmap <silent> <leader>e <Plug>CamelCaseMotion_e
xmap <silent> <leader>e <Plug>CamelCaseMotion_e
omap <silent> <leader>e <Plug>CamelCaseMotion_e
omap <silent> i<leader>e <Plug>CamelCaseMotion_ie

"LigntLine
let g:lightline = {
			\'colorscheme': 'eivy',
			\'active': {
			\	'left': [['mode', 'ro'], ['git'], ['path']],
			\	'right': [['line', 'co'], ['type', 'enc', 'ff']]
			\},
			\'inactive': {
			\	'left': [['ro'], ['path']],
			\	'right': [['line'], ['type', 'enc', 'ff']]
			\},
			\'component': {
			\	'co': '%v',
			\	'enc': '%{strlen(&fenc)?&fenc:&enc}',
			\	'ff': '%{&ff}',
			\	'line': '%l:%L',
			\	'mode': '%{lightline#mode()}',
			\	'path': '%f %M',
			\	'type': '%Y',
			\},
			\'component_function': {
			\	'ro': 'Readonly',
			\},
			\'component_expand': {
			\	'git': 'LlGit',
			\},
			\'component_type': {
			\	'ro': 'readonly',
			\},
			\'component_visible_condition': {
			\	'git': 'LlGit',
			\	'ro': '&readonly',
			\},
			\'separator': { 'left': "\ue0b0", 'right': "\ue0b2" },
			\'subseparator': {  'left': "\ue0b1", 'right': "\ue0b3" },
			\'enable': {'tabline': 0}
			\}

fun! LlGit()
	if fugitive#head() != ""
		return "\uf418".' '.fugitive#head()
	else
		return ''
	endif
endf

fun! Readonly()
	if &readonly
		return "\ue0a2"
	else 
		return ''
	endif
endf
fun! LlGit()
	if fugitive#head() != ""
		return "\uf418".' '.fugitive#head()
	else
		return ''
	endif
endf

fun! Readonly()
	if &readonly
		return "\ue0a2"
	else 
		return ''
	endif
endf

"choose win
nmap <C-w><C-w> <Plug>(choosewin)
let g:choosewin_statusline_replace=0
let g:choosewin_blink_on_land=0
let g:choosewin_overlay_enable=1
let g:choosewin_overlay_clear_multibyte=1
let g:choosewin_color_overlay={'gui': ['#000dcc'], 'cterm': ['darkcyan']}
let g:choosewin_color_overlay_current={'gui': ['#0033ff'], 'cterm': ['cyan']}

"QuickRun
let g:quickrun_config={}
let g:quickrun_config['_']={'runner/updatetime': '200', 'outputter/buffer/split': '20'}
let g:quickrun_config['applescript']={'exec': 'osascript ~/Code/AppleScript/quickrun.applescript %s'}
let g:quickrun_config['c']={'command': 'clang'}
let g:quickrun_config['cpp']={'command': 'clang++'}
let g:quickrun_config['lua']={'command': 'luajit'}
let g:quickrun_config['markdown']={'type': 'markdown/pandoc', 'cmdopt': '-t html5 -s', 'outputter': 'browser'}
let g:quickrun_config['asciidoc']={'command': 'asciidoc', 'cmdopt': '-o - ', 'outputter': 'browser'}
let g:quickrun_config['objc']={'exec': ['clang -framework cocoa %s -o %s:p:r','%s:p:r %a'], 'tempfile': '%{tempname()}.m', 'hook/sweep/files': '%S:p:r' }
let g:quickrun_config['html']={'command': 'cat', 'outputter': 'browser'}
let g:quickrun_config['xhtml']=g:quickrun_config.html
let g:quickrun_config['sql']={'command': 'mssql', 'cmdopt': '-c ~/.config/mssql'}
nnoremap <expr><silent> <C-c> quickrun#is_running() ? quickrun#sweep_sessions() : "\<C-c>"

"Caw
let g:caw_no_default_keymappings=1
nmap <silent> <leader>g <Plug>(caw:hatpos:toggle:operator)
nmap <silent> <leader>gg <Plug>(caw:hatpos:toggle)
vmap <silent> <leader>g <Plug>(caw:hatpos:toggle)
nmap <silent> <leader>G <Plug>(caw:wrap:toggle:operator)
nmap <silent> <leader>GG <Plug>(caw:wrap:toggle)
vmap <silent> <leader>G <Plug>(caw:wrap:toggle)

"Open Browser
nmap goo <Plug>(openbrowser-open)
xmap goo <Plug>(openbrowser-open)
nmap gos <Plug>(openbrowser-smart-search)
xmap gos <Plug>(openbrowser-smart-search)

"ale
let g:ale_lint_on_text_changed = 'never'
let g:ale_set_quickfix=0
let g:ale_open_list=0
let g:ale_keep_list_window_open=0
map <C-j> <Plug>(ale_next)
map <C-k> <Plug>(ale_previous)

"savevers
let g:savevers_types="*"
let g:savevers_dirs=&backupdir
let g:versdiff_no_resize=1
let g:savevers_max=30
nnoremap <silent> gdp :VersDiff -<CR>
nnoremap <silent> gdn :VersDiff +<CR>
nnoremap <silent> gde :VersDiff -c<CR>

"goimport
let g:goimports = 1
let g:goimports_simplify = 1

"lsp
let g:lsp_diagnostics_echo_cursor = 1
if executable('gopls')
	au User lsp_setup call lsp#register_server({
				\ 'name': 'gopls',
				\ 'cmd': {server_info->['gopls', '-mode', 'stdio']},
				\ 'whitelist': ['go'],
				\ 'workspace_config' : {'gopls': {
					\   'analyses': { 'fillstruct': v:true },
					\   'staticcheck': v:true,
					\   'completeUnimported': v:true,
					\   'caseSensitiveCompletion': v:true,
					\   'usePlaceholders': v:true,
					\   'completeDocumentation': v:true,
					\   'watchFileChanges': v:true,
					\   'hoverKind': 'SynopsisDocumentation',
					\   'codelens': {
						\   'gc_details': v:false,
						\   'generate': v:true,
						\   'test': v:true,
						\   'tidy': v:true,
						\   'vendor': v:false,
						\ },
				\ }},
	\ })
endif
function! s:on_lsp_buffer_enabled() abort
	setlocal omnifunc=lsp#complete   " オムニ補完を有効化
	" LSP用にマッピング
	nmap <silent> <buffer> <C-]> <plug>(lsp-definition)
	nmap <silent> <buffer> ggd <plug>(lsp-peek-definition)
	nmap <silent> <buffer> ggD <plug>(lsp-references)
	nmap <silent> <buffer> ggs <plug>(lsp-document-symbol-search)
	nmap <silent> <buffer> ggS <plug>(lsp-workspace-symbol-search)
	nmap <silent> <buffer> gga <plug>(lsp-code-action)
	nmap <silent> <buffer> ggc <plug>(lsp-code-lens)
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
