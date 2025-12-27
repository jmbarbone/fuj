# Set names

Sets or removes names

## Usage

``` r
set_names(x, nm = x)

remove_names(x)

x %names% nm

is_named(x, zero_ok = TRUE)
```

## Arguments

- x:

  A vector of values

- nm:

  A vector of names

- zero_ok:

  If `TRUE` allows use of `""` as a *special* name

## Value

`x` with `nm` values assigned to names (if `x` is `NULL`, `NULL` is
returned)

## Examples

``` r
set_names(1:5)
#> 1 2 3 4 5 
#> 1 2 3 4 5 
set_names(1:5, c("a", "b", "c", "d", "e"))
#> a b c d e 
#> 1 2 3 4 5 

x <- c(a = 1, b = 2)
remove_names(x)
#> [1] 1 2
x %names% c("c", "d")
#> c d 
#> 1 2 
is_named(x)
#> [1] TRUE
```
