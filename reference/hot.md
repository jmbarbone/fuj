# Hold or Toss

Hold or Toss

## Usage

``` r
hold(x, i, na = c("drop", "keep"))

toss(x, i, na = c("keep", "drop"))
```

## Arguments

- x:

  A vector of values

- i:

  An indication of which subset values to action. This can be a logical
  vector, an integer vector, or a function that takes `x` as an argument
  and returns a logical or integer vector

- na:

  How to handle `NA` values in when `p` is a logical vector, or a
  function that returns a logical vector. `hold()` defaults to dropping
  `NA` values, while `toss()` defaults to keeping `NA` values. When `p`
  is an integer vector, `NA` values are always dropped.

## Value

- `hold()` **retains** values in `x` matched against `i`

- `toss()` **removes** values in `x` matched against `i`

## Examples

``` r
x <- c(1, NA, 3, 4, Inf, 6)
twos <- function(x) x %% 2 == 0
hold(x, twos) # 4, 6
#> [1] 4 6
toss(x, twos) # 1, 3, NA, Inf
#> [1]   1  NA   3 Inf

hold(x, twos, na = "keep") # NA, 4, Inf, 6
#> [1]  NA   4 Inf   6
toss(x, twos, na = "drop") # 1, 3
#> [1] 1 3

i <- c(1:3, NA)
x <- letters[1:5]
hold(x, i)
#> [1] "a" "b" "c"
toss(x, i)
#> [1] "d" "e"
```
