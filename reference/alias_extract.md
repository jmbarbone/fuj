# Extract and replace aliases

Extract and replace aliases

## Value

See [base::Extract](https://rdrr.io/r/base/Extract.html)

## Examples

``` r
df <- quick_dfl(a = 1:5, b = 6:10)
#> Warning: quick_dfl(...) is deprecated in {fuj} 0.9.0 and will be removed in a future version.  Please use quick_df(list(...)), dataframe(...) instead
# alias of `[`
subset1(df, 1)
#>   a
#> 1 1
#> 2 2
#> 3 3
#> 4 4
#> 5 5
subset1(df, 1, )
#>   a b
#> 1 1 6
subset1(df, , 1)
#> [1] 1 2 3 4 5
subset1(df, , 1, drop = FALSE)
#>   a
#> 1 1
#> 2 2
#> 3 3
#> 4 4
#> 5 5

# alias of `[[`
subset2(df, 1)
#> [1] 1 2 3 4 5
subset2(df, 1, 2)
#> [1] 6

# alias of `$`
subset3(df, a)
#> [1] 1 2 3 4 5
subset3(df, "b")
#> [1]  6  7  8  9 10
subset3(df, "foo")
#> NULL

# alias of `[<-`
subassign1(df, "a", , 2)
#>   a  b
#> 1 1  6
#> 2 2  7
#> 3 3  8
#> 4 4  9
#> 5 5 10
#> a 2  2
```
