
<!-- README.md is generated from README.Rmd. Please edit that file -->

# fuj <a href='https://github.com/jmbarbone/fuj'><img src='man/figures/logo.png' align="right" height="139" /></a>

<!-- badges: start -->

[![R-CMD-check](https://github.com/jmbarbone/fuj/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/jmbarbone/fuj/actions/workflows/R-CMD-check.yaml)
[![Codecov test
coverage](https://codecov.io/gh/jmbarbone/fuj/branch/main/graph/badge.svg)](https://app.codecov.io/gh/jmbarbone/fuj?branch=main)
[![CRAN
status](https://www.r-pkg.org/badges/version/fuj)](https://CRAN.R-project.org/package=fuj)
<!-- badges: end -->

The goal of `{fuj}` is to provide low level tools for other packages by
[Jordan](https://github.com/jmbarbone).

## Installation

Install `{fuj}` from CRAN with:

``` r
install.packages("vctrs")
```

Alternatively, you can install the development version of `{fuj}`
[GitHub](https://github.com/) with:

    # install.packages("devtools")
    devtools::install_github("jmbarbone/fuj")

## Example

``` r
library(fuj)
```

Quicker `data.frame`s:

``` r
quick_df(list(a = 1:5, b = letters[1:5]))
#>   a b
#> 1 1 a
#> 2 2 b
#> 3 3 c
#> 4 4 d
#> 5 5 e
quick_dfl(a = 1:3, b = list(1:5, 6:10, 11:15))
#>   a                  b
#> 1 1      1, 2, 3, 4, 5
#> 2 2     6, 7, 8, 9, 10
#> 3 3 11, 12, 13, 14, 15
```

More extensions:

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
