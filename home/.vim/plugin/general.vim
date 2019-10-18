

" Simple Changes
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set path+=**

set showtabline=0

" View changes
syntax on
set ruler
set visualbell
set modelines=0
set nomodeline
set splitright

" terminal
set mouse=a
set cursorline

" misc
set background=dark
set tabstop=4
set shiftwidth=4
set softtabstop=4
set textwidth=80
set noexpandtab
set autoindent
set smartindent
set fileformat=unix
set smarttab
set cindent
set bs=2

set nonumber

"Improve cli completion
set wildmode=longest,list,full
set showcmd

" make search better
set hlsearch "highlight stuff
set ignorecase " ignore case in search
set smartcase " but if we put a capital letter, don't ignore it.

" Draw more chars on redarw
set ttyfast
set lazyredraw

" Better persistent undo
set undofile
set undodir=$HOME/.vim/undo

" Ensure directory exists for persistent undo
command! -nargs=+ Silent
		\   execute 'silent <args>'
		\ | redraw!

set scrolloff=5

" Show file title in terminal tab
set title

set undolevels=5000
set undoreload=50000

set history=1000

" Better whitespace chars
set listchars+=space:␣
set listchars+=eol:¬
set listchars+=tab:··

" Keep this at default
set cmdheight=1


" Set update time
set updatetime=300

" File browser
" Netrw is still best for working on ssh
let g:netrw_banner=0
let g:newrw_browse_split=4
let g:netrw_altv=1 " splits to right
let g:netrw_liststyle=3 "tree
let g:netrw_list_nide=netrw_gitignore#Hide()
"let g:netrw_list_hide

" Neovim has SGR enabled by default.
" Enable mouse mode working past 220th column
" https://stackoverflow.com/questions/7000960/in-vim-why-doesnt-my-mouse-work-past-the-220th-column
if !has('nvim')
	set hlsearch
	if has("mouse_sgr")
		set ttymouse=sgr
	else
		set ttymouse=xterm2
	end
endif 
