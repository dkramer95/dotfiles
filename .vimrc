" David Kramer's .vimrc file
" Last Modified: 05/10/17 

set nocompatible		" be iMproved, required
filetype off			" required

set rtp+=~/.vim/bundle/Vundle.vim


" Plugins (managed via Vundle)
call vundle#begin()

Plugin 'VundleVim/Vundle.vim' 		" Let Vundle manage Vundle
Plugin 'tpope/vim-surround' 		" Surround text
Plugin 'majutsushi/tagbar' 			" Class/Function Outline Viewer
Plugin 'airblade/vim-gitgutter' 	" Show git status in the gutter
Plugin 'tpope/vim-fugitive'
Plugin 'scrooloose/syntastic' 		" Syntax checking
Plugin 'scrooloose/nerdtree' 		" File Explorer
Plugin 'gioele/vim-autoswap' 		" Fix swap file prompts
Plugin 'alvan/vim-closetag' 		" Autoclose pairs
Plugin 'jiangmiao/auto-pairs' 		" Autocomplete matching pairs
Plugin 'tomtom/tcomment_vim' 		" Commenting
Plugin 'Flazz/vim-colorschemes' 	" Bunch of cool colorschemes
Plugin 'ctrlpvim/ctrlp.vim' 		" Fast Fuzzy File finder

Plugin 'moll/vim-node' 				" NodeJS
Plugin 'tpope/vim-dispatch'

Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
Plugin 'tmhedberg/matchit' 			" Enhanced matching of tags

Plugin 'jondkinney/dragvisuals.vim' " Awesome visual drag plugin
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'

Plugin 'christoomey/vim-tmux-navigator'

let g:slowPluginsEnabled=0

"These plugins are a bit hefty and sometimes we don't always
"want to load them
if (g:slowPluginsEnabled)
	Plugin '1995eaton/vim-better-javascript-completion'
	Plugin 'OmniSharp/omnisharp-vim' 	" C#
	Plugin 'Valloric/YouCompleteMe' 	" Code Completion
	Plugin 'artur-shaik/vim-javacomplete2' "Java completion
	" Plugin 'hsanson/vim-android' -- This is REALLY slow!!!
endif


call vundle#end()
filetype plugin indent on

" Ultisnips config
let g:UltiSnipsExpandTrigger="<C-Space>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"

let g:airline_theme="base16color"

" Syntastic config
set statusline=%<%f\ %h%m%r%=%-14.(%l,%c%V%)\ %P
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" Make JSON beautiful
command! FormatJSON %!python -m json.tool


autocmd FileType java setlocal omnifunc=javacomplete#Complete
nmap <F4> <Plug>(JavaComplete-Imports-AddSmart)
imap <F4> <Plug>(JavaComplete-Imports-AddSmart)

nmap <F5> <Plug>(JavaComplete-Imports-Add)
imap <F5> <Plug>(JavaComplete-Imports-Add)

"For swap plugin... Move to the open tmux session
let g:autoswap_detect_tmux = 1


set rtp+=~/.vim/bundle/plugin

" Editor tweaks

" Make backspace work normally
set backspace=indent,eol,start

" Show line numbers
set number

" Show relative line numbers
set rnu

" Smart auto-indenting inside numbered lists
set formatoptions+=n

" Remove comment leader when joining comments
set formatoptions+=j

" Syntax highlighting
syntax on

" Hide mouse cursor while typing
set mousehide

" Display current mode
set showmode

" Highlight current line
set cursorline

" Make searching better
set gdefault
set ignorecase
set smartcase

" Find as you search
set incsearch

" Highlight search matches
set hlsearch

" Show the ruler
set ruler

" Show partial commands in status line
set showcmd

" Show the status bar
set laststatus=2

" Lines to scroll when cursor leaves screen
set scrolljump=5

" Minimum lines to keep above and below cursor
set scrolloff=5

" Show matching brackets/parenthesis
set showmatch

" Indent at same position as the previous line
set autoindent

" Show hidden whitespace chars
set listchars=tab:>-,eol:¬,trail:␠
set list

" Use indents instead of 4 spaces
set shiftwidth=4

" Indentation every 4 columns
set tabstop=4

" Use tabs NOT spaces
set noexpandtab

" Encoding
set encoding=utf8

" Stronger encryption
setlocal cm=blowfish2

" Automatically update file if modified by external program
set autoread

" Rendering
set ttyfast

" Don't redraw during macro playback
set lazyredraw

" Visual autocomplete for command menu
set wildmenu

" Text colorscheme
colorscheme brogrammer

" For those emergencies...
set mouse=a


" Custom Keymappings

let mapleader = "\<Space>"

" Easier escape
inoremap kj <Esc>
cnoremap kj <Esc>

" Yank to end of line
nnoremap Y y$

" Create and move between tabs more easily
nnoremap tt <Esc>:tabnew<CR>
nnoremap tm <Esc>:tabmove<CR>
nnoremap t$ <Esc>:tablast<CR>
nnoremap t0 <Esc>:tabfirst<CR>

