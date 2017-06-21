"------------------------------------------------------------------------------
" init.vimrc
" Starting point for loading modular vimrc config
"------------------------------------------------------------------------------
set nocompatible
filetype on

let s:configDir = "~/dotfiles/config/vim"

function! SourceConf(name)
	execute "source " . s:configDir . "/" . a:name
endfunction

function! EditConf(name)
	execute "edit " . s:configDir ."/" . a:name
endfunction

" Load third party plugins
call SourceConf('plugins.vimrc')

" Load custom defined functions
call SourceConf('myfuncs.vimrc')

" Load general editor tweaks / settings
call SourceConf('general.vimrc')

" Load keymappings
call SourceConf('mappings.vimrc')

" Helpful toggles to quickly edit the above files
autocmd FileType vim map <buffer> <leader>p :call EditConf('plugins.vimrc')<CR>
autocmd FileType vim map <buffer> <leader>f :call EditConf('myfuncs.vimrc')<CR>
autocmd FileType vim map <buffer> <leader>g :call EditConf('general.vimrc')<CR>
autocmd FileType vim map <buffer> <leader>m :call EditConf('mappings.vimrc')<CR>
