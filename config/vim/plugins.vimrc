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
Plug 'majutsushi/tagbar'

" Show git status in the gutter
Plug 'airblade/vim-gitgutter'

" Git wrapper
Plug 'tpope/vim-fugitive'

" Syntax checking
Plug 'scrooloose/syntastic'

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
Plug 'wincent/command-t'

" Enhanced matching of tags
Plug 'tmhedberg/matchit'

" Awesome visual drag plugin
Plug 'jondkinney/dragvisuals.vim'

" Status line plugin w/ themes
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Tmux navigation integration
Plug 'christoomey/vim-tmux-navigator'

" Autocompletion
if (has('lua'))
	Plug 'Shougo/neocomplete'
endif

" Completion snippets
Plug 'Shougo/neosnippet'
Plug 'Shougo/neosnippet-snippets'
Plug 'honza/vim-snippets'
Plug 'Shougo/vimshell'

" Lazy / deferred loaded plugins (to decrease startup time)

" File explorer
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }

" Code completion
Plug 'moll/vim-node', { 'for': ['javacript'] }
Plug '1995eaton/vim-better-javascript-completion', { 'for': ['javascript']}
Plug 'OmniSharp/omnisharp-vim', { 'for': ['javascript', 'css', 'java', 'cs'] }
Plug 'artur-shaik/vim-javacomplete2', { 'for': ['java'] }
Plug 'leafgarland/typescript-vim', { 'for': ['typescript'] }

call plug#end()


set rtp+=~/.vim/bundle/plugin

" Make JSON beautiful
command! FormatJSON %!python -m json.tool

" Plugin Configurations

" Airline theme config
let g:airline_theme="base16color"

" Adds ascii code values to the right of airline status bar in hex and decimalj
let g:airline_section_z = '%3p%% %#__accent_bold#%{g:airline_symbols.linenr}%4l%#__restore__#%#__accent_bold#/%L%{g:airline_symbols.maxlinenr}%#__restore__# :%3v | %03b 0x%0B'

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
autocmd FileType cs setlocal omnifunc=csscomplete#Complete
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
autocmd FileType java setlocal omnifunc=javacomplete#Complete


" Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
	let g:neocomplete#sources#omni#input_patterns = {}
endif

" For perlomni.vim setting.
" https://github.com/c9s/perlomni.vim
let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'