" Disable search match highlights
map nh <Esc>:nohl<CR>

" Move between windows more easily
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Easier access to command mode
map <leader> :

"<Leader><Leader> -- Open last buffer
nnoremap <leader><leader> <C-^>

" Toggle spellchecking
nnoremap <leader>ss :setlocal spell!<CR>

nnoremap <leader>q :quit<CR>
nnoremap <leader>qq :quit!<CR>
nnoremap <leader>qa :qa<CR>

" Show the path of the current file
nnoremap <leader>p :echo expand('%')<CR>

nnoremap <leader>l :set list!<CR>

" Hotkey to insert current date into the buffer
nnoremap <F5> "=strftime("%m/%d/%y")<CR>P"
" inoremap <F5> "=strftime("%m/%d/%y")<CR>" // this is broken

" Hotkey to fix indentation
nnoremap <F7> gg=G

" Hotkey to toggle tagbar (requires tagbar plugin)
nmap <F8> :TagbarToggle<CR>
imap <F8> :TagbarToggle<CR>

" Hotkey to directly editor .vimrc in a new tab
inoremap <F12> <Esc>:tabnew $MYVIMRC<CR>
nnoremap <F12> <Esc>:tabnew $MYVIMRC<CR>

" Quickly source .vimrc
nnoremap <leader>rv :source $MYVIMRC<CR>

vmap <expr> H DVB_Drag('left')
vmap <expr> L DVB_Drag('right')
vmap <expr> J DVB_Drag('down')
vmap <expr> K DVB_Drag('up')
vmap <expr> D DVB_Duplicate()

set clipboard^=unnamedplus


" this setting controls how long to wait (in ms) before fetching type / symbol information.
set updatetime=500
" Remove 'Press Enter to continue' message when type information is longer than one line.
set cmdheight=2

" Always use visual block mode
nnoremap v <C-V>
nnoremap <C-V> v

vnoremap v <C-V>
vnoremap <C-V> v

" Contextual code actions (requires CtrlP or unite.vim)
"Don't ask to save when changing buffers (i.e. when jumping to a type definition)
set hidden

" Android support
let g:gradle_path="/home/dkramer/Documents/MobileAppWorkspace/DataStorage/gradlew"
" let g:gradle_path = "~/Documents/MobileAppWorkspace/DataStorage/gradlew"
let g:android_sdk_path = "~/Android/Sdk"


" Source the current file
nnoremap <leader>5 <Esc>:call SourceFile()<CR>

function! SourceFile()
	:w!
	:source %
endfunction

"Double-delete to remove trailing whitespace...
nmap <silent> <BS><BS> :call TrimTrailingWS()<CR>

function! TrimTrailingWS()
	if search('\s\+$', 'cnw')
		:%s/\s\+$//g
	endif
	echo "Trim trailing backspace"
endfunction

function! CharAtCursor()
	let char = matchstr(getline('.'), '\%' . col('.') .'c.')
	" echo char
	return char
endfunction






"////////////////////////////////////////////////////////////////////////////////
"////////////////////////////////////////////////////////////////////////////////
"////////////////////////////////////////////////////////////////////////////////
"
"                    E X P E R I M E N T A L  Z O N E
"
"\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
"\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
"\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

"Function to paste inside of characters, instead of appending
"to a new line
function! SmartPaste()
	"The char at the current cursor position
	let currentChar = CharAtCursor()

	let closePairs = [')', ']', '}']
	let openPairs  = ['(', '[', '{']

	if (index(closePairs, currentChar) >= 0)
		" Go to matching open pair
		normal %
	endif

	if (index(openPairs, currentChar) >= 0)
		" We are already at the start
		" Go inside and paste
		normal %"kDpkJx$"kp
	else
		" Just paste normally
		normal p
	endif
endfunction

function! YankChar()
	let yankedChar = CharAtCursor()
	let @c = yankedChar
	" Delete what was there
	normal x$"cp
endfunction

nmap <F10> :call SmartPaste() <CR>


function! GoToTab(index)
	tabfirst
	execute "normal" . a:index . "gt"
endfunction

nnoremap g1 <Esc>: call GoToTab(1)<CR>
nnoremap g2 <Esc>: call GoToTab(2)<CR>
nnoremap g3 <Esc>: call GoToTab(3)<CR>
nnoremap g4 <Esc>: call GoToTab(4)<CR>
nnoremap g5 <Esc>: call GoToTab(5)<CR>
nnoremap g6 <Esc>: call GoToTab(6)<CR>
nnoremap g7 <Esc>: call GoToTab(7)<CR>
nnoremap g8 <Esc>: call GoToTab(8)<CR>
nnoremap g9 <Esc>: call GoToTab(9)<CR>

function! TitleCaseLine()
	normal 0
	while (col(".") >= col("$") - 1)
		normal vUw
	endwhile
	echo "TitleCasedLine!"
endfunction

nmap tc <Esc>:call TitleCaseLine()<CR>
