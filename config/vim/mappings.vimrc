"------------------------------------------------------------------------------
" mappings.vimrc
" Contains custom keymappings for internal vim functions as well as
" third-party plugins
"------------------------------------------------------------------------------

let mapleader = "\<Space>"
let maplocalleader = ","

" Easier escape
inoremap kj <Esc>
cnoremap kj <Esc>

" Stop using cursor keys in cmd mode
cnoremap kk <up>
cnoremap jj <down>

" Yank to end of line -- can use custom register
nnoremap Y :call RegCmd("", "y$")<CR>

" Create and move between tabs more easily
nnoremap tt <Esc>:tabnew<CR>

" Move tab forward
nnoremap tm <Esc>:tabmove +<CR>

" Move tab backward
nnoremap tM <Esc>:tabmove - <CR>

" Go to the first tab
nmap t0 <Esc>:tabfirst<CR>
nmap g0 t0

" Go the the last tab
nmap t$ <Esc>:tablast<CR>
nmap g$ t$

" Move current window to tab
nnoremap mt <C-w>T

" Access tabs w/ g {1-9}
for j in range(1, 9)
	execute "nnoremap <silent>g" . j ":tabfirst<CR>" . j . "gt"
endfor

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

" Faster exiting
nnoremap <leader>q :quit<CR>
nnoremap <leader>qq :quit!<CR>
nnoremap <leader>qa :qa<CR>
nnoremap <leader>qaa :qa!<CR>

set shortmess=a
nnoremap <Tab> :bprevious<CR>:redraw<CR>:ls<CR>
nnoremap <S-Tab> :bnext<CR>:redraw<CR>:ls<CR>

" Show the path of the current file
nnoremap <leader>p :echo expand('%')<CR>

" Show only the current window
nnoremap <leader>o :only<CR>

" Toggle between showing whitespace chars
nnoremap <LocalLeader>l :set list!<CR>

" Hotkey to insert current date into the buffer
nnoremap <F5> "=strftime("%m/%d/%y")<CR>P"
inoremap <F5> <Esc>:let @t=strftime('%m/%d/%y')<CR>a<C-r>t

" Hotkey to fix indentation
nnoremap <F7> gg=G

" Hotkey to directly editor .vimrc in a new tab
inoremap <F12> <Esc>:tabnew $MYVIMRC<CR>
nnoremap <F12> <Esc>:tabnew $MYVIMRC<CR>

" Additional fast toggle to edit .vimrc in current window
nnoremap <LocalLeader>, <Esc>:e $MYVIMRC<CR>

" Toggle between relative / normal line numbers
nnoremap <LocalLeader>r <Esc>:set rnu!<CR>

" Edit file, starting in the same directory as current file
nnoremap <LocalLeader>e :edit <C-R>=expand('%:p:h') . '/'<CR>

" Fit to specified text width pneumonic -- fit width
nnoremap ftw GVgggq

" Quickly source .vimrc
nnoremap <leader>rv :source $MYVIMRC<CR>

" Source current file without having to press '%'
nnoremap <leader>5 :source %<CR>

" Swap mark and register bindings
nnoremap ' "
nnoremap " '

" Stop the annoying accidental macro recording when quitting
nnoremap Q q
nnoremap q <nop>


" Yank current char under cursor to the clipboard or custom register
func! YankChar()
	let cmd = ":let @" . v:register . " = CharAtCursor()"
	echo cmd
	execute(cmd)
endfunc

" Enables custom keymappings that involve {lhs} and {rhs} to use a custom
" register. If specified, the custom register will be used, otherwise the
" default register will be used like normal.
func! RegCmd(lhs, rhs)
	let reg = ""
	if (v:register != "\"")
		" Not using default register
		let reg = "\"" . v:register
	endif
	call feedkeys(a:lhs . reg . a:rhs, 'n')
	return reg
endfunc

" Function to yank everything to clipboard or custom register
func! YankAll()
	" Set a mark so we can return to where we were
	let mark = "z"
	let lhs = "m" . mark . "G"
	let rhs = "yy'" . mark
	let reg = RegCmd(lhs, rhs)

	echo "Buffer contents yanked to \"" . reg
endfunc

" Yank single char to clipboard -- can use custom register
nnoremap <silent>yc :call YankChar()<CR>

" Yank all contents to clipboard -- can use custom register
nnoremap ya :call YankAll()<CR>

" Always use visual block mode
nnoremap v <C-V>
nnoremap <C-V> v

vnoremap v <C-V>
vnoremap <C-V> v

