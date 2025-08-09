(value_definition
  (let_binding
    body: (_) @function.inner)) @function.outer

(method_definition
  body: (_) @function.inner) @function.outer

(class_definition
  (class_binding
    body: (_) @class.inner)) @class.outer

(for_expression
  (do_clause
    (_) @block.inner)) @block.outer

(while_expression
  (do_clause
    (_) @block.inner)) @block.outer

(if_expression
  condition: (_)
  (then_clause
    (_) @block.inner)
  (else_clause
    (_) @block.inner)) @block.outer

(if_expression
  condition: (_)
  (then_clause
    (_) @block.inner)) @block.outer


(comment) @block.outer

(parameter) @block.outer
