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

" Auto install plugin manager
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Plugins
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" set the runtime path to include Vundle and initialize
set runtimepath+=~/.vim_runtime
call plug#begin('~/.vim/plugged')

" Various plugins
Plug 'neoclide/coc.nvim', {'tag': '*', 'branch': 'release'}

" Git
Plug 'tpope/vim-fugitive'

" UI
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'airblade/vim-gitgutter'
Plug 'jistr/vim-nerdtree-tabs'

" Chording:
Plug 'kana/vim-arpeggio'

" Filetypes
if has('mac')
	Plug 'darfink/vim-plist'
endif

Plug 'tomtom/tlib_vim'

" Syntax Language:
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-markdown'
Plug 'editorconfig/editorconfig-vim'
Plug 'junegunn/fzf.vim' 
set rtp+=/usr/local/opt/fzf

Plug 'SirVer/ultisnips'
Plug 'christoomey/vim-tmux-navigator'
Plug 'ctrlpvim/ctrlp.vim'

" Themes:
Plug 'jdkanani/vim-material-theme'
Plug 'luochen1990/rainbow'
let g:rainbow_active = 1 "0 if you want to enable it later via :RainbowToggle


Plug 'chriskempson/base16-vim'
Plug 'vim-airline/vim-airline-themes'
Plug 'BarretRen/vim-colorscheme'
Plug 'NLKNguyen/papercolor-theme'
Plug 'balanceiskey/vim-framer-syntax'

call plug#end()
filetype plugin indent on    " required


" Plugin Configuration:
let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|git\/*'
let g:ctrlp_show_hidden = 1

nnoremap <silent> <C-w>h :TmuxNavigateLeft<cr>
nnoremap <silent> <C-w>j :TmuxNavigateDown<cr>
nnoremap <silent> <C-w>k :TmuxNavigateUp<cr>
nnoremap <silent> <C-w>l :TmuxNavigateRight<cr>
nnoremap <silent> <C-w>/ :TmuxNavigatePrevious<cr>

" Fence langages
let g:markdown_fenced_languages = ['bash=sh', 'javascript', 'js=javascript', 'json=javascript', 'xml']

" Folding
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"-- FOLDING --
set foldlevelstart=3 "start file with most folds opened
autocmd BufWrite * mkview
autocmd BufRead * silent! loadview

set foldcolumn=1 "defines 1 col at window left, to indicate folding
set foldmethod=indent "syntax highlighting items specify folds

" NERDTree
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Uncomment to close if only tree is open:
"autocmd WinEnter * call s:CloseIfOnlyNerdTreeLeft()

" hide nerdtree by default, some tweaks liek focus.
let NERDTreeShowHidden=1
let NERDTreeQuitOnOpen=1

autocmd StdinReadPre * let s:std_in=1
"autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

" Fix a weird bug where opening Gstatus makes nerdtree zero width
" autocmd VimEnter * wincmd p
autocmd vimenter * set winwidth=25
autocmd vimenter * set winminwidth=25

let NERDTreeIgnore = ['\.pyc$', '\.swp$']
let NERDTreeShowHidden = 1
let g:NERDTreeWinPos = "left"

let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1

" Autocompletion
""""""""""""""""""
" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.

" make YCM compatible with UltiSnips (using supertab)
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
let g:SuperTabDefaultCompletionType = '<C-n>'

" better key bindings for UltiSnipsExpandTrigger
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"
let g:UltiSnipsSnippetDirectories = ['~/.vim/snips']


" Language

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Create mappings for function text object, requires document symbols feature of languageserver.

xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Use <tab> for select selections ranges, needs server support, like: coc-tsserver, coc-python
nmap <silent> <TAB> <Plug>(coc-range-select)
xmap <silent> <TAB> <Plug>(coc-range-select)
xmap <silent> <S-TAB> <Plug>(coc-range-select-backword)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add status line support, for integration with other plugin, checkout `:h coc-status`
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Using CocList
" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>







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
		"echo "[+] ". (localtime() - b:save_time) ." seconds have elapsed so far."
	endif
endfunction

"au CursorHold * call UpdateFile()
"au CursorMoved * call UpdateFile()

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

let g:airline_theme='base16_google'
let base16colorspace=256
colorscheme base16-default-dark


" Keybindings!
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let mapleader=" "
noremap <Space> <Nop>

map <Leader>n <plug>NERDTreeTabsToggle<CR>

" Save with sudo if W is used:
command W w !sudo tee % > /dev/null

" Q iS nOt aN eDiToR cOmMaNd
command Q q

" Select all
map <Leader>a ggVG

nnoremap <leader>f :call RelToggle()<cr>

function! RelToggle()
	if &relativenumber
		setlocal relativenumber=0
	else
		setlocal relativenumber=4
	endif
endfunction


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
:imap <C-q> <Esc>:q

call arpeggio#map('i', '', 0, 'jk', '<Esc>')

"Save
:imap <C-s> <Esc>:q<CR>i
:cnoremap <C-s> :w<CR>
map <Leader>w :w<CR>

command! -nargs=+ Ex execute 'silent !<args>' | redraw!
nnoremap <Leader>` :Ex<space>
nnoremap <C-`> :Ex<space>

" improve vs resizing
if bufwinnr(1)
	nnoremap + <C-W>>
	nnoremap - <C-W><
endif

" esc closes term
tnoremap <Esc> <C-\><C-n>

" Macro for replace
nnoremap <Leader>r :hs/

command Term :split | resize 15 | term

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
