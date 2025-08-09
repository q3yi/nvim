; block
(_
  (block) @block.inner) @block.outer

; call
(function_call) @call.outer

(function_call
  (arguments) @call.inner
  (#match? @call.inner "^[^\\(]"))

(function_call
  arguments: (arguments
    .
    "("
    _+ @block.inner
    ")"))

; class
; comment
(comment) @block.outer

; conditional
(if_statement
  alternative: (_
    (_) @block.inner)?) @block.outer

(if_statement
  consequence: (block)? @block.inner)

(if_statement
  condition: (_) @block.inner)

(table_constructor
  (_) @block.inner) @block.outer

(_
  local_declaration: (_) @block.outer)

(expression_list) @block.outer

; frame
; function
[
  (function_declaration)
  (function_definition)
] @function.outer

(function_declaration
  body: (_) @function.inner)

(function_definition
  body: (_) @function.inner)

; return
(return_statement
  (_)? @return.inner) @return.outer

; loop
[
  (while_statement)
  (for_statement)
  (repeat_statement)
] @block.outer

(while_statement
  body: (_) @block.inner)

(for_statement
  body: (_) @block.inner)

(repeat_statement
  body: (_) @block.inner)

; parameter
(arguments
  .
  (_) @parameter.inner @parameter.outer
  .
  ","? @parameter.outer)

(parameters
  .
  (_) @parameter.inner @parameter.outer
  .
  ","? @parameter.outer)

(table_constructor
  (field) @parameter.inner @parameter.outer
  ","? @parameter.outer)

(arguments
  "," @parameter.outer
  .
  (_) @parameter.inner @parameter.outer)

(parameters
  "," @parameter.outer
  .
  (_) @parameter.inner @parameter.outer)

; number
(number) @number.inner

(assignment_statement
  (variable_list) @assignment.lhs
  (expression_list) @assignment.inner @assignment.rhs) @assignment.outer

(assignment_statement
  (variable_list) @assignment.inner)

; scopename
; statement
