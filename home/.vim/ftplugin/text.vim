" text

" Display
set nonumber

" Text Flow
set wrap linebreak
set textwidth=0

set noautoindent
set nosmartindent
set nocindent

" Move literally.
nnoremap j gj  
nnoremap k gk

" Folding
set foldenable
set foldmethod=marker

" Spellcheck / Thesaurus
set spell
set thesaurus+=~/.vim/thesaurus/main.txt

set spell spelllang=en_us
set spellsuggest=fast,20 "Don't show too much suggestion for spell check.
set spellfile=~/Library/Spelling/LocalDictionary.utf-8.add

" Linter

let g:ale_sign_error = 'E'
let g:ale_sign_warning = 'w'

highlight ALEErrorSign ctermbg=red ctermfg=black
highlight ALEWarningSign ctermbg=none ctermfg=yellow

let g:ale_fix_on_save = 1
let g:ale_set_balloons = 1

highlight ALEWarning ctermbg=DarkMagenta
let g:ale_completion_enabled = 1


" Always show the sidbar to avoid jumping around when you only have one error
" left:
let g:ale_sign_column_always = 1
let g:ale_statusline_format = ['%d error(s)', '%d warning(s)', 'OK']

" Set this. Airline will handle the rest.
let g:airline#extensions#ale#enabled = 1

