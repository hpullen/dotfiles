if exists("b:current_syntax")
    finish
endif

" Mathematical expressions
syn keyword mathWord abs sqrt pow

" Numbers
syn match cutVal "-\?\<\d\+\.\?\d*\>"

" Variables
syn match varName "\<Bd\w\+\>"
syn match varName "\<D0_\w\+\>"
syn match varName "\<D0K_\w\+\>"
syn match varName "\<D0Pi_\w\+\>"
syn match varName "\<Kstar_\w\+\>"
syn match varName "\<KstarK_\w\+\>"
syn match varName "\<KstarPi_\w\+\>"
syn match varName "\<D0Kplus_\w\+\>"
syn match varName "\<D0Kminus_\w\+\>"
syn match varName "\<Kminus_\w\+\>"
syn match varName "\<D0PiPlus_\w\+\>"
syn match varName "\<D0PiMinus_\w\+\>"

" Numbers as part of argument
syn match argNumber ",\s*\d\+\.\?\d*"
syn match argNumber "\d\+\.\?\d*,"
syn match argNumber "(\d\+\.\?\d*"
syn match argNumber "\d\+\.\?\d*)"

let b:current_syntax = "cut"

hi def link mathWord Statement
hi def link varName Todo
hi def link cutVal Constant