" Faster incremental scrolling
nnoremap <C-e> 5<C-e>
nnoremap <C-y> 5<C-y>

tnoremap <C-W>n <C-W>N

" Better terminal mode mappings
if has('terminal')
	func! TerminalInsert()
		" Ensure this is only for a terminal type buffer
		if (&buftype == "terminal")
			normal i
		endif
	endfunc

	" Creates a terminal split to the right
	func! CreateSplitTerminal()
		:term

		" Hacky work around to fix <CR> key not working when creating
		" a terminal and moving it w/ feedkeys instead of actually typing
		call feedkeys("\<C-w>L\<CR>")
		call term_wait(bufnr("%"), 1)
		" Min sleep time that makes this hack work
		sleep 400m
		" Don't run tmux within vim
		call feedkeys("exit\<CR>")
	endfunc

	" Easier escape to terminal normal mode
	tnoremap <C-w>kj <C-W>N

	" Easier way to go back into terminal insert mode
	nnoremap <silent> <CR> :call TerminalInsert()<CR>
	nnoremap <LocalLeader>t :call CreateSplitTerminal()<CR>
endif

" Make a buffer modifiable
nnoremap <LocalLeader>m :set modifiable<CR>

" Delete all text in buffer -- can use custom register
nnoremap <silent> da :call RegCmd("G", "dgg")<CR>

" Visually select all text in buffer
nnoremap va GVgg

" Smarter and easier horizontal and vertical window resizing
autocmd! WinEnter * call SetWinAdjust()
func! SetWinAdjust()
	if winnr() == winnr('$')
		" --Left Window--

		" Horizontal Remaps
		nnoremap <C-W>> <C-W><
		nnoremap <C-W>< <C-W>>

		" Horizontal Toggle Mappings
		nnoremap <S-Left> 5<C-W>>
		nnoremap <S-Right> 5<C-W><

		" Vertical Remaps
		nnoremap <C-W>- <C-W>+
		nnoremap <C-W>+ <C-W>-

		" Vertical Toggle Mappings
		nnoremap <S-Up> 5<C-W>+
		nnoremap <S-Down> 5<C-W>-
	else
		" --Right Window--

		" Horizontal Remaps
		nnoremap <C-W>> <C-W>>
		nnoremap <C-W>< <C-W><

		" Horizontal Toggle Mappings
		nnoremap <S-Left> 5<C-W><
		nnoremap <S-Right> 5<C-W>>

		" Vertical Remaps
		nnoremap <C-W>- <C-W>-
		nnoremap <C-W>+ <C-W>+

		"Vertical Toggle Mappings
		nnoremap <S-Up> 5<C-W>-
		nnoremap <S-Down> 5<C-W>+
	endif
endfunc


" --Mappings that use third party plugins--

" Ensure we only map to plugins if they have been sourced, to avoid
" getting annoying errors about mapping to things that don't exist
autocmd! VimEnter * call LoadPluginMappings()

func! LoadPluginMappings()
	" DVB_Drag
	if exists('g:loaded_dragvirtualblocks')
		vmap <expr> H DVB_Drag('left')
		vmap <expr> L DVB_Drag('right')
		vmap <expr> J DVB_Drag('down')
		vmap <expr> K DVB_Drag('up')
		vmap <expr> D DVB_Duplicate()
	endif

	" CommandT
	if exists('g:command_t_loaded')
		nnoremap <C-p> :CommandT<CR>
	endif

	" Tagbar
	if exists('g:loaded_tagbar') || exists(':TagbarToggle')
		nmap <F8> :TagbarToggle<CR>
		imap <F8> :TagbarToggle<CR>
	endif

	" TComment
	if exists('g:loaded_tcomment')
		nnoremap # :TComment<CR>
		" Use # to toggle comments in visual selection
		xmap # gc
	endif

	if exists('g:JavaComplete_PluginLoaded')
		nnoremap <C-O> :JCimportAddSmart<CR>
	endif

	" NERDTree
	if exists(':NERDTreeToggle')
		nmap <F7> :NERDTreeToggle<CR>
	endif
endfunc

" Use xterm style keys.. This is needed for using <S-CursorKey> mappings
" inside of tmux to work properly
if &term =~ '^screen'
	" tmux will send xterm-style keys when its xterm-keys option is on
	execute "set <xUp>=\e[1;*A"
	execute "set <xDown>=\e[1;*B"
	execute "set <xRight>=\e[1;*C"
	execute "set <xLeft>=\e[1;*D"
endif
