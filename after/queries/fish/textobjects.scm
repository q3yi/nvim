; block
([
  (case_clause)
  (if_statement)
  (switch_statement)
  (else_clause)
  (for_statement)
  (while_statement)
]) @block.outer


; comment
; leave space after comment marker if there is one
((comment) @block.inner @block.outer
  (#offset! @block.inner 0 2 0 0)
  (#lua-match? @block.outer "# .*"))

; else remove everything accept comment marker
((comment) @block.inner @block.outer
  (#offset! @block.inner 0 1 0 0))

; conditional
(if_statement
  (command) @block.inner) @block.outer

(switch_statement
  (_) @block.inner) @block.outer

; function
((function_definition) @function.inner @function.outer
  (#offset! @function.inner 1 0 -1 1))

; loop
(for_statement
  (_) @block.inner) @block.outer

(while_statement
  condition: (command)
  (command) @block.inner) @block.outer

