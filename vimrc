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

exe 'set runtimepath^='.vimpath.'remote/dein.vim'

if dein#load_state(vimpath.'remote')
	call dein#local(vimpath.'local')
	call dein#begin(vimpath.'remote')

	call dein#add('Eivy/savevers.vim')
	call dein#add('Eivy/vim-gotham', {'script_type': 'colors'})
	call dein#add('Eivy/vim-metarw-simplenote')
	call dein#add('Shougo/neomru.vim')
	call dein#add('Shougo/unite.vim')
	call dein#add('Shougo/vimfiler')
	call dein#add('emonkak/vim-metarw-gist')
	call dein#add('haya14busa/vim-migemo')
	call dein#add('itchyny/lightline.vim')
	call dein#add('kana/vim-metarw',)
	call dein#add('mattn/webapi-vim')
	call dein#add('osyo-manga/unite-quickfix', {'depends': 'unite.vim'})
	call dein#add('ryanoasis/vim-devicons')
	call dein#add('scrooloose/syntastic')
	call dein#add('tpope/vim-fugitive')

	call dein#add('Eivy/Align',					{'lazy': 1, 'on_cmd': ['Align', 'AlignCtrl'], 'on_map': '<leader>t'})
	call dein#add('Eivy/applescript.vim',		{'lazy': 1, 'on_ft' : 'applescript'})
	call dein#add('Shougo/neocomplete.vim',		{'lazy': 1, 'on_i'  : 1})
	call dein#add('Shougo/neosnippet',			{'lazy': 1, 'on_i'  : 1, 'on_ft': 'neosnippet'})
	call dein#add('Shougo/neosnippet-snippets',	{'lazy': 1, 'on_i'  : 1})
	call dein#add('bkad/CamelCaseMotion',		{'lazy': 1, 'on_map': '<Plug>CamelCaseMotion_'})
	call dein#add('fatih/vim-go',				{'lazy': 1, 'on_ft' : 'go'})
	call dein#add('kana/vim-operator-user',		{'lazy': 1})
	call dein#add('kana/vim-textobj-function',	{'lazy': 1, 'on_ft' : ['vb','vbnet'], 'depends': 'vim-textobj-user'})
	call dein#add('kana/vim-textobj-user',		{'lazy': 1})
	call dein#add('lambdalisue/vim-gista',		{'lazy': 1, 'on_cmd': 'Gista', 'on_map': '<Plug>(gista-', 'depends': 'unite.vim'})
	call dein#add('majutsushi/tagbar',			{'lazy': 1, 'on_cmd': 'TagbarToggle'})
	call dein#add('mattn/emmet-vim',			{'lazy': 1, 'on_ft' : ['html','xhtml','css','xml','markdown','cs','eruby','vue']})
	call dein#add('mechatroner/rainbow_csv',	{'lazy': 1, 'on_ft' : ['csv','tsv']})
	call dein#add('posva/vim-vue',				{'lazy': 1, 'on_ft' : 'vue'})
	call dein#add('rhysd/vim-gfm-syntax',		{'lazy': 1, 'on_ft': 'markdown'})
	call dein#add('t9md/vim-choosewin',			{'lazy': 1, 'on_map': '<Plug>(choosewin)'})
	call dein#add('thinca/vim-quickrun',		{'lazy': 1, 'on_cmd': 'QuickRun','on_map': '<leader>r'})
	call dein#add('tpope/vim-surround',			{'lazy': 1, 'on_map': ['n', 'ds', 'cs', 'ys']})
	call dein#add('tyru/caw.vim',				{'lazy': 1, 'on_map': '<Plug>(caw:', 'depends': 'vim-operator-user'})
	call dein#add('tyru/open-browser.vim',		{'lazy': 1, 'on_map': '<Plug>(openbrowser-', 'on_func': 'openbrowser#load'})
	call dein#add('vim-scripts/diffchar.vim',	{'lazy': 1, 'on_map': ['<F7>','<F8>']})
	call dein#add('vim-scripts/vcscommand.vim',	{'lazy': 1, 'on_cmd': ['VCSBlame', 'VCSDiff']})
	call dein#add('zhaocai/DirDiff.vim',		{'lazy': 1, 'on_cmd': 'DirDiff'})

	if has('mac')
		call dein#add('Rip-Rip/clang_complete',		{'lazy': 1, 'on_ft' : ['objc','c','cpp']})
	endif
	if has('gui')
		call dein#add('thinca/vim-fontzoom',		{'lazy': 1, 'on_cmd': 'Fontzoom'})
	endif
	if !has('mac')
		call dein#add('eivy/vim-vbnet', {'lazy':1, 'on_ft':['vb', 'vbnet']})
	endif
	if !has('kaoriya')
		call dein#add('Shougo/vimproc', {'build': 'make'})
	endif
	if has('python')
		call dein#add('editorconfig/editorconfig-vim')
	endif

	call dein#end()
	call dein#save_state()
endif

filetype plugin indent on

source ~/.config/valiables.vim

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
		au QuickFixCmdPost vimgrep,grep Unite quickfix
		if exists("+omnifunc")
			au Filetype * if &ofu == "" | setlocal ofu=syntaxcomplete#Complete | endif
		endif
		au FileType unite imap <buffer> <ESC> <Plug>(unite_exit)
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
set synmaxcol=200
set visualbell t_vb=
set noerrorbells
colo eivy
syntax enable

