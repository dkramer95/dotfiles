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

" Load third party plugins
call SourceConf('plugins.vimrc')

" Load custom defined functions
call SourceConf('myfuncs.vimrc')

" Load general editor tweaks / settings
call SourceConf('general.vimrc')

" Load keymappings
call SourceConf('mappings.vimrc')

" Add any additional .vimrc confs below
call SourceConf('style.vimrc')


" Helpful toggles to quickly edit the above files
augroup ConfToggles
	autocmd!
	autocmd FileType vim map <buffer> <LocalLeader>p :call EditConf('plugins.vimrc')<CR>
	autocmd FileType vim map <buffer> <LocalLeader>f :call EditConf('myfuncs.vimrc')<CR>
	autocmd FileType vim map <buffer> <LocalLeader>g :call EditConf('general.vimrc')<CR>
	autocmd FileType vim map <buffer> <LocalLeader>m :call EditConf('mappings.vimrc')<CR>
	autocmd FileType vim map <buffer> <LocalLeader>s :call EditConf('style.vimrc')<CR>
augroup END
