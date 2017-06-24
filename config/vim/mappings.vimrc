"------------------------------------------------------------------------------
" mappings.vimrc
" Contains custom keymappings for internal vim functions as well as
" third-party plugins
"------------------------------------------------------------------------------

let mapleader = "\<Space>"

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
nnoremap t0 <Esc>:tabfirst<CR>

" Go the the last tab
nnoremap t$ <Esc>:tablast<CR>

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

set shortmess=a
nnoremap <Tab> :bprevious<CR>:redraw<CR>:ls<CR>
nnoremap <S-Tab> :bnext<CR>:redraw<CR>:ls<CR>

" Show the path of the current file
nnoremap <leader>p :echo expand('%')<CR>

" Toggle between showing whitespace chars
nnoremap <leader>l :set list!<CR>

" Hotkey to insert current date into the buffer
nnoremap <F5> "=strftime("%m/%d/%y")<CR>P"
inoremap <F5> <Esc>:let @t=strftime('%m/%d/%y')<CR>a<C-r>t

" Hotkey to fix indentation
nnoremap <F7> gg=G

" Hotkey to directly editor .vimrc in a new tab
inoremap <F12> <Esc>:tabnew $MYVIMRC<CR>
nnoremap <F12> <Esc>:tabnew $MYVIMRC<CR>

" Quickly source .vimrc
nnoremap <leader>rv :source $MYVIMRC<CR>

" Yank the current char at the cursor to clipboard
nnoremap yc :let @* = CharAtCursor()<CR>

" Always use visual block mode
nnoremap v <C-V>
nnoremap <C-V> v

vnoremap v <C-V>
vnoremap <C-V> v

" Mappings that use third party plugins

if exists(':CommandT')
	nnoremap <C-p> :CommandT<CR>
endif

if exists('*DVB_Drag')
	vmap <expr> H DVB_Drag('left')
	vmap <expr> L DVB_Drag('right')
	vmap <expr> J DVB_Drag('down')
	vmap <expr> K DVB_Drag('up')
	vmap <expr> D DVB_Duplicate()
endif

if exists(':TagbarToggle')
	nmap <F8> :TagbarToggle<CR>
	imap <F8> :TagbarToggle<CR>
endif

if exists (':NeoComplete')
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

if exists(':NERDTreeToggle')
	" NERDTree config
	nmap <F7> :NERDTreeToggle<CR>
endif
