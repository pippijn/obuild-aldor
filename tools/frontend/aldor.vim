if !exists("main_syntax")
  if version < 600
    syntax clear
  elseif exists("b:current_syntax") && b:current_syntax != "aldor"
    finish
  endif
  syn clear
  let main_syntax = 'aldor'
endif

syn keyword     aldorTodo               contained TODO FIXME XXX TEMPORARY
syn keyword     aldorExternal           import export inline from to Foreign C Fortran Lisp Builtin
syn keyword     aldorOperator           add and always break but catch default define delay do else except extend
syn keyword     aldorOperator           fix for fluid free generate goto has if in is isnt iterate let local
syn keyword     aldorOperator           macro never not of or pretend ref repeat return rule select then throw try where while
syn keyword     aldorOperator           with yield macro char generate next
syn keyword     aldorFunction           dissemble assemble
syn keyword     aldorFunction           assert shift hash prev quo coerce complex conjugate norm
syn match       aldorConstant           "\v<(false|true|nil|stdout|stderr|stdin|print|space|tab|newline|min|max|epsilon)>"
syn match       aldorFunction           "\v<\w+[?!]"
syn keyword     aldorFlowControl        if then else while repeat local
syn match       aldorType               "\v<[A-Z]\w*>"

syn match       aldorOperator           "-\|:\|=\|>\|+\|\\\|/\|\~\|<\|>\|\*\|\^"

syn match       aldorComment            "++.*" contains=aldorTodo
syn match       aldorComment            "--.*" contains=aldorTodo
syn match       aldorPreproc            "\v#(if \w*|elseif \w*|else|endif|assert \w*|unassert \w*)"

syn match       aldorExternal           "\v^#(include|library)(Dir)?\s+[^ \t]+" contains=aldorString
syn match       aldorString             "\v^(#include\s+)\zs[^ \t]+" contained
syn match       aldorError              "\v^(\s+#|#\s+|\s+#\s+)(include|library)(Dir)?\s+[^ \t]+" contains=aldorString
syn match       aldorError              "\v^#include\s+[^ \t]+\s.*"
syn match       aldorExternal           "\v^#(pile|endpile|quit)$"
syn match       aldorExternal           "\v^#(int|error).+$" contains=aldorNothing
syn match       aldorNothing            "\v^#(int|error)\zs.*" contained

syn include @aldorLatex syntax/tex.vim
unlet b:current_syntax
syn region      aldorLatexComment       matchgroup=aldorPreproc start="#if ALDOC" end="#endif" contains=@aldorLatex

syn region      aldorString     start=+"+  skip=+__\|_"+  end=+"+
syn match       aldorFloat      "\v\.\d*(e[-+]=\d+)=>"
syn match       aldorInteger    "\v-?<\d+>|<\d+[rR][0-9a-zA-Z]+>"

hi def link aldorInteger        aldorNumber
hi def link aldorFloat          aldorNumber
hi def link aldorNumber         Number
hi def link aldorOperator       Operator
hi def link aldorTodo           Todo
hi def link aldorFlowControl    Operator
hi def link aldorComment        Comment
hi def link aldorPreproc        Preproc
hi def link aldorExternal       Include
hi def link aldorType           Type
hi def link aldorFunction       Function
hi def link aldorConstant       Constant
hi def link aldorString         String
hi def link aldorError          Error

let b:current_syntax = "aldor"

if main_syntax == 'aldor'
  unlet main_syntax
endif

" XXX: this should go elsewhere
set noexpandtab
