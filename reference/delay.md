# Delay the evaluation of an expression until the end of a function or block.

Delay the evaluation of an expression until the end of a function or
block.

## Usage

``` r
delay(expr, envir = parent.frame(), add = TRUE, after = FALSE)
```

## Arguments

- expr:

  An expression to be evaluated later.

- envir:

  The environment in which to evaluate the expression.

- add:

  if TRUE, add `expr` to be executed after any previously set
  expressions (or before if `after` is FALSE); otherwise (the default)
  `expr` will overwrite any previously set expressions.

- after:

  if `add` is TRUE and `after` is FALSE, then `expr` will be added on
  top of the expressions that were already registered. The resulting
  last in first out order is useful for freeing or closing resources in
  reverse order.

## Value

None, called for its side-effects

## Examples

``` r
local({
  x <- 1L
  delay(message("x = ", x))
  x <- 2L
})
#> x = 2
```
