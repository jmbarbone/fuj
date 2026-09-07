# Require namespace

`require_namespace()` is ultimately a *check* which will produce an
error on the first package that is not available or meets version
requirements. Although this returns `TRUE`, it is not intended to be
used in a conditional statement. Future version may return
[`invisible()`](https://rdrr.io/r/base/invisible.html). For conditional
checks use `available_namespace()`, which will return a named logical
instead.

`is_namespace_available()` is an alias for `available_namespace()`.

## Usage

``` r
require_namespace(package, ...)

available_namespace(package, ...)

is_namespace_available(package, ...)
```

## Arguments

- package, ...:

  Package names

## Value

- `require_namespace()` `TRUE` (invisibly) if found; otherwise errors

&nbsp;

- `available_namespace()` A named `logical` vector of same length as
  input. Vector names are packages and values are `TRUE` if the package
  is available and meets the version requirement, otherwise `FALSE`.

## Details

Checks if a package is available and optionally meets a specific version
requirement.

## Examples

``` r
isTRUE(require_namespace("base")) # returns invisibly
#> [1] TRUE
try(require_namespace("1package")) # (using a purposefully bad name)
#> Error : <namespace_error> No package found called '1package'
require_namespace("base", "utils")
try(require_namespace("base >= 3.5", "utils > 4.0", "fuj == 0.0"))
#> Error : <fuj::namespace_version_error> Package version require not met: fuj is 0.2.2.9016 but ==0.0 is required.

# no error check
fuj0 <- if (!available_namespace("fuj == 0.0")) {
  "fuj 0.0 does not exist"
}
fuj0
#> [1] "fuj 0.0 does not exist"
```
