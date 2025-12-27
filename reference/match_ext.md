# Value matching - Extensions

Non matching alternatives and supplementary functions.

## Usage

``` r
is_in(x, table)

is_out(x, table)

x %out% table

is_within(x, table)

x %wi% table

is_without(x, table)

x %wo% table

no_match(x, table)

any_match(x, table)
```

## Arguments

- x:

  vector or `NULL`: the values to be matched. [Long
  vectors](https://rdrr.io/r/base/LongVectors.html) are supported.

- table:

  vector or `NULL`: the values to be matched against. [Long
  vectors](https://rdrr.io/r/base/LongVectors.html) are not supported.

## Value

- `%out%`: A `logical` vector of equal length of `x`, `table`

- `%wo%`, `%wi%`: A vector of values of `x`

- `any_match()`, `no_match()`: `TRUE` or `FALSE`

- `is_in()`: see [`base::%in%()`](https://rdrr.io/r/base/match.html)

## Details

Contrast with [`base::match()`](https://rdrr.io/r/base/match.html),
[`base::intersect()`](https://rdrr.io/r/base/sets.html), and
[`base::%in%()`](https://rdrr.io/r/base/match.html) The functions of
`%wi%` and `%wo%` can be used in lieu of
[`base::intersect()`](https://rdrr.io/r/base/sets.html) and
[`base::setdiff()`](https://rdrr.io/r/base/sets.html). The primary
difference is that the base functions return only unique values, which
may not be a desired behavior.

## Examples

``` r
1:10 %in% c(1, 3, 5, 9)
#>  [1]  TRUE FALSE  TRUE FALSE  TRUE FALSE FALSE FALSE  TRUE FALSE
1:10 %out% c(1, 3, 5, 9)
#>  [1] FALSE  TRUE FALSE  TRUE FALSE  TRUE  TRUE  TRUE FALSE  TRUE
letters[1:5] %wo% letters[3:7]
#> [1] "a" "b"
letters[1:5] %wi% letters[3:7]
#> [1] "c" "d" "e"

# base functions only return unique values

          c(1:6, 7:2) %wo% c(3, 7, 12)  # -> keeps duplicates
#> [1] 1 2 4 5 6 6 5 4 2
  setdiff(c(1:6, 7:2),     c(3, 7, 12)) # -> unique values
#> [1] 1 2 4 5 6

          c(1:6, 7:2) %wi% c(3, 7, 12)  # -> keeps duplicates
#> [1] 3 7 3
intersect(c(1:6, 7:2),     c(3, 7, 12)) # -> unique values
#> [1] 3 7
```
