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
Plug 'airblade/vim-gitgutter'

" Git wrapper
Plug 'tpope/vim-fugitive'

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

" Async build / test dispatcher (required with omnisharp)
Plug 'tpope/vim-dispatch'

" Buffer switching plugin
Plug 'googie109/KSwitch'


" Autocompletion
if (has('lua'))
	Plug 'Shougo/neocomplete'
endif

" Completion snippets
Plug 'Shougo/neosnippet'
Plug 'Shougo/neosnippet-snippets'
Plug 'honza/vim-snippets'
Plug 'Shougo/vimshell'

" OpenGL Syntax
Plug 'tikhomirov/vim-glsl'

" More contextually aware snippet suggestions
Plug 'Shougo/context_filetype.vim'

" Vim autocomplete
Plug 'Shougo/neco-vim'

" Pug syntax plugin
Plug 'digitaltoad/vim-pug'

" Lazy / deferred loaded plugins (to decrease startup time)

" File explorer
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }

" Code completion
Plug 'moll/vim-node', { 'for': ['javascript'] }
Plug '1995eaton/vim-better-javascript-completion', { 'for': ['javascript']}
Plug 'OmniSharp/omnisharp-vim', { 'for': ['css', 'java', 'cs'] }
Plug 'ctrlpvim/ctrlp.vim', { 'for': ['javascript', 'css', 'java', 'cs'] }
Plug 'artur-shaik/vim-javacomplete2', { 'for': ['java'] }
Plug 'leafgarland/typescript-vim', { 'for': ['typescript'] }

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


" Syntastic config
set statusline=%<%f\ %h%m%r%=%-14.(%l,%c%V%)\ %P
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

" Neosnippets config
let g:neosnippet#snippets_directory = '~/.vim/bundle/vim-snippets/snippets'

" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 3
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

" Define dictionary.
let g:neocomplete#sources#dictionary#dictionaries = {
	\ 'default' : '',
	\ 'vimshell' : $HOME.'/.vimshell_hist',
	\ 'scheme' : $HOME.'/.gosh_completions'
	\ }

" Define keyword.
if !exists('g:neocomplete#keyword_patterns')
	let g:neocomplete#keyword_patterns = {}
else
	let g:neocomplete#keyword_patterns['default'] = '\h\w*'
endif

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType c setlocal omnifunc=ccomplete#Complete
autocmd FileType cs setlocal omnifunc=OmniSharp#Complete
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
"autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
autocmd FileType java setlocal omnifunc=javacomplete#Complete

" Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
	let g:neocomplete#sources#omni#input_patterns = {}
endif

let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

" For perlomni.vim setting.
" https://github.com/c9s/perlomni.vim
let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'
let g:neocomplete#sources#omni#input_patterns.cs = '.*[^=\);]'
