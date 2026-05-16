
<!-- README.md is generated from README.Rmd. Please edit that file -->

# fuj <a href='https://github.com/jmbarbone/fuj'><img src='man/figures/logo.png' align="right" height="139" /></a>

<!-- badges: start -->

[![R-CMD-check](https://github.com/jmbarbone/fuj/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/jmbarbone/fuj/actions/workflows/R-CMD-check.yaml)
[![Codecov test
coverage](https://codecov.io/gh/jmbarbone/fuj/branch/main/graph/badge.svg)](https://app.codecov.io/gh/jmbarbone/fuj?branch=main)
[![CRAN
status](https://www.r-pkg.org/badges/version/fuj)](https://CRAN.R-project.org/package=fuj)
[![Codecov test
coverage](https://codecov.io/gh/jmbarbone/fuj/graph/badge.svg)](https://app.codecov.io/gh/jmbarbone/fuj)
<!-- badges: end -->

The goal of `{fuj}` is to provide low level tools for other packages by
[Jordan](https://github.com/jmbarbone) (i.e., *Functions and Utilities
for Jordan*). This package is developed with restrictions to just *base*
**R**, which aids in stability and reduces frivolous errors/warnings
from dependencies. Some of these functions may exist in other, more
well-known packages in one form or another.

## Installation

Install `{fuj}` from CRAN with:

``` r
install.packages("fuj")
```

Alternatively, you can install the development version of `{fuj}`
[GitHub](https://github.com/) with:

    # install.packages("devtools")
    devtools::install_github("jmbarbone/fuj")

## Example

``` r
library(fuj)
```

Quicker, simple `data.frame`s:

``` r
quick_df(list(a = 1:5, b = letters[1:5]))
#>   a b
#> 1 1 a
#> 2 2 b
#> 3 3 c
#> 4 4 d
#> 5 5 e
```

Matching extensions:

``` r
1:10 %out% c(1, 3, 5, 9)       # opposite of %in% 
#>  [1] FALSE  TRUE FALSE  TRUE FALSE  TRUE  TRUE  TRUE FALSE  TRUE
letters[1:5] %wo% letters[3:7]
#> [1] "a" "b"
letters[1:5] %wi% letters[3:7]
#> [1] "c" "d" "e"
```

Simple structures:

``` r
struct(list(a = 1, b = 2), class = "foo", c = 3, d = 3)
#> [[1]]
#> [1] 1
#> 
#> [[2]]
#> [1] 2
#> 
#> attr(,"c")
#> [1] 3
#> attr(,"d")
#> [1] 3
#> attr(,"class")
#> [1] "foo"
```

Suppress messages and warnings:

``` r
foo <- function(...) { message(paste0(list(...))) ; c(...) }
muffle(foo(1:3))
#> [1] 1 2 3
sapply(1:3, muffle(fun = foo))
#> [1] 1 2 3

x <- list("a", 1)
wuffle(as.integer(x))
#> [1] NA  1
sapply(x, wuffle(fun = as.integer))
#> [1] NA  1
```

Build conditions:

``` r
example_error <- function(x = "This is an example", ...) {
  new_condition(
    message = paste0(x, ..., collapse = ""),
    class = "example_error",
    type = "error"
  )
}

foo <- function(x) {
  switch(
    x,
    stop(example_error()),
    stop(example_error("Another message"))
  )
}

try(foo(1))
#> Error : <error> This is an example
try(foo(2))
#> Error : <error> Another message
```

Vector apply functions:

``` r
vap_int(1:5, \(x) x^2)
#> [1]  1  4  9 16 25
vap_chr(1:5, \(x) paste0("Number ", x))
#> [1] "Number 1" "Number 2" "Number 3" "Number 4" "Number 5"

vapp_date(
  list(year = 2020:2022, month = 1:3, day = 15:17),
  \(year, month, day) as.Date(paste(year, month, day, sep = "-"))
)
#> [1] "2020-01-15" "2021-02-16" "2022-03-17"
```
