# Exact attributes

Get the exact attributes of an object

## Usage

``` r
exattr(x, which)

x %attr% which
```

## Arguments

- x:

  an object whose attributes are to be accessed.

- which:

  a non-empty character string specifying which attribute is to be
  accessed.

## Value

See [base::attr](https://rdrr.io/r/base/attr.html)

## Examples

``` r
foo <- struct(list(), "foo", aa = TRUE)
  attr(foo, "a")  # TRUE : partial match successful
#> [1] TRUE
exattr(foo, "a")  # NULL : partial match failed
#> NULL
exattr(foo, "aa") # TRUE : exact match
#> [1] TRUE
```
