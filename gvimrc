"      Author: Eivy
" Last Change: 04-Dec-2014.
scriptencoding=utf-8

"---------------------------------------------------------------------------
" フォント設定:
if has('mac')
	"フォント
	set gfn=Migu\ 1M\ Regular:h12
	set ambiwidth=double
elseif has('xfontset')
	" UNIX用 (xfontsetを使用)
	set guifontset=a14,r14,k14
endif

"---------------------------------------------------------------------------
" マウスに関する設定:
" どのモードでもマウスを使えるようにする
set mouse=a
" マウスの移動でフォーカスを自動的に切替えない (mousefocus:切替る)
set nomousefocus
" 入力時にマウスポインタを隠す (nomousehide:隠さない)
set mousehide

"---------------------------------------------------------------------------
" 印刷に関する設定:
"
" 注釈:
" 印刷はGUIでなくてもできるのでvimrcで設定したほうが良いかもしれない。この辺
" りはWindowsではかなり曖昧。一般的に印刷には明朝、と言われることがあるらし
" いのでデフォルトフォントは明朝にしておく。ゴシックを使いたい場合はコメント
" アウトしてあるprintfontを参考に。
"
" 印刷用フォント
if has('printer')
	if has('mac')
		set printfont=Migu_1M:h8
	endif
endif

"---------------------------------------------------------------------------
" 表示に関する設定:
" guioptions
set guioptions=C

" 現在のウインドウのカレント行強調表示
set cmdheight=1

" stop bell
set visualbell t_vb=

"for 'tab change' KeyRemap
nnoremap	<C-tab>		gt
nnoremap	<C-S-tab>	gT

"Fontzoom
let g:fontzoom_no_default_key_mappings=1
