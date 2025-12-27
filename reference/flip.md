# Flip

Flip an object.

## Usage

``` r
flip(x, ...)

# Default S3 method
flip(x, ...)

# S3 method for class 'matrix'
flip(x, by = c("rows", "columns"), keep_rownames = NULL, ...)

# S3 method for class 'data.frame'
flip(x, by = c("rows", "columns"), keep_rownames = NULL, ...)
```

## Arguments

- x:

  An object

- ...:

  Additional arguments passed to methods

- by:

  Flip by `"rows"` or `"columns"` (partial matches accepted)

- keep_rownames:

  Logical, if `TRUE` will not reset row names; `NULL`

## Value

A `vector` of values, equal length of `x` that is reversed or a
`data frame` with flipped rows/columns

## Examples

``` r
flip(letters[1:3])
#> [1] "c" "b" "a"
flip(seq.int(9, -9, by = -3))
#> [1] -9 -6 -3  0  3  6  9
flip(head(iris))
#>   Sepal.Length Sepal.Width Petal.Length Petal.Width Species
#> 1          5.4         3.9          1.7         0.4  setosa
#> 2          5.0         3.6          1.4         0.2  setosa
#> 3          4.6         3.1          1.5         0.2  setosa
#> 4          4.7         3.2          1.3         0.2  setosa
#> 5          4.9         3.0          1.4         0.2  setosa
#> 6          5.1         3.5          1.4         0.2  setosa
flip(head(iris), keep_rownames = TRUE)
#>   Sepal.Length Sepal.Width Petal.Length Petal.Width Species
#> 6          5.4         3.9          1.7         0.4  setosa
#> 5          5.0         3.6          1.4         0.2  setosa
#> 4          4.6         3.1          1.5         0.2  setosa
#> 3          4.7         3.2          1.3         0.2  setosa
#> 2          4.9         3.0          1.4         0.2  setosa
#> 1          5.1         3.5          1.4         0.2  setosa
flip(head(iris), by = "col")
#>   Species Petal.Width Petal.Length Sepal.Width Sepal.Length
#> 1  setosa         0.2          1.4         3.5          5.1
#> 2  setosa         0.2          1.4         3.0          4.9
#> 3  setosa         0.2          1.3         3.2          4.7
#> 4  setosa         0.2          1.5         3.1          4.6
#> 5  setosa         0.2          1.4         3.6          5.0
#> 6  setosa         0.4          1.7         3.9          5.4
```
