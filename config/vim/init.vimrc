"------------------------------------------------------------------------------
" init.vimrc
" Starting point for loading modular vimrc config
"------------------------------------------------------------------------------
set nocompatible
filetype on

" Specify path to where this conf module lives
let s:configDir = "~/dotfiles/config/vim"

" Specify prefix key to use before module mapping
let s:mPrefix = "<LocalLeader>"

"------------------------------------------------------------------------------
" ['mod_name', 'mapping', 'enabled']
"
" * When cursor positioned in list, several shortcuts are available:
" {mapping} - Description
" <CR>  - Edit Module
" s		- Horizontal split Module
" vv	- Vertical Split Module
" t		- Toggles: Enable / Disable on Module
"------------------------------------------------------------------------------
" Additionally the defined prefix and mappings in the list below also allow
" you to directly edit file from within anywhere in the vimrc context
let s:modules = [
\	['plugins',    'p', 1],
\	['myfuncs',    'f', 1],
\	['general',    'g', 1],
\	['mappings',   'm', 1],
\	['style',      's', 1],
\]

" * Can return to this section automatically by pressing 'gm' (within this file)
"------------------------------------------------------------------------------



" Current modline or lack thereof
let s:ModLine = []


" Sources the specified file
func! SourceMod(mod)
	execute "source " . s:AbsMod(a:mod)
endfunc

" Opens the specified file
func! EditMod(mod)
	execute "edit " . s:AbsMod(a:mod)
endfunc

" Checks to see if line matches module name pattern and opens it if it does
func! OpenMod()
	if (s:IsModLine())
		call EditMod(s:ModLine[1])
	endif
endfunc

" Checks if cursor is on a line containing module. As a side effect the
" s:ModLine variable is updated with the results, to be used in other
" functions
func! s:IsModLine()
	let pattern = "\\['\\([a-z]\\+\\)',\\s\\+'\\([a-z]\\)',\\s\\+\\([01]\\)],"
	let s:ModLine = matchlist(getline("."), pattern)
	return len(s:ModLine) > 1
endfunc

" Toggles a module (if on a module line) between 0 / 1
func! ToggleMod()
	if (s:IsModLine())
		" Go home to prevent replacing wrong character
		normal! 0
		let mod = s:ModLine[1]
		let useVal = s:ModLine[3]
		" Move cursor to enable switch, but only on current line
		call search(useVal, '', line("."))

		if (useVal != 0)
			normal r0
			echo "Disabled Module: [" . mod . "]"
		else
			normal r1
			echo "Enabled Module: [" . mod . "]"
		endif
	endif
endfunc

" Creates a split with the module under the cursor (if exists)
func! SplitMod(split)
	if (s:IsModLine())
		execute a:split . " " . s:AbsMod(s:ModLine[1])
	endif
endfunc

" Returns absolute path to the specified module name
func! s:AbsMod(mod)
	return s:configDir . "/" . a:mod . ".vimrc"
endfunc

func! GoToModLines()
	normal! gg
	call search("let s:modules = [")
	call cursor(line(".") + 1, 0)
endfunc

" Positions cursor at the first module in the list below
func! s:OnVimrcLoad()
	call GoToModLines()
	nnoremap <buffer>t :call ToggleMod()<CR>
	nnoremap <buffer>s :call SplitMod("split")<CR>
	nnoremap <buffer>vv :call SplitMod("vsplit")<CR>
	nnoremap <buffer>gm :call GoToModLines()<CR>
endfunc

" Load and create toggles for each module
augroup ModToggles
	autocmd!
	for [mod, map, use] in s:modules
		if (use == 1)
			call SourceMod(mod)
		endif
			" Create keyboard toggle shortcut
			execute "autocmd FileType vim map <buffer> " . s:mPrefix . map .
					\" :call EditMod('" . mod . "')<CR>"
			autocmd FileType vim map <buffer> <silent><CR> :call OpenMod()<CR>
	endfor
	autocmd BufReadPost .vimrc call s:OnVimrcLoad()
augroup END


" Module highlighting things
let s:enabledPattern  = "\\['[a-z]\\+',\\s\\+'[a-z]',\\s\\+[1]],"
let s:disabledPattern = "\\['[a-z]\\+',\\s\\+'[a-z]',\\s\\+[0]],"

highlight ModEnabled ctermfg=148 cterm=bold
highlight ModDisabled ctermbg=160 ctermfg=255 cterm=bold

call matchadd("ModEnabled",  s:enabledPattern)
call matchadd("ModDisabled", s:disabledPattern)
