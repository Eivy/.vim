"Author: Eivy
"Last Change: 04-Feb-2016.
" vi:tw=0 ts=4 sw=4
set enc=utf-8
scriptencoding utf-8

if has('vim_starting') && !has('win32') && !has('win32unix')
	set runtimepath+=~/.vim/remote/neobundle.vim
	call neobundle#begin('~/.vim/remote')
endif

NeoBundleFetch 'Shougo/neobundle.vim'

NeoBundle 'Eivy/savevers.vim'
NeoBundle 'Shougo/vimproc', {'build': {'mac': 'make', 'unix': 'make'}}
NeoBundle 'haya14busa/vim-migemo'
NeoBundle 'itchyny/lightline.vim'
NeoBundle 'justinmk/vim-dirvish'
NeoBundle 'kana/vim-textobj-user'
NeoBundle 'Shougo/neomru.vim'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'tpope/vim-fugitive'

NeoBundleLazy 'Eivy/Align', {'on_cmd': ['Align', 'AlignCtrl'],'on_map': '<leader>t'}
NeoBundleLazy 'Eivy/applescript.vim', {'on_ft': 'applescript'}
NeoBundleLazy 'Eivy/commenter.vim', {'on_map': '<Plug>(Commenter-'}
NeoBundleLazy 'Rip-Rip/clang_complete', {'on_ft': ['objc','c','cpp']}
NeoBundleLazy 'Shougo/neocomplete.vim', {'on_i': 1}
NeoBundleLazy 'Shougo/neosnippet', {'on_i': 1, 'on_ft': 'neosnippet'}
NeoBundleLazy 'Shougo/neosnippet-snippets', {'on_i': 1}
NeoBundleLazy 'bkad/CamelCaseMotion', {'on_map': '<Plug>CamelCaseMotion_'}
NeoBundleLazy 'fatih/vim-go', {'on_ft': 'go'}
NeoBundleLazy 'majutsushi/tagbar', {'on_cmd': 'TagbarToggle'}
NeoBundleLazy 'mattn/emmet-vim', {'on_ft': ['html','xhtml','css','xml','markdown','cs']}
NeoBundleLazy 'osyo-manga/unite-quickfix', {'on_cmd': ['gr', 'vimgrep']}
NeoBundleLazy 't9md/vim-choosewin', {'on_map': '<Plug>(choosewin)'}
NeoBundleLazy 'thinca/vim-fontzoom', {'on_cmd': 'Fontzoom'}
NeoBundleLazy 'thinca/vim-quickrun', {'on_cmd': 'QuickRun','on_map': '<leader>r'}
NeoBundleLazy 'tpope/vim-surround', {'on_map': ['n', 'ds', 'cs', 'ys']}
NeoBundleLazy 'tyru/open-browser.vim', {'on_map': '<Plug>(openbrowser-'}
NeoBundleLazy 'vim-scripts/diffchar.vim', {'on_map': ['<F7>','<F8>']}
NeoBundleLazy 'vim-scripts/vcscommand.vim', {'on_cmd': ['VCSBlame', 'VCSDiff']}
NeoBundleLazy 'zhaocai/DirDiff.vim', {'on_cmd': 'DirDiff'}

call neobundle#end()

filetype plugin indent on

if has('autocmd') && has('syntax')
	fun! <SID>ZenkakuSpace()
		hi ZenkakuSpace cterm=underline ctermfg=yellow gui=underline guifg=#FFFF00
	endf
	aug Eivy
		au!
		au FileType help setlocal nonu nornu
		au FileType quickrun set nowrap
		au FileType * set fo-=c fo-=r fo-=o
		au BufRead,WinEnter,VimEnter * match ZenkakuSpace /　/
		au BufLeave * set nornu
		au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exec "normal! g'\"" | endif
		au BufReadPost,WinEnter,VimEnter * if &ft !~ 'fugitiveblame\|tagbar\|help' | set rnu nu | endif
		au ColorScheme * call <SID>ZenkakuSpace()
		au InsertEnter,InsertLeave * set imi=0 ims=0
		au QuickFixCmdPost vimgrep,grep NeoBundleSource unite-quickfix | Unite quickfix
		if exists("+omnifunc")
			au Filetype * if &ofu == "" | setlocal ofu=syntaxcomplete#Complete | endif
		endif
		au FileType unite imap <buffer> <ESC> <Plug>(unite_exit)
	aug END
endif

"option
set t_Co=256
set bk bdir=~/.clean pm=+ noswf nocul noudf
set dy=lastline fo=BqljmM go=C hi=50 ls=2 hls
set nu rnu ic scs sm sw=4 ts=4 nf=hex sc ch=1
set wmnu wim=longest:full,full is nows wrap
set list lcs=trail:«,tab:»\ ,extends:>,precedes:>
set grepprg=ag\ --nogroup\ --nocolor
set dip=filler,vertical
set ambiwidth=single
set ai backspace=indent,eol,start
set fencs=utf-8,ucs-bom,cp932,utf-16le,utf-16be,default
set iskeyword=_,-,a-z,A-Z,48-57,128-167,224-235
set vi='100,<50,s10,h,n~/.vim/info
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

"Commenter
nmap <leader>gg <Plug>(Commenter-toggle)
xmap <leader>g <Plug>(Commenter-toggle)
nmap <leader>g <Plug>(Commenter-toggle-with-motion)

"Emmet
let g:user_emmet_leader_key='<C-g>'

"LigntLine
let g:lightline = {
	\'colorscheme': 'eivy',
	\'active': {
	\	'left': [['mode'], ['ro'], ['git'], ['path']],
	\	'right': [['line', 'co'], ['type', 'enc', 'ff']]
	\},
	\'inactive': {
	\	'left': [['ro'], ['path']],
	\	'right': [['line'], ['type', 'enc', 'ff']]
	\},
	\'component': {
	\	'co': '%3v',
	\	'enc': '%{strlen(&fenc)?&fenc:&enc}',
	\	'ff': '%{&ff}',
	\	'line': '%4l:%4L',
	\	'mode': '%{lightline#mode()}',
	\	'path': '%f %M',
	\	'ro': '%R',
	\	'type': '%Y',
	\},
	\'component_expand': {
	\	'git': 'LlGit',
	\},
	\'subseparator': {'left': '', 'right': '',},
	\'enable': {'tabline': 0}
	\}

fun! LlGit()
	return fugitive#head()
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
let g:neocomplete#souces#omni#imput_patterns.go = '\h\w\.\w*'

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

"Unite.vim
call unite#custom#profile('default', 'context', {'direction': 'belowright', 'winheight':10, 'auto-resize': 1, 'start_insert': 1})
call unite#custom#source('neomru/file', 'ignore_pattern', '+$\|.git/\|.svn/\|\%(^\%(fugitive\)://\)')
call unite#custom#default_action('file', 'above')
call unite#filters#matcher_default#use(['matcher_fuzzy'])
nnoremap <silent> gm :Unite neomru/file<CR>
nnoremap <silent> gb :Unite buffer<CR>
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
