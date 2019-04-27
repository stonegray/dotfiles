" stonegray's vimrc
"
" Requirements:
" - Vundle
" - ctags
" - estags
" - fzf
" - prettier/eslint for javascript files

" Vundle required
set nocompatible
filetype off


" Plugins
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set runtimepath+=~/.vim_runtime
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()


" Various plugins
Plugin 'VundleVim/Vundle.vim'
Plugin 'tpope/vim-fugitive'

" UI
Plugin 'scrooloose/nerdtree'
Plugin 'Xuyuanp/nerdtree-git-plugin'
Plugin 'airblade/vim-gitgutter'
Plugin 'jistr/vim-nerdtree-tabs'
Plugin 'vim-airline/vim-airline'
Plugin 'majutsushi/tagbar'

Plugin 'hushicai/tagbar-javascript.vim'

" Completion etc
Plugin 'w0rp/ale'

Plugin 'SirVer/ultisnips'
Plugin 'delimitMate.vim'
Plugin 'honza/vim-snippets'
Plugin 'sunaku/vim-dasht'

" Syntax/Language
Plugin 'sheerun/vim-polyglot'
"Plugin 'Chiel92/vim-autoformat'
"Plugin 'isRuslan/vim-es6'
"Plugin 'pseewald/vim-anyfold'
Plugin 'meain/vim-package-info', { 'do': 'npm install' }
"Plugin 'leafgarland/typescript-vim'
"Plugin 'heavenshell/vim-jsdoc'



Plugin 'editorconfig/editorconfig-vim'
Plugin 'junegunn/fzf.vim'
set rtp+=/usr/local/opt/fzf
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'ctrlpvim/ctrlp.vim'

" Themes
Plugin 'jdkanani/vim-material-theme'
Plugin 'luochen1990/rainbow'
Plugin 'vim-airline/vim-airline-themes'
let g:rainbow_active = 1 "0 if you want to enable it later via :RainbowToggle
Plugin 'BarretRen/vim-colorscheme'
Plugin 'NLKNguyen/papercolor-theme'

call vundle#end()            " required
filetype plugin indent on    " required


