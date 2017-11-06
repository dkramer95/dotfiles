"------------------------------------------------------------------------------
" init.vimrc
" Starting point for loading modular vimrc config
"------------------------------------------------------------------------------
set nocompatible
filetype on

" Specify path to where this conf module lives
let s:configDir = "~/dotfiles/config/vim"

" Sources the specified file
func! SourceConf(name)
	execute "source " . s:configDir . "/" . a:name
endfunc

" Opens the specified file
func! EditConf(name)
	execute "edit " . s:configDir ."/" . a:name
endfunc

" Module Name, Mapping
let modules = [
\	['plugins',       'p'],
\	['myfuncs',       'f'],
\	['general',       'g'],
\	['mappings',      'm'],
\	['style',         's'],
\]

augroup ConfToggles
	autocmd!
	for [mod, map] in modules
		let mod = mod . '.vimrc'
		call SourceConf(mod)
		execute "autocmd FileType vim map <buffer> <LocalLeader>" . map .
				\" :call EditConf('" . mod . "')<CR>"
	endfor
augroup END
