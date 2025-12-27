# Collapse

Simple wrapper for concatenating strings

## Usage

``` r
collapse(..., sep = "")
```

## Arguments

- ...:

  one or more R objects, to be converted to character vectors.

- sep:

  a character string to separate the terms. Not
  [`NA_character_`](https://rdrr.io/r/base/NA.html).

## Value

A `character` vector of concatenated values. See
[base::paste](https://rdrr.io/r/base/paste.html) for more details.

## Examples

``` r
collapse(1:10)
#> [1] "12345678910"
collapse(list("a", b = 1:2))
#> [1] "a12"
collapse(quick_dfl(a = 1:3, b = 4:6), sep = "-")
#> [1] "1-2-3-4-5-6"
```
