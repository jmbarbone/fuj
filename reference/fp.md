# File path

`is_path()` checks for either a `file_path` class or an `fs_path`, the
latter useful for the `fs` package.

`file_path()` is an alias for `fp()` and `is_file_path()` is an alias
for `is_path()`.

## Usage

``` r
fp(...)

file_path(...)

is_path(x)

is_file_path(x)
```

## Arguments

- ...:

  Path components, passed to
  [`file.path()`](https://rdrr.io/r/base/file.path.html)

- x:

  An object to test

## Value

- `fp()`/`file_path()`: A `character` vector of the normalized path with
  a `"file_path"` class

- `is_path()`/`is_file_path()`: A `TRUE` or `FALSE` value

## Details

Lightweight file path functions

## Examples

``` r
fp("here")
#> here
fp("~/there")
#> /home/runner/there
fp("back\\slash")
#> back/slash
fp("remove//extra\\\\slashes")
#> remove/extra/slashes
fp("a", c("b", "c"), "d")
#> a/b/d
#> a/c/d
```
