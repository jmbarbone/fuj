# File path operations

`is_path()` checks for either a `file_path` class or an `fs_path`, the
latter useful for the `fs` package.

`file_path()` is an alias for `fp()` and `is_file_path()` is an alias
for `is_path()`.

`set_file_ext()` changes the file extension of a file path, removing any
existing extension first. `file_ext<-()` serves as an alias.

`np()` will [normalize](https://rdrr.io/r/base/normalizePath.html) the
file path, always using `"/"` as the path separator, and without
signaling errors or warnings for non-existent paths.

Paths can be constructed with `/` and `+` methods:

    fp("here") / "subdir" + "ext"

This will create a file path for `here/subdir.ext`, with the extension
added after. **Note**: fp() can be replaced with np().

## Usage

``` r
fp(...)

np(...)

file_path(...)

norm_path(...)

is_path(x)

is_file_path(x)

set_file_ext(x, value, compression = TRUE)

file_ext(x, compression = TRUE) <- value
```

## Arguments

- ...:

  Path components, passed to
  [`base::file.path()`](https://rdrr.io/r/base/file.path.html)

- x:

  An object to test

- value:

  The new file extension. When `NULL`, removes the current extension

- compression:

  If `TRUE`, also removes common compression extensions

## Value

- `fp()`/`file_path()`: A `character` vector with a `"file_path"` class

- `np()`/`norm_path()`: A `character` vector with a `"file_path"` class,
  with [normalized](https://rdrr.io/r/base/normalizePath.html) paths

- `is_path()`/`is_file_path()`: A `TRUE` or `FALSE` value

- `set_file_ext()`/`file_ext<-()`: The file path with the updated
  extension

## Details

Lightweight file path functions

## Examples

``` r
fp("here")
#> here
fp("~/there")
#> ~/there
fp("back\\slash")
#> back/slash
fp("remove//extra\\\\slashes")
#> remove/extra/slashes
fp("a", c("b", "c"), "d")
#> a/b/d
#> a/c/d

# supports / and +
(x <- fp("here") / "subdir" + "ext")
#> here/subdir.ext

# change file extension
file_ext(x) <- "txt"
x
#> here/subdir.txt
file_ext(x) <- ".txt.gz"
x
#> here/subdir.txt.gz
file_ext(x) <- NULL
x
#> here/subdir
```
