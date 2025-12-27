# Muffle messages

Aliases for
[`base::suppressMessages()`](https://rdrr.io/r/base/message.html) and
[`base::suppressWarnings()`](https://rdrr.io/r/base/warning.html)

## Usage

``` r
muffle(expr, fun, classes = "message")

wuffle(expr, fun, classes = "warning")
```

## Arguments

- expr:

  An expression to evaluate

- fun:

  A function to *muffle* (or *wuffle*)

- classes:

  A character vector if classes to suppress

## Value

The result of `expr` or a `function` wrapping `fun`

## Examples

``` r
# load function
foo <- function(...) {
  message("You entered :", paste0(...))
  c(...)
}

# wrap around function or muffle the function ti's
muffle(foo(1, 2))
#> [1] 1 2
muffle(fun = foo)(1, 2)
#> [1] 1 2
sapply(1:3, muffle(fun = foo))
#> [1] 1 2 3

# silence warnings
wuffle(as.integer("a"))
#> [1] NA
sapply(list(1, "a", "0", ".2"), wuffle(fun = as.integer))
#> [1]  1 NA  0  0
```
