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
