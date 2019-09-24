" Javascript configuration

" Syntax & Linting
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
setlocal number

setlocal tabstop=4
setlocal shiftwidth=4
setlocal softtabstop=4
setlocal textwidth=80
setlocal noexpandtab
setlocal autoindent
setlocal smartindent
setlocal fileformat=unix
setlocal smarttab
setlocal cindent

" ALE Config
let g:ale_sign_error = 'E'
let g:ale_sign_warning = 'w'

" Theme
highlight ALEWarning ctermbg=DarkMagenta

hi Folded ctermfg=102 guifg=#878787 guibg=NONE ctermbg=NONE
set fillchars=fold:\ "don't delete this comment or vim will eat the trailing \

" Browsing & Files
let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|git\/*'


