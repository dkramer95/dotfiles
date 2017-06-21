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
