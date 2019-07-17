" vim: sw=4 ts=4 noet fdl=0 fdm=marker:
hi clear
if exists("syntax_on") | syntax reset | endif
set background=dark
let g:colors_name="eivy"

if has("gui_running") || &t_Co == 256
	" functions {{{
	" returns an approximate grey index for the given grey level
	fun! <SID>grey_number(x)
		if &t_Co == 88
			if a:x < 23
				return 0
			elseif a:x < 69
				return 1
			elseif a:x < 103
				return 2
			elseif a:x < 127
				return 3
			elseif a:x < 150
				return 4
			elseif a:x < 173
				return 5
			elseif a:x < 196
				return 6
			elseif a:x < 219
				return 7
			elseif a:x < 243
				return 8
			else
				return 9
			endif
		else
			if a:x < 14
				return 0
			else
				let l:n = (a:x - 8) / 10
				let l:m = (a:x - 8) % 10
				if l:m < 5
					return l:n
				else
					return l:n + 1
				endif
			endif
		endif
	endfun

	" returns the actual grey level represented by the grey index
	fun! <SID>grey_level(n)
		if &t_Co == 88
			if a:n == 0
				return 0
			elseif a:n == 1
				return 46
			elseif a:n == 2
				return 92
			elseif a:n == 3
				return 115
			elseif a:n == 4
				return 139
			elseif a:n == 5
				return 162
			elseif a:n == 6
				return 185
			elseif a:n == 7
				return 208
			elseif a:n == 8
				return 231
			else
				return 255
			endif
		else
			if a:n == 0
				return 0
			else
				return 8 + (a:n * 10)
			endif
		endif
	endfun

	" returns the palette index for the given grey index
	fun! <SID>grey_color(n)
		if &t_Co == 88
			if a:n == 0
				return 16
			elseif a:n == 9
				return 79
			else
				return 79 + a:n
			endif
		else
			if a:n == 0
				return 16
			elseif a:n == 25
				return 231
			else
				return 231 + a:n
			endif
		endif
	endfun

	" returns an approximate color index for the given color level
	fun! <SID>rgb_number(x)
		if &t_Co == 88
			if a:x < 69
				return 0
			elseif a:x < 172
				return 1
			elseif a:x < 230
				return 2
			else
				return 3
			endif
		else
			if a:x < 75
				return 0
			else
				let l:n = (a:x - 55) / 40
				let l:m = (a:x - 55) % 40
				if l:m < 20
					return l:n
				else
					return l:n + 1
				endif
			endif
		endif
	endfun

	" returns the actual color level for the given color index
	fun! <SID>rgb_level(n)
		if &t_Co == 88
			if a:n == 0
				return 0
			elseif a:n == 1
				return 139
			elseif a:n == 2
				return 205
			else
				return 255
			endif
		else
			if a:n == 0
				return 0
			else
				return 55 + (a:n * 40)
			endif
		endif
	endfun

	" returns the palette index for the given R/G/B color indices
	fun! <SID>rgb_color(x, y, z)
		if &t_Co == 88
			return 16 + (a:x * 16) + (a:y * 4) + a:z
		else
			return 16 + (a:x * 36) + (a:y * 6) + a:z
		endif
	endfun

	" returns the palette index to approximate the given R/G/B color levels
	fun! <SID>color(r, g, b)
		" get the closest grey
		let l:gx = <SID>grey_number(a:r)
		let l:gy = <SID>grey_number(a:g)
		let l:gz = <SID>grey_number(a:b)

		" get the closest color
		let l:x = <SID>rgb_number(a:r)
		let l:y = <SID>rgb_number(a:g)
		let l:z = <SID>rgb_number(a:b)

		if l:gx == l:gy && l:gy == l:gz
			" there are two possibilities
			let l:dgr = <SID>grey_level(l:gx) - a:r
			let l:dgg = <SID>grey_level(l:gy) - a:g
			let l:dgb = <SID>grey_level(l:gz) - a:b
			let l:dgrey = (l:dgr * l:dgr) + (l:dgg * l:dgg) + (l:dgb * l:dgb)
			let l:dr = <SID>rgb_level(l:gx) - a:r
			let l:dg = <SID>rgb_level(l:gy) - a:g
			let l:db = <SID>rgb_level(l:gz) - a:b
			let l:drgb = (l:dr * l:dr) + (l:dg * l:dg) + (l:db * l:db)
			if l:dgrey < l:drgb
				" use the grey
				return <SID>grey_color(l:gx)
			else
				" use the color
				return <SID>rgb_color(l:x, l:y, l:z)
			endif
		else
			" only one possibility
			return <SID>rgb_color(l:x, l:y, l:z)
		endif
	endfun

	" returns the palette index to approximate the 'rrggbb' hex string
	fun! <SID>rgb(rgb)
		let l:r = ("0x" . strpart(a:rgb, 0, 2)) + 0
		let l:g = ("0x" . strpart(a:rgb, 2, 2)) + 0
		let l:b = ("0x" . strpart(a:rgb, 4, 2)) + 0

		return <SID>color(l:r, l:g, l:b)
	endfun

	" sets the highlighting for the given group
	fun! <SID>X(group, fg, bg, attr)
		if a:fg != ""
			if a:fg !~ '\x\{6}'
				exec "hi " . a:group . " guifg=" . a:fg . " ctermfg=" . a:fg
			else
				exec "hi " . a:group . " guifg=#" . a:fg . " ctermfg=" . <SID>rgb(a:fg)
			endif
		endif
		if a:bg != ""
			if a:bg !~ '\x\{6}'
				exec "hi " . a:group . " guibg=" . a:bg . " ctermbg=" . a:bg
			else
				exec "hi " . a:group . " guibg=#" . a:bg . " ctermbg=" . <SID>rgb(a:bg)
			endif
		endif
		if a:attr != ""
			exec "hi " . a:group . " gui=" . a:attr . " cterm=" . a:attr
		endif
	endfun
	" }}}

	"General colors
	call <SID>X("Cursor", "000000", "00dee2", "none")
	call <SID>X("CursorIM", "000000", "ffaa00", "none")
	call <SID>X("Normal", "cccccc", "000000", "none")
	call <SID>X("NonText", "a00058", "000000", "none")
	call <SID>X("LineNr", "888888", "2d3a5d", "none")
	call <SID>X("CursorLineNr", "ffffff", "3b659f", "none")
	call <SID>X("StatusLineNC", "888888", "4f0303", "none")
	call <SID>X("StatusLine", "ffffff", "0a48cf", "none")
	call <SID>X("VertSplit", "3b659f", "2d3a5d", "none")
	call <SID>X("Folded", "707070", "000000", "underline")
	call <SID>X("Title", "f6f3e8", "NONE", "bold")
	call <SID>X("SpecialKey", "303030", "NONE", "underline")
	call <SID>X("SignColumn", "cccccc", "cccccc", "")

	call <SID>X("Visual", "NONE", "243a4f", "")

	call <SID>X("CursorLine", "", "102035", "none")
	call <SID>X("CursorColumn", "", "102035", "none")

	call <SID>X("DiffAdd", "", "000080", "")
	call <SID>X("DiffDelete", "ff0000", "700000", "none")
	call <SID>X("DiffChange", "", "000000", "")
	call <SID>X("DiffText", "", "005000", "none")

	call <SID>X("Directory", "90ff93", "", "")

	call <SID>X("Search", "NONE", "NONE", "reverse")
	call <SID>X("MatchParen", "ff5f5f", "000000", "")

	call <SID>X("Pmenu", "429dff", "111111", "none")
	call <SID>X("PmenuSel", "000000", "efcc6b", "none")
	call <SID>X("PmenuSbar", "000000", "000000", "none")
	call <SID>X("PmenuThumb", "000000", "dfdfdf", "none")

	call <SID>X("TabLine", "66a2df", "243a4f", "none")
	call <SID>X("TabLineFill", "243a4f", "243a4f", "underline")
	call <SID>X("TabLineSel", "243a4f", "66a2df", "none")

	call <SID>X("Comment", "888888", "", "none")
	call <SID>X("Constant", "c8d079", "", "none")
	call <SID>X("Identifier", "797dc8", "", "none")
	call <SID>X("Statement", "79c4c8", "", "none")
	call <SID>X("PreProc", "77dd99", "", "none")
	call <SID>X("Type", "5588cc", "", "none")
	call <SID>X("Special", "f08000", "", "none")
	call <SID>X("Tag", "f08000", "", "underline")
	call <SID>X("Underlined", "79b0c8", "", "")
	call <SID>X("Todo", "ffff00", "000000", "")
	call <SID>X("Error", "ff0000", "000000", "")

	call <SID>X("Title", "79a9c8", "", "bold")

	" delete functions {{{
	delf <SID>X
	delf <SID>rgb
	delf <SID>color
	delf <SID>rgb_color
	delf <SID>rgb_level
	delf <SID>rgb_number
	delf <SID>grey_color
	delf <SID>grey_level
	delf <SID>grey_number
	" }}}