" Plugin Configuration
"
let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|git\|built/*'
let g:ctrlp_show_hidden = 1



"let g:tmux_navigator_no_mappings = 1

"nnoremap <silent> <C-w>h :TmuxNavigateLeft<cr>
"nnoremap <silent> <C-w>j :TmuxNavigateDown<cr>
"nnoremap <silent> <C-w>k :TmuxNavigateUp<cr>
"nnoremap <silent> <C-w>l :TmuxNavigateRight<cr>
"nnoremap <silent> <C-w>/ :TmuxNavigatePrevious<cr>








" Folding
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"-- FOLDING --
set foldlevelstart=2 "start file with all folds opened
autocmd BufWrite * mkview
autocmd BufRead * silent! loadview
set foldcolumn=1 "defines 1 col at window left, to indicate folding
"let javaScript_fold=1 "activate folding by JS syntax
set foldmethod=indent "syntax highlighting items specify folds

" NERDTree
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"autocmd WinEnter * call s:CloseIfOnlyNerdTreeLeft()

" Close all open buffers on entering a window if the only
" buffer that's left is the NERDTree buffer
function! s:CloseIfOnlyNerdTreeLeft()
	if exists("t:NERDTreeBufName")
		if bufwinnr(t:NERDTreeBufName) != -1
			if winnr("$") == 1
				" q
			endif
		endif
	endif
endfunction

" show nerdtree by default, some tweaks liek focus.
let NERDTreeShowHidden=0
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

" Enable sticky tree using plugin
"autocmd vimenter * NERDTreeTabsOpen
"autocmd vimenter * NERDTree

" Fix a weird bug where opening Gstatus makes nerdtree zero width
"autocmd VimEnter * wincmd p
autocmd vimenter * set winwidth=25
autocmd vimenter * set winminwidth=25

let NERDTreeIgnore = ['\.pyc$']
let NERDTreeShowHidden = 1
let g:NERDTreeWinPos = "left"

let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1

" Simple Changes
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set path+=**

" View changes
syntax on
set ruler
set visualbell
set modelines=0
set nomodeline
set splitbelow


" terminal

set mouse=a
set ttymouse=xterm2



" misc
set background=dark
set number
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

"Improve cli completion
set wildmode=longest,list,full
set showcmd

" make search better
set hlsearch "highlight stuff
set ignorecase
set smartcase

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


set undolevels=5000
set undoreload=50000

set history=1000

" Better whitespace chars
set listchars+=space:␣
set listchars+=eol:¬
set listchars+=tab:··

set cmdheight=2

" Automatically reload file when it changes externally
set autoread

" File browser
let g:netrw_banner=0
let g:newrw_browse_split=4
let g:netrw_altv=1 " splits to right
let g:netrw_liststyle=3 "tree
let g:netrw_list_nide=netrw_gitignore#Hide()
"let g:netrw_list_hide


" Syntax & Linting
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Add status information:
"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*

" opts

" ALE Config
let g:ale_sign_error = 'E'
let g:ale_sign_warning = 'w'


highlight ALEErrorSign ctermbg=red ctermfg=black
highlight ALEWarningSign ctermbg=none ctermfg=yellow

let g:ale_fixers = {
			\ 'javascript': ['prettier', 'eslint'],
			\ 'json': ['jq'],
			\ 'typescript': ['eslint']
			\}

let g:ale_fix_on_save = 1

let g:ale_set_balloons = 1

" Theme
highlight ALEWarning ctermbg=DarkMagenta
"let g:ale_completion_enabled = 1


" Always show the sidbar to avoid jumping around when you only have one error
" left:
let g:ale_sign_column_always = 1
let g:ale_statusline_format = ['%d error(s)', '%d warning(s)', 'OK']

" Set this. Airline will handle the rest.
let g:airline#extensions#ale#enabled = 1

" Autocompletion
""""""""""""""""""

let g:jsdoc_allow_input_prompt =1

" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

let g:UltiSnipsSnippetDirectories = ['~/.vim/snips']


" Typescript
""""""""""""""""""""'

" use tsc as makeprog
"autocmd FileType typescript :set makeprg=tsc

" Show qf on errors
"autocmd QuickFixCmdPost [^l]* nested cwindow
"autocmd QuickFixCmdPost    l* nested lwindow

" Disable the ts plugin's indenter.
"let g:typescript_indent_disable = 0

" Autosave
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:autosave_time = 1


" Save time when you open a file
au BufRead,BufNewFile * let b:save_time = localtime()

" save if needed / update the save_time after the save
function! UpdateFile()
	if((localtime() - b:save_time) >= g:autosave_time)
		update
		let b:save_time = localtime()
	else
		" just debugging info
		echo "[+] ". (localtime() - b:save_time) ." seconds have elapsed so far."
	endif
endfunction

"au CursorHold * call UpdateFile()
"au CursorMoved * call UpdateFile()

" Airline
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:airline#extensions#tabline#enabled = 1



" Theme
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:rainbow_conf = {
			\	'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick'],
			\	'ctermfgs': ['blue', 'yellow', 'cyan', 'magenta'],
			\	'operators': '_,_',
			\	'parentheses': ['start=/(/ end=/)/ fold', 'start=/\[/ end=/\]/ fold', 'start=/{/ end=/}/ fold'],
			\	'separately': {
			\		'*': {},
			\		'tex': {
			\			'parentheses': ['start=/(/ end=/)/', 'start=/\[/ end=/\]/'],
			\		},
			\		'lisp': {
			\			'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick', 'darkorchid3'],
			\		},
			\		'vim': {
			\			'parentheses': ['start=/(/ end=/)/', 'start=/\[/ end=/\]/', 'start=/{/ end=/}/ fold', 'start=/(/ end=/)/ containedin=vimFuncBody', 'start=/\[/ end=/\]/ containedin=vimFuncBody', 'start=/{/ end=/}/ fold containedin=vimFuncBody'],
			\		},
			\		'html': {
			\			'parentheses': ['start=/\v\<((area|base|br|col|embed|hr|img|input|keygen|link|menuitem|meta|param|source|track|wbr)[ >])@!\z([-_:a-zA-Z0-9]+)(\s+[-_:a-zA-Z0-9]+(\=("[^"]*"|'."'".'[^'."'".']*'."'".'|[^ '."'".'"><=`]*))?)*\>/ end=#</\z1># fold'],
			\		},
			\		'css': 0,
			\	}
			\}

"let g:airline_powerline_fonts = 1

let g:airline_theme='jellybeans'
colorscheme PaperColor


" Less obnoxous folding
hi Folded ctermfg=102 guifg=#878787 guibg=NONE ctermbg=NONE
set fillchars=fold:\ "don't delete this comment or vim will eat the trailing \


" Misc Plugins
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:dasht_results_window = 'botright vnew'


let delimitMate_expand_cr = 1

" Disable delimitMate: Using manual completions
au FileType javascript let b:loaded_delimitMate = 1



" Keybindings!
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let mapleader=" "

map <Leader>n <plug>NERDTreeTabsToggle<CR>

" Save with sudo if W is used:
command W w !sudo tee % > /dev/null

" Q iS nOt aN eDiToR cOmMaNd
command Q q


" In insert or command mode, move normally by using Ctrl
inoremap <C-h> <Left>
inoremap <C-j> <Down>
inoremap <C-k> <Up>
inoremap <C-l> <Right>
cnoremap <C-h> <Left>
cnoremap <C-j> <Down>
cnoremap <C-k> <Up>
cnoremap <C-l> <Right>

" Easy window move
"map <C-j> <C-W>j
"map <C-h> <C-W>h
"map <C-k> <C-W>k
"map <C-l> <C-W>l

map <Leader>j 20G
map <Leader>k 20g

" Next tab with t
map <Leader>t :tabnext <return>

" Use :gs to open Gstatus on right side of screen
command Gvstatus vertical belowright Gstatus
command Gbstatus botright Gstatus
cnoreabbrev gs Gvstatus
cnoreabbrev ghs Gbstatus

" don't get emacs finger
":imap ;; <Esc>
:imap kj <Esc>
:imap <C-q> <Esc>:q

"Save
:imap <C-s> <Esc>:q<CR>i
:cnoremap <C-s> :w<CR>
map <Leader>w :w<CR>

command! -nargs=+ Ex execute 'silent !<args>' | redraw!
nnoremap <Leader>` :Ex<space>
nnoremap <C-`> :Ex<space>


" Macro for replace
nnoremap <Leader>r :hs/


command Term term /usr/local/bin/fish


fun! Start()
	" Don't run if: we have commandline arguments, we don't have an empty
	" buffer, if we've not invoked as vim or gvim, or if we'e start in insert mode
	if argc() || line2byte('$') != -1 || v:progname !~? '^[-gmnq]\=vim\=x\=\%[\.exe]$' || &insertmode
		return
	endif

	" Start a new buffer ...
	enew " Now we can just write to the buffer, whatever you want.
	call append('$', "")
	for line in split(system('toilet vim && fortune -al'), '\n')
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
				\ bufhidden=wipe
				\ buftype=nofile
				\ nobuflisted


	" No modifications to this buffer
	setlocal nomodifiable nomodified

	" When we go to insert mode start a new buffer, and start insert
	nnoremap <buffer><silent> <CR> :q
	nnoremap <buffer><silent> e :enew<CR>
	nnoremap <buffer><silent> i :enew <bar> startinsert<CR>
	nnoremap <buffer><silent> o :enew <bar> startinsert<CR>
endfun

" Run after "doing all the startup stuff"
"autocmd VimEnter * call Start()

" Reindent
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
"" Restore cursor position, window position, and last search after running a
" command.
function! Preserve(command)
  " Save the last search.
  let search = @/

  " Save the current cursor position.
  let cursor_position = getpos('.')

  " Save the current window position.
  normal! H
  let window_position = getpos('.')
  call setpos('.', cursor_position)

  " Execute the command.
  execute a:command

  " Restore the last search.
  let @/ = search

  " Restore the previous window position.
  call setpos('.', window_position)
  normal! zt

  " Restore the previous cursor position.
  call setpos('.', cursor_position)
endfunction

" Re-indent the whole buffer.
function! Indent()
  call Preserve('normal gg=G')
endfunction
