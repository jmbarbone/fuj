# Simple structures

Create simple structures

## Usage

``` r
struct(x, class, ..., .keep_attr = FALSE)
```

## Arguments

- x:

  An object; if `NULL`, coerced to
  [`list()`](https://rdrr.io/r/base/list.html)

- class:

  A vector of classes; can also be `NULL`

- ...:

  Named attributes to set to `x`; overwrites any attributes in `x` even
  if defined in `.keep_attr`

- .keep_attr:

  Control for keeping attributes from `x`: `TRUE` will retain all
  attributes from `x`; a character vector will pick out specifically
  defined attributes to retain; otherwise only attributes defined in
  `...` will be used

## Value

An object with class defined as `class` and attributes `...`

## Details

Unlike [`base::structure()`](https://rdrr.io/r/base/structure.html) this
does not provide additional checks for special names, performs no
[`base::storage.mode()`](https://rdrr.io/r/base/mode.html) conversions
for `factors` (`x` therefor has to be an `integer`), `attributes` from
`x` are not retained, and `class` is specified outside of other
attributes and assigned after
[`base::attributes()`](https://rdrr.io/r/base/attributes.html) is
called.

Essentially, this is just a wrapper for calling
[`base::attributes()`](https://rdrr.io/r/base/attributes.html) then
[`base::class()`](https://rdrr.io/r/base/class.html).

Note that [`base::structure()`](https://rdrr.io/r/base/structure.html)
provides a warning when the first argument is `NULL`. `struct()` does
not. The coercion from `NULL` to
[`list()`](https://rdrr.io/r/base/list.html) is done, and documented, in
[`base::attributes()`](https://rdrr.io/r/base/attributes.html).

## Examples

``` r
x <- list(a = 1, b = 2)
# structure() retains the $names attribute of x but struct() does not
structure(x, class = "data.frame", row.names = 1L)
#>   a b
#> 1 1 2
struct(x, "data.frame", row.names = 1L)
#>      
#> 1 1 2
struct(x, "data.frame", row.names = 1L, names = names(x))
#>   a b
#> 1 1 2

# structure() corrects entries for "factor" class
# but struct() demands the data to be an integer
structure(1, class = "factor", levels = "a")
#> [1] a
#> Levels: a
try(struct(1, "factor", levels = "a"))
#> Error in class(x) <- class : adding class "factor" to an invalid object
struct(1L, "factor", levels = "a")
#> [1] a
#> Levels: a

# When first argument is NULL -- attributes() coerces
try(structure(NULL))    # NULL, no call to attributes()
#> Warning: Calling 'structure(NULL, *)' is deprecated, as NULL cannot have attributes.
#>   Consider 'structure(list(), *)' instead.
#> NULL
struct(NULL, NULL)      # list(), without warning
#> list()
x <- NULL
attributes(x) <- NULL
x                       # NULL
#> NULL
attributes(x) <- list() # struct() always grabs ... into a list
x                       # list()
#> list()

# Due to the use of class() to assign class, you may experience some
# other differences between structure() and struct()
x <- structure(1, class = "integer")
y <- struct(1, "integer")
str(x)
#>  'integer' num 1
str(y)
#>  int 1

all.equal(x, y)
#> [1] "Attributes: < Modes: list, NULL >"                   
#> [2] "Attributes: < Lengths: 1, 0 >"                       
#> [3] "Attributes: < names for target but not for current >"
#> [4] "Attributes: < current is not list-like >"            
#> [5] "target is integer, current is numeric"               

# Be careful about carrying over attributes
x <- quick_df(list(a = 1:2, b = 3:4))
# returns empty data.frame
struct(x, "data.frame", new = 1)
#> NULL
#> <0 rows> (or 0-length row.names)

# safely changing names without breaking rownames
struct(x, "data.frame", names = c("c", "d")) # breaks
#> [1] c d
#> <0 rows> (or 0-length row.names)
struct(x, "data.frame", names = c("c", "d"), .keep_attr = TRUE)
#>   c d
#> 1 1 3
#> 2 2 4
struct(x, "data.frame", names = c("c", "d"), .keep_attr = "row.names")
#>   c d
#> 1 1 3
#> 2 2 4

# safely adds comments
struct(x, "data.frame", comment = "hi", .keep_attr = TRUE)
#>   a b
#> 1 1 3
#> 2 2 4
struct(x, "data.frame", comment = "hi", .keep_attr = c("names", "row.names"))
#>   a b
#> 1 1 3
#> 2 2 4

# assignment in ... overwrites attributes
struct(x, "data.frame", names = c("var1", "var2"), .keep_attr = TRUE)
#>   var1 var2
#> 1    1    3
#> 2    2    4
```
