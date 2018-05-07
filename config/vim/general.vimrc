"------------------------------------------------------------------------------
" general.vimrc
" Contains general editor tweaks
"------------------------------------------------------------------------------


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

" Improve syntax redrawing
syntax sync maxlines=350

" Hide mouse cursor while typing
set mousehide

" Display current mode
set showmode

" Highlight current line
set cursorline

" Show a column line to help guide codewrapping
let g:colorcolumnWidth=110
let &colorcolumn=g:colorcolumnWidth
highlight ColorColumn ctermbg=darkgray

" Make searching better
set gdefault
set ignorecase
set smartcase

" Split vertical windows to the right
set splitright

" Find as you search
set incsearch

" Highlight search matches
set hlsearch

" Show the ruler
set ruler

" Show partial commands in status line
set showcmd

" Limit size of popup menu
set pumheight=20

" Show the status bar
set laststatus=2

" Lines to scroll when cursor leaves screen
set scrolljump=5

" Increase memory limit of registers
set viminfo='20,<1000

" Minimum lines to keep above and below cursor
set scrolloff=5

" Allow cursor to move just past end of line
set virtualedit=onemore

" Show matching brackets/parenthesis
set showmatch

" Better diff mode options
set diffopt=filler,context:12,vertical

" Indent at same position as the previous line
set autoindent

" Encoding
set encoding=utf8

" Show hidden whitespace chars
set listchars=tab:>-,eol:¬,trail:␠
set list

" Indentation every 4 columns
set tabstop=4

" Use indents instead of 4 spaces
set shiftwidth=4

" Expand tabs to spaces
set expandtab

" Recognize existing indentation
set smarttab

" Stronger encryption
set cm=blowfish2

" Automatically update file if modified by external program
set autoread

" Rendering
set ttyfast

" Don't redraw during macro playback
set lazyredraw

" Decrease command interp wait time (default 1000ms)
set timeoutlen=350

" Visual autocomplete for command menu
set wildmenu

" Text colorscheme
silent! colorscheme brogrammer

" For those emergencies...
set mouse=a

"Don't ask to save when changing buffers (i.e. when jumping to a type definition)
set hidden

" Remove 'Press Enter to continue' message when type information is longer than one line.
set cmdheight=2


" Access system clipboarod
if (has("win32") || has("win32unix") || (has("unix") && (system("uname -s") =~ "Darwin")))
	" Windows or MacOS
	set clipboard=unnamed
else
	" Linux
	set clipboard=unnamedplus
endif

" GUI specific tweaks
if (has("gui_running"))
	" Hide GUI tab bar
	set guioptions -=e

	" Hide GUI Toolbar
	set guioptions -=T

	" Remove GUI right-hand scrollbar
	set guioptions -=r

	" Remove GUI left-hand scrollbar
	set guioptions -=l

	" Remove Nerdtree scrollbar
	set guioptions -=L

	" Disable cursor blinking
	set guicursor+=a:blinkon0

	" Gui font
	set guifont=DejaVu_Sans_Mono_for_Powerline,Courier_New
endif

" Reduce visibility of inactive window
func! OnBufLeave()
	" Preserve highlighting when in diff mode
	if (&diff == 1)
		return
	endif

	execute "setlocal syntax=0 | setlocal nonu | setlocal nornu"
	set nocursorline
	if exists("&colorcolumn")
		let width = winwidth(winnr())
		let cols = ""
		for j in range(1, width)
			let cols = cols .j . ","
		endfor
		" remove trailing comma
		let cols = strpart(cols, 0, strlen(cols) - 1)
		let &colorcolumn="" . cols
	endif
	redraw
endfunc

" Increase visibility of active window
func! OnBufEnter()
	if !exists("b:syntax")
		let b:syntax = &syntax
	else
		let b:syntax = &filetype
	endif
	if exists("&colorcolumn")
		let &colorcolumn=g:colorcolumnWidth
	endif
	execute "setlocal syntax=" . b:syntax . " | setlocal rnu"
	set cursorline
endfunc

augroup KWinCmds
	autocmd!
	autocmd WinLeave * call OnBufLeave()
	autocmd BufEnter,WinEnter * call OnBufEnter()
augroup END

" Allow per project vimrc configs
set exrc

" Disable unsafe commands
set secure

" Command Abbreviations
cabbrev ca call
cabbrev so source
cabbrev ec echo
cabbrev dc debug call

" Mapping abbreviations
cabbrev nno nnoremap
cabbrev ino inoremap
cabbrev cno cnoremap
cabbrev vno vnoremap

" Diff abbreviations
cabbrev ds diffsplit
cabbrev vd vertical diffsplit
cabbrev nod diffoff
