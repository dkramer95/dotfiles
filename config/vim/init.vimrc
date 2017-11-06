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

"-------------------------------------
" ['module_name', 'mapping', 'enabled']
let modules = [
\	['plugins',    'p', 1],
\	['myfuncs',    'f', 1],
\	['general',    'g', 1],
\	['mappings',   'm', 1],
\	['style',      's', 1],
\]
"-------------------------------------


" Sources the specified file
func! SourceConf(name)
	execute "source " . s:configDir . "/" . a:name
endfunc

" Opens the specified file
func! EditConf(name)
	execute "edit " . s:configDir ."/" . a:name
endfunc

" Checks to see if line matches module name pattern and opens it if it does
func! OpenConf()
	let matchlist = matchlist(getline("."), "\\['\\([a-z]\\+\\)',")
	if len(matchlist) > 1
		call EditConf(matchlist[1] . ".vimrc")
	endif
endfunc

" Positions cursor at the first module in the list below
func! OnVimrcLoad()
	call search("let modules = [")
	call cursor(line(".") + 1, 0)
endfunc

" Create toggles for each of the defined mappings in module list
augroup ConfToggles
	autocmd!
	for [mod, map, use] in modules
		if (use == 1)
			let mod = mod . '.vimrc'
			call SourceConf(mod)
			execute "autocmd FileType vim map <buffer> " . s:mPrefix . map .
					\" :call EditConf('" . mod . "')<CR>"
			autocmd FileType vim map <buffer> <silent><CR> :call OpenConf()<CR>
		endif
	endfor
	autocmd BufReadPost .vimrc call OnVimrcLoad()
augroup END
