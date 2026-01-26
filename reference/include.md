# Include exports in Search Path

`include()` checks whether or not the namespace has been loaded to the
[`base::search()`](https://rdrr.io/r/base/search.html) path. It uses the
naming convention `include:{package}` to denote the differences from
loading via [`base::library()`](https://rdrr.io/r/base/library.html) or
[`base::require()`](https://rdrr.io/r/base/library.html). When `exports`
is `NULL`, the environment is detached from the search path if found.
When `exports` is not `NULL`,

**Note:** This function has the specific purpose of affecting the search
path. Use `options(fuj.verbose = TRUE)` or `options(verbose = TRUE)` for
more information.

## Usage

``` r
include(package, exports = NULL, lib = .libPaths(), pos = 2L, warn = NULL)
```

## Arguments

- package:

  A package name. This can be given as a
  [name](https://rdrr.io/r/base/name.html) or a character string. See
  section `package` class handling.

- exports:

  A character vector of exports. When named, these exports will be
  aliases as such.

- lib:

  See `lib.loc` in
  [`base::loadNamespace()`](https://rdrr.io/r/base/ns-load.html).

- pos:

  An integer specifying the position in the
  [`search()`](https://rdrr.io/r/base/search.html) path to attach the
  new environment.

- warn:

  See `warn.conflicts` in
  [`base::attach()`](https://rdrr.io/r/base/attach.html), generally. The
  default `NULL` converts all `messages`s with masking errors to
  `verboseMessage`s, `TRUE` converts to `includeConflictsWarning`
  messages, `NA` uses `packageStartupMessages`, and `FALSE` silently
  ignores conflicts.

## Value

The attached environment, invisibly.

## Details

Include (attach) a package and specific exports to Search Path

## `package` class handling

When `package` is a [name](https://rdrr.io/r/base/name.html) or
[AsIs](https://rdrr.io/r/base/AsIs.html), assumed an installed package.
When `package` is a file path (via
[`is_path()`](https://jmbarbone.github.io/fuj/reference/fp.md)) then
`package` is assumed a file path. When just a string, a viable path is
checked first; if it doesn't exist, then it is assumed a package.

When the package is [`source()`](https://rdrr.io/r/base/source.html)'d
the name of the environment defaults to the base name of `x` (file
extension removed). However, if the object `.AttachName` is found in the
sourced file, then that is used as the environment name for the
[`search()`](https://rdrr.io/r/base/search.html) path.

**Note:** `include()` won't try to *attach* an environment a second
time, however, when `package` is a path, it must be
[`source()`](https://rdrr.io/r/base/source.html)ed each time to check
for the `.AttachName` object. If there are any side effects, they will
be repeated each time `include(path)` is called.

## Examples

``` r
# include(package) will ensure that the entire package is attached
include(fuj)
head(ls("include:fuj"), 20)
#>  [1] "%::%"            "%:::%"           "%attr%"          "%colons%"       
#>  [5] "%len%"           "%names%"         "%out%"           "%wi%"           
#>  [9] "%wo%"            "%||%"            "%|||%"           "+.file_path"    
#> [13] "/.file_path"     "add"             "any_match"       "attach2"        
#> [17] "attach_warn"     "check_conflicts" "collapse"        "colons_check"   
detach("include:fuj", character.only = TRUE)

# include a single export
include(fuj, "collapse")

# include multiple exports, and alias
include(fuj, c(
  no_names = "remove_names",
  match_any = "any_match"
))

# include an export where the alias has a warn conflict
include(fuj, c(attr = "exattr"))

# note that all 4 exports are included
ls("include:fuj")
#> [1] "attr"      "collapse"  "match_any" "no_names" 

# all exports are the same
identical(collapse, fuj::collapse)
#> [1] TRUE
identical(no_names, fuj::remove_names)
#> [1] TRUE
identical(match_any, fuj::any_match)
#> [1] TRUE
identical(attr, fuj::exattr)
#> [1] TRUE
```
