  "------------------------------------------------------------------------------
" style.vimrc
" Contains custom user style preferences for vim
"------------------------------------------------------------------------------

" Airline Config
let g:airline_theme="wombat"

  " Adds ascii code values to the right of airline status bar in hex and decimalj
let g:airline_section_z = '%3p%% %#__accent_bold#%{g:airline_symbols.linenr}%4l%#__restore__#%#__accent_bold#/%L%{g:airline_symbols.maxlinenr}%#__restore__# :%3v | %03b 0x%02B'


" Colorscheme
set background=dark
silent! colorscheme PaperColor

" Black BG for Amoled display
highlight Normal ctermbg=0
highlight EndOfBuffer ctermbg=0
highlight SignColumn ctermbg=0
highlight LineNr ctermbg=0
highlight NonText ctermbg=0

" Show underline rather than highlight for current line
highlight clear CursorLine
highlight CursorLine cterm=underline

" Additional Color Tweaks
highlight TabLineFill ctermbg=238

" Diff highlighting
highlight DiffAdd term=bold ctermfg=16 ctermbg=70
highlight DiffChange term=bold ctermfg=16 ctermbg=70
highlight DiffDelete term=bold ctermfg=251 ctermbg=160
highlight DiffText term=reverse ctermfg=16 ctermbg=221
