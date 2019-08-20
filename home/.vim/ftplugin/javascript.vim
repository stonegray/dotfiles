" Javascript configuration

" Syntax & Linting
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""



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


" ALE Config
let g:ale_sign_error = 'E'
let g:ale_sign_warning = 'w'

highlight ALEErrorSign ctermbg=red ctermfg=black
highlight ALEWarningSign ctermbg=none ctermfg=yellow

let g:ale_fixers = {
		\ 'javascript': ['eslint'],
		\ 'json': ['jq'],
		\ 'typescript': ['tslint', 'eslint'],
			\ 'html': ['eslint']
			\}

let g:ale_fix_on_save = 1
let g:ale_set_balloons = 1

" Theme
highlight ALEWarning ctermbg=DarkMagenta
let g:ale_completion_enabled = 1


" Always show the sidbar to avoid jumping around when you only have one error
" left:
let g:ale_sign_column_always = 1
let g:ale_statusline_format = ['%d error(s)', '%d warning(s)', 'OK']

" Set this. Airline will handle the rest.
let g:airline#extensions#ale#enabled = 1



" Folding
let javaScript_fold=1 "activate folding by JS syntax

" Folding configuration

hi Folded ctermfg=102 guifg=#878787 guibg=NONE ctermbg=NONE
set fillchars=fold:\ "don't delete this comment or vim will eat the trailing \



" Browsing & Files
let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|git\/*'


" Delimitmate
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let b:delimitMate_expand_cr = 1
let b:delimitMate_smart_quotes = 1
let b:delimitMate_smart_matchpairs = 1
let b:delimitMate_autoclose = 1
