
" Function to create splash screen:
fun! Start()
	" Don't run if: we have commandline arguments, we don't have an empty
	" buffer, if we've not invoked as vim or gvim, or if we'e start in insert mode
	if argc() || line2byte('$') != -1 || v:progname !~? '^[-gmnq]\=vim\=x\=\%[\.exe]$' || &insertmode
		return
	endif

	" Start a new buffer ...
	enew " Now we can just write to the buffer, whatever you want.
	
	" Write VIM with toilet
	call append('$', "")
	call append('$','        stone''s vimrc')
	call append('$', "")

	" Draw the MOTD from Fortune's file in ~/.vim/fortunes
	call append('$', '        tip:')
	for line in split(system('fortune $HOME/.vim/fortunes'), '\n')
		call append('$', '        ' . l:line)
	endfor


	" ... and set some options for it
	setlocal
				\ nocursorcolumn
				\ nocursorline
				\ nolist
				\ nonumber
				\ foldcolumn=0
				\ nofoldenable
				\ noswapfile
				\ norelativenumber
				\ nobuflisted
				"\ buftype=terminal

	" No modifications to this buffer
	setlocal nomodifiable nomodified

	" When we go to insert mode start a new buffer, and start insert
	nnoremap <buffer><silent> <CR> :q
	nnoremap <buffer><silent> e :enew<CR>
	nnoremap <buffer><silent> i :enew <bar> startinsert<CR>
	nnoremap <buffer><silent> o :enew <bar> startinsert<CR>

	nnoremap <buffer><silent> h :enew<CR>
	nnoremap <buffer><silent> j :enew<CR>
	nnoremap <buffer><silent> k :enew<CR>
	nnoremap <buffer><silent> l :enew<CR>
endfun

" Run after "doing all the startup stuff"
autocmd VimEnter * call Start()
