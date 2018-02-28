function! s:config()
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
endfunction

function! s:loaded_on()
  return 'start'
endfunction

function! s:depends()
  return []
endfunction
