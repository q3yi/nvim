(function_definition) @function.outer

(function_definition
  body: (compound_statement
    .
    "{"
    _+ @function.inner
    "}"))

([
  (case_statement)
  (if_statement)
  (else_clause)
  (for_statement)
  (while_statement)
  (comment)
]) @block.outer

(if_statement
  (_) @block.inner) 

(for_statement
  (_) @block.inner)

(while_statement
  (_) @block.inner)

(regex) @block.inner

