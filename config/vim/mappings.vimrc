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

" Yank to end of line
nnoremap Y y$

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
nnoremap fw gqgq

" Quickly source .vimrc
nnoremap <leader>rv :source $MYVIMRC<CR>

" Yank the current char at the cursor to clipboard
if (&clipboard == "unnamedplus")
	nnoremap <silent>yc :let @+ = CharAtCursor()<CR>
elseif (&clipboard == "unnamed")
	nnoremap <silent>yc :let @* = CharAtCursor()<CR>
endif


" Always use visual block mode
nnoremap v <C-V>
nnoremap <C-V> v

vnoremap v <C-V>
vnoremap <C-V> v

" Faster incremental scrolling
nnoremap <C-e> 5<C-e>
nnoremap <C-y> 5<C-y>

" Smarter and easier horizontal and vertical window resizing
autocmd! WinEnter * call SetWinAdjust()
function! SetWinAdjust()
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
endfunction


" --Mappings that use third party plugins--

" Ensure we only map to plugins if they have been sourced, to avoid
" getting annoying errors about mapping to things that don't exist
autocmd! VimEnter * call LoadPluginMappings()

function! LoadPluginMappings()
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
	endif

	" NeoComplete
	if exists ('g:loaded_neocomplete')
		inoremap <expr><C-g>	neocomplete#undo_completion()
		inoremap <expr><C-l>	neocomplete#complete_common_string()

		" <CR>: close popup and save indent.
		inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
		function! s:my_cr_function()
			return (pumvisible() ? "\<C-y>" : "" ) . "\<CR>"
		endfunction
		" <TAB>: completion.
		inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
		" <C-h>, <BS>: close popup and delete backword char.
		inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
		inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"

		" Snippet config
		" Plugin key-mappings.
		" Note: It must be "imap" and "smap".  It uses <Plug> mappings.
		imap <C-k> <Plug>(neosnippet_expand_or_jump)
		smap <C-k> <Plug>(neosnippet_expand_or_jump)
		xmap <C-k> <Plug>(neosnippet_expand_target)
	endif

	" NERDTree
	if exists(':NERDTreeToggle')
		nmap <F7> :NERDTreeToggle<CR>
	endif
endfunction

" Use xterm style keys.. This is needed for using <S-CursorKey> mappings
" inside of tmux to work properly
if &term =~ '^screen'
	" tmux will send xterm-style keys when its xterm-keys option is on
	execute "set <xUp>=\e[1;*A"
	execute "set <xDown>=\e[1;*B"
	execute "set <xRight>=\e[1;*C"
	execute "set <xLeft>=\e[1;*D"
endif
