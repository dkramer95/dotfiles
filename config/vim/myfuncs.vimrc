func! SourceFile()
	:w!
	:source %
endfunc

"Double-delete to remove trailing whitespace...
nmap <silent> <BS><BS> :call TrimTrailingWS()<CR>

" Clears out all values in user accessible registers
func! ClearRegisters()
	let regs = split('abcdefghijklmnopqrstuvwxyz0123456789', '\zs')

	for r in regs
		call setreg(r, [])
	endfor
endfunc

" Make a system command to clear registers
command! ClearReg :call ClearRegisters()

func! TrimTrailingWS()
	if search('\s\+$', 'cnw')
		:%s/\s\+$//g
	endif
	echo "Trim trailing backspace"
endfunc

func! CharAtCursor()
	let char = matchstr(getline('.'), '\%' . col('.') .'c.')
	" echo char
	return char
endfunc

func! GoToTab(index)
	tabfirst
	execute "normal" . a:index . "gt"
endfunc

nnoremap g1 <Esc>: call GoToTab(1)<CR>
nnoremap g2 <Esc>: call GoToTab(2)<CR>
nnoremap g3 <Esc>: call GoToTab(3)<CR>
nnoremap g4 <Esc>: call GoToTab(4)<CR>
nnoremap g5 <Esc>: call GoToTab(5)<CR>
nnoremap g6 <Esc>: call GoToTab(6)<CR>
nnoremap g7 <Esc>: call GoToTab(7)<CR>
nnoremap g8 <Esc>: call GoToTab(8)<CR>
nnoremap g9 <Esc>: call GoToTab(9)<CR>

func! TitleCaseLine()
	normal 0
	while (col(".") >= col("$") - 1)
		normal vUw
	endwhile
	echo "TitleCasedLine!"
endfunc

nmap tc <Esc>:call TitleCaseLine()<CR>


" Just for FUN function that will take whatever text is in the
" current buffer, and create a new separate bufferand animate
" all the text out, with the specified draw speed variable
func! AnimateText(speed)
	"Yank text in current buffer into register @c
	normal GVgg"cyy

	"Create new buffer to contain yanked text from register @c
	let tempBufName = "animation"
	execute ":new " . tempBufName
	execute ":b " 	. tempBufName
	execute ":setlocal noswapfile"
	execute ":setlocal buftype=nowrite"

	"Convert text to uppercase
	if (s:inC64Mode == 1)
		let yankedText = toupper(@c)
	else
		let yankedText = @c
	endif
	let textLength = strlen(yankedText)

	let j = 0
	redraw

	"Draw each char, one at a time
	while (j < textLength)
		let char = strpart(yankedText, j, 1)
		let lineNum = getcurpos()[1]
		execute "sleep" . a:speed . "m"

		"Check to see if char is new line
		if (char == '$')
			let lineNum += 1
			normal o
		else
			let @d = char
			normal yy"dp
		endif

		redraw
		let j += 1
	endwhile

	"Show for a while
	sleep 5000m

	"Clean up contents
	execute ":bdelete! " . tempBufName
endfunc

func! SetGUIFont(name, size)
	exec "set gfn=" . a:name . ":h" . a:size
endfunc

" Go in and out Commodore 64 Mode! :)
let s:inC64Mode = 0

func! C64Mode()
	if !exists("b:original_colorscheme")
		let b:original_colorscheme = execute('colorscheme')
	endif

	"Exit out of C64 Mode
	if (s:inC64Mode == 1)
		let s:inC64Mode = 0
		" Go back to normal and tell vim to shut up
		silent! :source $MYVIMRC
	"Go into C64 Mode
	else
		colorscheme C64

		" GUI has more authentic C64 mode since we can change font
		if has("gui_running")
			" Does require C64_Pro_Mono font to be installed though!
			call SetGUIFont("C64_Pro_Mono", 15)
		endif
		let s:inC64Mode = 1
		set showmode
		set nornu
		set colorcolumn=80
	endif
	AirlineToggle
	redraw
endfunc

nnoremap <F6> :call C64Mode()<CR>
