# Default value for `NULL` or no length

Replace if `NULL` or not length

## Usage

``` r
x %||% y

x %|||% y

x %len% y
```

## Arguments

- x, y:

  If `x` is `NULL` returns `y`; otherwise `x`

## Value

`x` if it is not `NULL` or has length, depending on check

## Details

A mostly copy of `rlang`'s `%||%` except does not use
[`rlang::is_null()`](https://rlang.r-lib.org/reference/type-predicates.html),
which, currently, calls the same primitive
[base::is.null](https://rdrr.io/r/base/NULL.html) function.

Note: `%||%` is copied from `{base}` if available (**R** versions \>=
4.4)

## Examples

``` r
# replace NULL (for R < 4.4)
NULL %||% 1L
#> [1] 1
2L   %||% 1L
#> [1] 2

# replace empty
""       %|||% 1L
#> [1] 1
NA       %|||% 1L
#> [1] 1
double() %|||% 1L
#> [1] 1
NULL     %|||% 1L
#> [1] 1

# replace no length
logical() %len% TRUE
#> [1] TRUE
FALSE     %len% TRUE
#> [1] FALSE
```
