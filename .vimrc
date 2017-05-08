" David Kramer's .vimrc file
" Last Modified: 04/26/17

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
	Plugin 'hsanson/vim-android'
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


autocmd FileType cs setlocal omnifunc=OmniSharp#Complete
autocmd BufWritePost *.cs call OmniSharp#AddToProject()


autocmd FileType java setlocal omnifunc=javacomplete#Complete
nmap <F4> <Plug>(JavaComplete-Imports-AddSmart)
imap <F4> <Plug>(JavaComplete-Imports-AddSmart)

nmap <F5> <Plug>(JavaComplete-Imports-Add);
imap <F5> <Plug>(JavaComplete-Imports-Add);

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

" Use indents instead of 4 spaces
set shiftwidth=4

" Indentation every 4 columns
set tabstop=4

" Use tabs not spaces
set noexpandtab

" Encoding
set encoding=utf8

" Automatically update file if modified by external program
set autoread

" Rendering
set ttyfast

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


" Toggle spellchecking
map <leader>ss :setlocal spell!<CR>

" Easier access to Ex commands

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


" --- Omnisharp configuration ---

" OmniSharp won't work without this setting
filetype plugin on

"This is the default value, setting it isn't actually necessary
let g:OmniSharp_host = "http://localhost:2000"

"Set the type lookup function to use the preview window instead of the status line
"let g:OmniSharp_typeLookupInPreview = 1

"Timeout in seconds to wait for a response from the server
let g:OmniSharp_timeout = 1

"Showmatch significantly slows down omnicomplete
"when the first match contains parentheses.
set noshowmatch


"don't autoselect first item in omnicomplete, show if only one item (for preview)
"remove preview if you don't want to see any documentation whatsoever.
set completeopt=longest,menuone,preview
" Fetch full documentation during omnicomplete requests.
" There is a performance penalty with this (especially on Mono)
" By default, only Type/Method signatures are fetched. Full documentation can still be fetched when
" you need it with the :OmniSharpDocumentation command.
" let g:omnicomplete_fetch_documentation=1

"Move the preview window (code documentation) to the bottom of the screen, so it doesn't move the code!
"You might also want to look at the echodoc plugin
set nosplitbelow

" Get Code Issues and syntax errors
let g:syntastic_cs_checkers = ['syntax', 'semantic', 'issues']
" If you are using the omnisharp-roslyn backend, use the following
" let g:syntastic_cs_checkers = ['code_checker']
augroup omnisharp_commands
	autocmd!

	"Set autocomplete function to OmniSharp (if not using YouCompleteMe completion plugin)
	autocmd FileType cs setlocal omnifunc=OmniSharp#Complete

	" Synchronous build (blocks Vim)
	"autocmd FileType cs nnoremap <F5> :wa!<cr>:OmniSharpBuild<cr>
	" Builds can also run asynchronously with vim-dispatch installed
	autocmd FileType cs nnoremap <leader>b :wa!<cr>:OmniSharpBuildAsync<cr>
	" automatic syntax check on events (TextChanged requires Vim 7.4)
	autocmd BufEnter,TextChanged,InsertLeave *.cs SyntasticCheck

	" Automatically add new cs files to the nearest project on save
	autocmd BufWritePost *.cs call OmniSharp#AddToProject()

	"show type information automatically when the cursor stops moving
	autocmd CursorHold *.cs call OmniSharp#TypeLookupWithoutDocumentation()

	"The following commands are contextual, based on the current cursor position.

	autocmd FileType cs nnoremap gd :OmniSharpGotoDefinition<cr>
	autocmd FileType cs nnoremap <leader>fi :OmniSharpFindImplementations<cr>
	autocmd FileType cs nnoremap <leader>ft :OmniSharpFindType<cr>
	autocmd FileType cs nnoremap <leader>fs :OmniSharpFindSymbol<cr>
	autocmd FileType cs nnoremap <leader>fu :OmniSharpFindUsages<cr>
	"finds members in the current buffer
	autocmd FileType cs nnoremap <leader>fm :OmniSharpFindMembers<cr>
	" cursor can be anywhere on the line containing an issue
	autocmd FileType cs nnoremap <leader>x  :OmniSharpFixIssue<cr>
	autocmd FileType cs nnoremap <leader>fx :OmniSharpFixUsings<cr>
	autocmd FileType cs nnoremap <leader>tt :OmniSharpTypeLookup<cr>
	autocmd FileType cs nnoremap <leader>dc :OmniSharpDocumentation<cr>
	"navigate up by method/property/field
	" autocmd FileType cs nnoremap <C-K> :OmniSharpNavigateUp<cr>
	"navigate down by method/property/field
	" autocmd FileType cs nnoremap <C-J> :OmniSharpNavigateDown<cr>

augroup END


" this setting controls how long to wait (in ms) before fetching type / symbol information.
set updatetime=500
" Remove 'Press Enter to continue' message when type information is longer than one line.
set cmdheight=2

" Contextual code actions (requires CtrlP or unite.vim)
nnoremap <leader><space> :OmniSharpGetCodeActions<cr>
" Run code actions with text selected in visual mode to extract method
vnoremap <leader><space> :call OmniSharp#GetCodeActions('visual')<cr>

" rename with dialog
nnoremap <leader>nm :OmniSharpRename<cr>
nnoremap <F2> :OmniSharpRename<cr>
" rename without dialog - with cursor on the symbol to rename... ':Rename newname'
command! -nargs=1 Rename :call OmniSharp#RenameTo("<args>")

" Force OmniSharp to reload the solution. Useful when switching branches etc.
nnoremap <leader>rl :OmniSharpReloadSolution<cr>
nnoremap <leader>cf :OmniSharpCodeFormat<cr>
" Load the current .cs file to the nearest project
nnoremap <leader>tp :OmniSharpAddToProject<cr>

" (Experimental - uses vim-dispatch or vimproc plugin) - Start the omnisharp server for the current solution
nnoremap <leader>ss :OmniSharpStartServer<cr>
nnoremap <leader>sp :OmniSharpStopServer<cr>

" Add syntax highlighting for types and interfaces
nnoremap <leader>th :OmniSharpHighlightTypes<cr>
"Don't ask to save when changing buffers (i.e. when jumping to a type definition)
set hidden

" Enable snippet completion, requires completeopt-=preview
let g:OmniSharp_want_snippet=1

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

"Function to paste inside of characters, instead of appending
"to a new line
function! SmartPaste()
	"The char at the current cursor position
	let currentChar = CharAtCursor()

	let closePairs = [')', ']']
	let openPairs  = ['(', '[']

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

nmap <F10> :call SmartPaste() <CR>
