# Require namespace

Require namespace

## Usage

``` r
require_namespace(package, ...)
```

## Arguments

- package, ...:

  Package names

## Value

`TRUE` (invisibly) if found; otherwise errors

## Examples

``` r
isTRUE(require_namespace("base")) # returns invisibly
#> [1] TRUE
try(require_namespace("1package")) # (using a purposefully bad name)
#> Error : <fuj:packageNotFoundError> No package found called '1package'
#> package:fuj
require_namespace("base", "utils")
try(require_namespace("base>=3.5", "utils>4.0", "fuj==10.0"))
#> Error : <fuj:namespace_error> Package version requirement not meet:
#> fuj: 0.2.2.9005 == 10.0
#> package:fuj
```