else
	hi Cursor ctermfg=black ctermbg=cyan cterm=none
	hi CursorIM ctermfg=black ctermbg=red
	hi Normal ctermfg=white ctermbg=black cterm=none
	hi NonText ctermfg=blue ctermbg=black cterm=none
	hi LineNr ctermfg=white ctermbg=darkgray cterm=none
	hi CursorLineNr ctermfg=white ctermbg=darkblue cterm=none
	hi StatusLineNC ctermfg=black ctermbg=darkgray cterm=none
	hi StatusLine ctermfg=white ctermbg=darkblue cterm=none
	hi VertSplit ctermfg=darkgray ctermbg=darkblue cterm=none
	hi Folded ctermfg=darkred ctermbg=darkgray cterm=none
	hi Title ctermfg=white ctermbg=none cterm=bold
	hi SpecialKey ctermfg=darkgray ctermbg=black cterm=underline

	hi Visual ctermbg=darkgray

	hi CursorLine ctermbg=darkgray cterm=none
	hi CursorColumn ctermbg=darkgray cterm=none

	hi DiffAdd ctermbg=darkgreen
	hi DiffDelete ctermfg=red ctermbg=darkred cterm=none
	hi DiffChange ctermbg=darkblue

	hi Search ctermfg=NONE ctermbg=NONE cterm=reverse
	hi MatchParen ctermfg=lightgreen ctermbg=black

	hi Pmenu ctermfg=white ctermbg=darkblue cterm=none
	hi PmenuSel ctermfg=black ctermbg=yellow cterm=none
	hi PmenuSbar ctermfg=black ctermbg=black cterm=none
	hi PmenuThumb ctermfg=white ctermbg=white cterm=none

	hi TabLine ctermfg=black ctermbg=darkblue cterm=none
	hi TabLineFill ctermfg=black ctermbg=black cterm=underline
	hi TabLineSel ctermfg=white ctermbg=blue cterm=none

	"Syntax highlighting
	hi Comment ctermfg=lightgray cterm=none
	hi Constant ctermfg=yellow cterm=none
	hi Identifier ctermfg=magenta cterm=none
	hi Statement ctermfg=blue cterm=none
	hi PreProc ctermfg=darkyellow cterm=none
	hi Type ctermfg=darkblue cterm=none
	hi Special ctermfg=red
	hi Tag ctermfg=red cterm=underline
	hi Underlined ctermfg=cyan
	hi Todo ctermfg=yellow
	hi Error ctermfg=red

	hi Title ctermfg=cyan cterm=bold
endif

