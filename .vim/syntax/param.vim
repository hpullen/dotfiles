if exists("b:current_syntax")
    finish
endif

" Name of parameter
syn match paramName "^\w\+\>"

" Parameter value
syn match paramVal "\<\d\+\.\?\d*$"

" Starting value
syn match startVal "\<\d\+\.\?\d*\>\s"

" Upper/lower limits
syn match upperLower "\<\d\+\.\?\d*\>\s\<\d\+\.\?\d*\s*$"

let b:current_syntax = "param"

hi def link paramName Function
hi def link paramVal Constant
hi def link startVal PreProc
hi def link upperLower Type

" Blue = Function
" Purple = Todo
" Orange = Type
" Turqouise = Constant
" Grey = Comment
" Red = PreProc
" Pink = Namespace
" Green = Keyword/Operator/Statement