"折り畳みの表示方式変更
set fdm=manual
set foldtext=FoldText()
fun! FoldText()
	let lines=string(v:foldend - v:foldstart +1)
	let top=substitute(getline(v:foldstart), '\t', repeat(' ', &ts), 'g')
	let foldinfo=repeat('*',v:foldlevel) . repeat(' ',5-len(lines)) . lines . 'L'
	let line=strpart(top,0,winwidth(0) - strdisplaywidth(foldinfo))
	let nuwidth=&nuw > len(line('$')) ? &nuw : len(line('$')) + 1
	return line . repeat(' ', winwidth(0)-(len(line)+len(foldinfo)+nuwidth)) . foldinfo
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

"CamelCaseMotion
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

"caw.vim
nmap <silent> <leader>g <Plug>(caw:hatpos:toggle:operator)
nmap <silent> <leader>gg <Plug>(caw:hatpos:toggle)
vmap <silent> <leader>g <Plug>(caw:hatpos:toggle)
nmap <silent> <leader>w <Plug>(caw:wrap:toggle:operator)
nmap <silent> <leader>ww <Plug>(caw:wrap:toggle)
vmap <silent> <leader>w <Plug>(caw:wrap:toggle)

"clang_complete
let g:clang_complete_auto=0
let g:clang_auto_select=2
let g:clang_library_path='/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/lib'

"ChooseWin
nmap <C-w><C-w> <Plug>(choosewin)
let g:choosewin_statusline_replace=0
let g:choosewin_blink_on_land=0
let g:choosewin_overlay_enable=1
let g:choosewin_overlay_clear_multibyte=1
let g:choosewin_color_overlay={'gui': ['#000dcc'], 'cterm': ['darkcyan']}
let g:choosewin_color_overlay_current={'gui': ['#0033ff'], 'cterm': ['cyan']}

"Emmet
let g:user_emmet_leader_key='<C-g>'

"Gista
let g:gista#client#user_git_config_github_username=1

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
		return "\ue725"
	else 
		return ''
	endif
endf

"Markdown Hightlight
let g:markdown_fenced_languages = [
	\'c',
	\'cs',
	\'c#=cs',
	\'css',
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

"NeoComplete
let g:neocomplete#enable_at_startup=1
let g:neocomplete#enable_smart_case=1
let g:neocomplete#use_vimproc=1
let g:neocomplete#auto_completion_start_length=2
if !exists('g:neocomplete#souces#omni#imput_patterns')
	let g:neocomplete#souces#omni#imput_patterns = {}
endif
let g:neocomplete#souces#omni#imput_patterns.cs = '.*[^=\);]'
let g:neocomplete#souces#omni#imput_patterns.go = '\h\w\+\.\w*'

"NeoSnippet
imap <C-k> <Plug>(neosnippet_expand_or_jump)
smap <C-k> <Plug>(neosnippet_expand_or_jump)
command! -nargs=0 SnipEdit NeoSnippetEdit

"NeoSnippet
let g:neosnippet#snippets_directory='~/.vim/snip'

"OpenBrowser
nmap goo <Plug>(openbrowser-open)
xmap goo <Plug>(openbrowser-open)
nmap gos <Plug>(openbrowser-smart-search)
xmap gos <Plug>(openbrowser-smart-search)

"QuickRun
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

"SaveVers
let savevers_types="*"
let savevers_dirs=&backupdir
let versdiff_no_resize=1
let savevers_max=30
nnoremap <silent> gdp :VersDiff -<CR>
nnoremap <silent> gdn :VersDiff +<CR>
nnoremap <silent> gde :VersDiff -c<CR>

"Syntastic
let g:syntastic_check_on_wq = 0
let g:syntstic_go_checkers=['golint', 'govet', 'errcheck']
let g:syntastic_mode_map={'map': 'active', 'passive_filetypes': ['go']}

"TagBar
let g:tagbar_type_go = {
	\'ctagstype' : 'go',
	\'kinds'     : [
	\	'p:package',
	\	'i:imports:1',
	\	'c:constants',
	\	'v:variables',
	\	't:types',
	\	'n:interfaces',
	\	'w:fields',
	\	'e:embedded',
	\	'm:methods',
	\	'r:constructor',
	\	'f:functions'
	\],
	\'sro' : '.',
	\'kind2scope' : {
	\	't' : 'ctype',
	\	'n' : 'ntype'
	\},
	\'scope2kind' : {
	\	'ctype' : 't',
	\	'ntype' : 'n'
	\},
	\'ctagsbin'  : 'gotags',
	\'ctagsargs' : '-sort -silent'
	\}

"Unite.vim
call unite#custom#profile('default', 'context', {'direction': 'belowright', 'winheight':10, 'auto-resize': 1, 'start_insert': 1})
call unite#custom#source('neomru/file', 'ignore_pattern', '+$\|.git/\|.svn/\|\%(^\%(fugitive\)://\)')
call unite#filters#matcher_default#use(['matcher_fuzzy'])
nnoremap <silent> gum :Unite neomru/file<CR>
nnoremap <silent> gub :Unite buffer<CR>
nnoremap <silent> guv :VimFilerExplorer<CR>
nnoremap <silent> <C-p> :Unite file_rec/async<CR>

"vim-indent-guides
let g:indent_guides_enable_on_vim_startup=0
let g:indent_guides_guide_size=1
let g:indent_guides_start_level=2
let g:indent_guides_exclude_filetypes=['help', 'quickrun', 'tagbar']
let g:indent_guides_color_change_percent=8
nnoremap <silent> <leader>gt :TagbarToggle<CR>

"vim-go
let g:go_highlight_functions=1
let g:go_highlight_methods=1
let g:go_highlight_structs=1
let g:go_fmt_command='goimports'

"vimfiler
let g:vimfiler_as_default_explorer=1
call vimfiler#custom#profile('default', 'context', {'safe': 0, 'simple': 1})
