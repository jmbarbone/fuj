# Negations

`not()` is an *alias* for [base::!](https://rdrr.io/r/base/Logic.html).
`negate()` is a variation of
[`base::Negate()`](https://rdrr.io/r/base/funprog.html) with an extra
steps to preserve the original function and maintain the function
formals.

## Usage

``` r
not(x)

negate(fun)
```

## Arguments

- x:

  An object

- fun:

  A function

## Value

`not()` See [base::!](https://rdrr.io/r/base/Logic.html)

`negate()` A `function`, which is the negation of `fun`

## Details

Negate an outcome or function

## Examples

``` r
identical(not(TRUE), FALSE)
#> [1] TRUE

different <- negate(identical)
different(formals(identical), formals(identical))
#> [1] FALSE
```
