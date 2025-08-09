(declaration
  declarator: (function_declarator)) @function.outer

(function_definition
  body: (compound_statement)) @function.outer

(function_definition
  body: (compound_statement
    .
    "{"
    _+ @function.inner
    "}"))

(struct_specifier
  body: (_) @class.inner) @class.outer

(enum_specifier
  body: (_) @class.inner) @class.outer

; conditionals
(if_statement
  consequence: (compound_statement
    .
    "{"
    _+ @block.inner
    "}")) @block.outer

(if_statement
  alternative: (else_clause
    (compound_statement
      .
      "{"
      _+ @block.inner
      "}"))) @block.outer

(if_statement) @block.outer

(if_statement
  condition: (_) @block.inner
  (#offset! @block.inner 0 1 0 -1))

(while_statement
  condition: (_) @block.inner
  (#offset! @block.inner 0 1 0 -1))

(do_statement
  condition: (_) @block.inner
  (#offset! @block.inner 0 1 0 -1))

(for_statement
  condition: (_) @block.inner)

; loops
(while_statement) @block.outer

(while_statement
  body: (compound_statement
    .
    "{"
    _+ @block.inner
    "}")) @block.outer

(for_statement) @block.outer

(for_statement
  body: (compound_statement
    .
    "{"
    _+ @block.inner
    "}")) @block.outer

(do_statement) @block.outer

(do_statement
  body: (compound_statement
    .
    "{"
    _+ @block.inner
    "}")) @block.outer

(compound_statement) @block.outer

(comment) @block.outer

(call_expression) @block.outer

(call_expression
  arguments: (argument_list
    .
    "("
        _+ @block.inner
    ")"))

(return_statement
  (_)? @block.inner) @block.outer

; Statements
;(expression_statement ;; this is what we actually want to capture in most cases (";" is missing) probably
;(_) @statement.inner) ;; the other statement like node type is declaration but declaration has a ";"
(compound_statement
  (_) @block.outer)

(field_declaration_list
  (_) @block.outer)

(preproc_if
  (_) @block.outer)

(preproc_elif
  (_) @block.outer)

(preproc_else
  (_) @block.outer)

(parameter_list
  "," @block.outer
  .
  (parameter_declaration) @block.inner @block.outer)

(parameter_list
  .
  (parameter_declaration) @block.inner @block.outer
  .
  ","? @block.outer)

(argument_list
  "," @block.outer
  .
  (_) @block.inner @block.outer)

(argument_list
  .
  (_) @block.inner @block.outer
  .
  ","? @block.outer)

(number_literal) @block.inner

(declaration
  declarator: (init_declarator
    declarator: (_) @assignment.lhs
    value: (_) @assignment.rhs) @assignment.inner) @assignment.outer

(declaration
  type: (primitive_type)
  declarator: (_) @assignment.inner)

(expression_statement
  (assignment_expression
    left: (_) @assignment.lhs
    right: (_) @assignment.rhs) @assignment.inner) @assignment.outer
