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

Plug 'tpope/vim-surround' 		" Surround text
Plug 'majutsushi/tagbar' 			" Class/Function Outline Viewer
Plug 'airblade/vim-gitgutter' 	" Show git status in the gutter
Plug 'tpope/vim-fugitive'
Plug 'scrooloose/syntastic' 		" Syntax checking
Plug 'scrooloose/nerdtree' 		" File Explorer
Plug 'gioele/vim-autoswap' 		" Fix swap file prompts
Plug 'alvan/vim-closetag' 		" Autoclose pairs
Plug 'jiangmiao/auto-pairs' 		" Autocomplete matching pairs
Plug 'tomtom/tcomment_vim' 		" Commenting
Plug 'Flazz/vim-colorschemes' 	" Bunch of cool colorschemes
Plug 'ctrlpvim/ctrlp.vim' 		" Fast Fuzzy File finder

" Plug 'moll/vim-node' 				" NodeJS
Plug 'tpope/vim-dispatch'

" Autocompletion / snippets
Plug 'Shougo/neosnippet'
Plug 'Shougo/neosnippet-snippets'
Plug 'Shougo/vimshell'
Plug 'Shougo/neocomplete'

" Plugin '1995eaton/vim-better-javascript-completion'
" Plugin 'OmniSharp/omnisharp-vim' 	" C#
" Plugin 'artur-shaik/vim-javacomplete2' "Java completion

Plug 'tmhedberg/matchit' 			" Enhanced matching of tags

Plug 'jondkinney/dragvisuals.vim' " Awesome visual drag plugin
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'leafgarland/typescript-vim'

Plug 'christoomey/vim-tmux-navigator' " Tmux navigation integration
call plug#end()

set rtp+=~/.vim/bundle/plugin

" Make JSON beautiful
command! FormatJSON %!python -m json.tool

" Plugin Configurations

" Airline theme config
let g:airline_theme="base16color"


" Syntastic config
set statusline=%<%f\ %h%m%r%=%-14.(%l,%c%V%)\ %P
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

" Neocomplete Config
let g:acp_enableAtStartup = 0
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 3

" Define dictionary.
let g:neocomplete#sources#dictionary#dictionaries = {
			\ 'default' : '',
			\ 'vimshell' : $HOME.'/.vimshell_hist',
			\ 'scheme' : $HOME.'/.gosh_completions'
			\ }

" Define keyword.
if !exists('g:neocomplete#keyword_patterns')
	let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
	let g:neocomplete#sources#omni#input_patterns = {}
endif

" For perlomni.vim setting.
" https://github.com/c9s/perlomni.vim
let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'

