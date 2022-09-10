"------------------------------------------------------------------------------
" plugins.vimrc
" Handles loading all third party plugins and contains config options for them
"------------------------------------------------------------------------------

set nocompatible		" enter the 21st Century

" Guard to ensure we have 'plug' installed to manage our plugins
if empty(glob('~/.vim/autoload/plug.vim'))
	silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
		\ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif


" Plugins (managed via Plug)
call plug#begin('~/.vim/bundle')

" Surround text
Plug 'tpope/vim-surround'

" Class/Function Outline Viewer
Plug 'majutsushi/tagbar', { 'for': ['javascript', 'css', 'java', 'cs', 'cpp', 'c', 'python'] }

" Show git status in the gutter
Plug 'airblade/vim-gitgutter', { 'on': ['GitGutterEnable'] }

" Git wrapper
Plug 'tpope/vim-fugitive'

" Git conflict resolution (reliant on fugitive)
Plug 'christoomey/vim-conflicted'

" Syntax checking
Plug 'scrooloose/syntastic', { 'for': ['javascript', 'css', 'java', 'cs', 'cpp', 'c', 'html', 'python'] }

" Fix swap file prompts
Plug 'gioele/vim-autoswap'

" Autoclose pairs
Plug 'alvan/vim-closetag'

" Autocomplete matching pairs
Plug 'jiangmiao/auto-pairs'

" Commenting
Plug 'tomtom/tcomment_vim'

" Bunch of cool colorschemes
Plug 'Flazz/vim-colorschemes'

" Fast Fuzzy File finder
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Enhanced matching of tags
Plug 'tmhedberg/matchit'

" Multiple cursors
Plug 'terryma/vim-multiple-cursors'

" Awesome visual drag plugin
Plug 'jondkinney/dragvisuals.vim'

" Status line plugin w/ themes
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Utility for tab management
Plug 'gcmt/taboo.vim'

" Tmux navigation integration
Plug 'christoomey/vim-tmux-navigator'

" Async build / test dispatcher (required with omnisharp)
Plug 'tpope/vim-dispatch'

" Async Run
Plug 'skywind3000/asyncrun.vim'

" Buffer switching plugin
Plug 'dkramer95/KSwitch'

" Focus Events for use with tmux
Plug 'tmux-plugins/vim-tmux-focus-events'

" Better clipboard integration with tmux
Plug 'roxma/vim-tmux-clipboard'

" Automatically adjust indentation based on current file
Plug 'tpope/vim-sleuth'

" More contextually aware snippet suggestions
Plug 'Shougo/context_filetype.vim'

" Lazy / deferred loaded plugins (to decrease startup time)

" File explorer
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }


call plug#end()


set rtp+=~/.vim/bundle/plugin

" Make JSON beautiful
command! FormatJSON %!python -m json.tool

" Shorter ctags
command! MakeTags !ctags -R

" Plugin Configurations

" Airline config
let g:airline#extensions#whitespace#mixed_indent_algo = 1

" Command-T config
let g:CommandTMaxFiles = 50000

" Update time we normally want
let s:normalUpdateTime = 2000

" Update time for first launch
let s:firstUpdateTime = 10
exec "set updatetime=" . s:firstUpdateTime

" Syntastic config
if exists('g:loaded_syntastic_plugin')
	set statusline=%<%f\ %h%m%r%=%-14.(%l,%c%V%)\ %P
	set statusline+=%#warningmsg#
	set statusline+=%{SyntasticStatuslineFlag()}
	set statusline+=%*
endif

" Handle loading heavy weight plugins after startup
func! s:LazyLoadPlugins()
	if !exists('g:lazily_loaded_plugins')

		" Load GitGutter
		GitGutterEnable

		" Unregister autocmd for lazily loading plugins
		augroup lazyLoadGroup
			autocmd!
		augroup END

		let g:lazily_loaded_plugins = 1
		exec "set updatetime=" . s:normalUpdateTime
	endif
endfunc

" Wait for cursor hold before lazily loading
augroup lazyLoadGroup
	autocmd CursorHold * call s:LazyLoadPlugins()
augroup END
