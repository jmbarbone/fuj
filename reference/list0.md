# Listing for dots

Tries to not complain about empty arguments

## Usage

``` r
list0(...)

lst(...)
```

## Arguments

- ...:

  Arguments to collect in a list

## Value

A `list` of `...`

## Examples

``` r
try(list(1, ))
#> Error in list(1, ) : argument 2 is empty
list0(1, )
#> [[1]]
#> [1] 1
#> 
try(list(a = 1, ))
#> Error in list(a = 1, ) : argument 2 is empty
list0(a = 1, )
#> $a
#> [1] 1
#> 
try(list(a = 1, , c = 3, ))
#> Error in list(a = 1, , c = 3, ) : argument 2 is empty
list0(a = 1, , c = 3, )
#> $a
#> [1] 1
#> 
#> $c
#> [1] 3
#> 
```
