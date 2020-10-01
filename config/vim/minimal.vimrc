"-------------------------------------------------------
" minimal.vimrc
" Contains minor tweaks with performance a priority
"-------------------------------------------------------

set nocompatible

let mapleader = "\<Space>"
let maplocalleader = ","

" Fast escape
inoremap kj <esc> 

" Easier command mode
map <leader> :

" Make backspace do backspace things
set backspace=indent,eol,start

" Allow cursor to move just past end of line
set virtualedit=onemore

" Default tab width is HUGE
set shiftwidth=4
set tabstop=4

" Expand tabs to spaces
set expandtab

" Indent at same position as previous line
set autoindent

" Show matching brackets/parenthesis
set showmatch

" Recognize existing indentation
set smarttab

" Because hacking
hi Normal ctermfg=green

" Sometimes
set mouse=a
set mousehide

" Split to right
set splitright

" Move between windows more easily
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Move between windows more easily in insert
imap <C-j> <esc><C-W>j
imap <C-k> <esc><C-W>k
imap <C-h> <esc><C-W>h
imap <C-l> <esc><C-W>l

" Open new tab
nnoremap tt :tabnew<CR>

" Quit faster
nnoremap <leader>q :quit<CR>


" Make JSON beautiful
command! FormatJSON %!python -m json.tool
