# Quick DF

This is a speedier implementation of
[`as.data.frame()`](https://rdrr.io/r/base/as.data.frame.html) but does
not provide the same sort of checks. It should be used with caution.

## Usage

``` r
quick_df(x = NULL)

empty_df()

quick_dfl(...)
```

## Arguments

- x:

  A list or `NULL` (see return)

- ...:

  Columns as `tag = value` (passed to
  [`list()`](https://rdrr.io/r/base/list.html))

## Value

A `data.frame`; if `x` is `NULL` a `data.frame` with `0` rows and `0`
columns is returned (similar to calling
[`data.frame()`](https://rdrr.io/r/base/data.frame.html) but faster).
`empty_df()` returns a `data.frame` with `0` rows and `0` columns.

## Examples

``` r
# unnamed will use make.names()
x <- list(1:10, letters[1:10])
quick_df(x)
#>     1 2
#> 1   1 a
#> 2   2 b
#> 3   3 c
#> 4   4 d
#> 5   5 e
#> 6   6 f
#> 7   7 g
#> 8   8 h
#> 9   9 i
#> 10 10 j

# named is preferred
names(x) <- c("numbers", "letters")
quick_df(x)
#>    numbers letters
#> 1        1       a
#> 2        2       b
#> 3        3       c
#> 4        4       d
#> 5        5       e
#> 6        6       f
#> 7        7       g
#> 8        8       h
#> 9        9       i
#> 10      10       j

# empty data.frame
empty_df() # or quick_df(NULL)
#> data frame with 0 columns and 0 rows
```
