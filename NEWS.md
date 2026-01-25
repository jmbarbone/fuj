# fuj (development version)

* `quick_df()` no longer allows `NULL` values in the input list [#81](https://github.com/jmbarbone/fuj/issues/81)
* `quick_df()` is now a little faster [#91](https://github.com/jmbarbone/fuj/issues/91)
* `quick_dfl()` is now deprecated [#91](https://github.com/jmbarbone/fuj/issues/91)
* `list()` is now a little faster [#91](https://github.com/jmbarbone/fuj/issues/91)
* `list0()`'s functionality to ignore empty inputs can be disabled if `options(fuj.list.active = FALSE)` before `{fuj}` is loaded [#91](https://github.com/jmbarbone/fuj/issues/91)
* `vap` family functions added [#83](https://github.com/jmbarbone/fuj/issues/83)
  * `vaps` are vector apply functions, with certain presets to assist with common cases
  * all `vap` functions have type-stable variants:

The below table shows inputs for `vap` functions and how they behave with the provided functions (`f`).
Arguments to `f())` can use any name.

  | `vap` function     | `f` args     |
  |:-------------------|:-------------|
  | `vap(x, f)`        | `f(x)`       |
  | `vap2(x, y, f)`    | `f(x, y)`    |
  | `vap3(x, y, z, f)` | `f(x, y, z)` |
  | `vapi(x, f)`       | `f(x, i)`    |
  | `vapp(p, f)`       | `f(...)`     |
  
_Note_: `vapi()` uses either the index or names of `x` as the second argument to `f`.

Each `vap` function comes with the following type variants:
  
  | Function   | Output Type    | Conversion
  |:-----------|----------------|----------------|
  | `*_chr()`  | character      | `as.vector(_, "character")` |
  | `*_dbl()`  | double/numeric | `as.vector(_, "double")`    |
  | `*_int()`  | integer        | `as.vector(_, "integer")`   |
  | `*_lgl()`  | logical        | `as.vector(_, "logical")`   |
  | `*_raw()`  | raw            | `as.vector(_, "raw")`       |
  | `*_cpl()`  | complex        | `as.vector(_, "complex")`   |
  | `*_date()` | Date           | `as.Date(as.vector(_, "double"), origin = "1970-01-01")` |
  | `*_dttm()` | POSIXct        | `as.POSIXct(as.vector(_, "double"), origin = "1970-01-01", tz = "UTC")` |
  
_Note_: these variants do not perform _checks_ on output results, but rather coerce the output to the specified type.
  

# fuj 0.2.2

* `require_namespace()` now produces a more reasonable error when specifying a version [#63](https://github.com/jmbarbone/fuj/issues/63)
* adds `yes_no()` prompting [#64](https://github.com/jmbarbone/fuj/issues/64)
* adds internal `package()` utility as the default for `new_condition(pkg = package())` [#67](https://github.com/jmbarbone/fuj/issues/67)
* `new_condition()` now allows `type = "message"` [#74](https://github.com/jmbarbone/fuj/issues/74)
* workflows updated
* `quick_df(list())` now works [#72](https://github.com/jmbarbone/fuj/issues/72)
* removes tests for `struct()` [#78](https://github.com/jmbarbone/fuj/issues/78)

# fuj 0.2.1

## Fixes

* `lst()` again works with `NA_character_` [#60](https://github.com/jmbarbone/fuj/issues/60)

# fuj 0.2.0

## Fixes

* `%wi%` no longer drops duplicated in `x` [#44](https://github.com/jmbarbone/fuj/issues/44)
* `list0()` now works better with some edge cases [#55](https://github.com/jmbarbone/fuj/issues/55)

## New features

* `fp()` added for creating file path objects with `is_path()` as a means of checking for the class; `file_path()` and `is_file_path()` exported as aliases, respectively [#55](https://github.com/jmbarbone/fuj/issues/55)
* `include()` added as a means of partially attaching a package with specific exports [#49](https://github.com/jmbarbone/fuj/issues/49)
* `op.fuj`, a named list of default options for `{fuj}` is now exported
* multiple improvements for `verbose()` [#50](https://github.com/jmbarbone/fuj/pull/50)
  * `verbose()` has additional options for controlling the message output [#36](https://github.com/jmbarbone/fuj/issues/36)
    * `.label` can be set to a string to prepend to the message (defaults to `"[verbose]"`)
    * `.fill` can be set to repeat `.label` on each line of the message (defaults to `FALSE`)
    * `.verbose` can be set to `TRUE` to print the message rather than relying on `options()`
  * `verbose()` prints prepended with `"verbose "` instead of `"[verbose] "` [#42](https://github.com/jmbarbone/fuj/issues/42)
  * `make_verbose()` is included to create a verbose function that will be triggered with a configured option, rather than the default `getOption("fuj.verbose", getOption("verbose"))` pattern.
This can be used to define your own custom verbose function:
* `lst()` exported as an alias for `list0()`

```r
library(fuj)
options(fuj.verbose = FALSE)
verbose("will not show")

options(my.verbose = TRUE)
my_verbose <- make_verbose("my.verbose")
my_verbose("will show")
#> [verbose] will show
```

## Internals

* `%||%` is now copied from `{base}` when available (**R** versions >= 4.4) [#35](https://github.com/jmbarbone/fuj/issues/35)
* additional local testing for os version
* `{covr}` dropped as a `suggest` dependency
* `require_namespace()` now allows for version requirements (e.g., `require_namespace("fuj>=0.1.4")`).  When the version requirement is not met, an error of class `namespaceVersionError` is returned [#41](https://github.com/jmbarbone/fuj/issues/41)
* `simpleError`s converted to custom errors [#43](https://github.com/jmbarbone/fuj/issues/43)

# fuj 0.1.4

* adds `%::%` and `%:::%` (which now aliases `%colons$`) or retrieving exported and non-exported values from namespaces [#31](https://github.com/jmbarbone/fuj/issues/31)
* adds `verbose()` for conditional message printing [#29](https://github.com/jmbarbone/fuj/issues/29)
* GitHub workflow added to maintain version bumps on merge [`jmbarbone/actions/r-check-version`](https://github.com/jmbarbone/actions/blob/main/examples/r-check-version.yaml)

# fuj 0.1.3

* `list0()` now accepts `named` arguments in `...` [#25](https://github.com/jmbarbone/fuj/issues/25)

# fuj 0.1.2

* `new_condition()` gains a `pkg` argument to control for prepending a package name to the condition call.  The default value of `TRUE` will try to find the `.packageName` object from your package. Change the default setting of `pkg` to prevent this addition. [#12](https://github.com/jmbarbone/fuj/issues/12)
* `require_namespace()` can now accept multiple namespaces.  The first namespace not found will throw an error [#14](https://github.com/jmbarbone/fuj/issues/14)
* `list0()` now correctly throws valid errors [#19](https://github.com/jmbarbone/fuj/issues/19)
* typo fixed in README [#20](https://github.com/jmbarbone/fuj/issues/20)

# fuj 0.1.1

* `subset2` is now exported as an alias of `[[` and `subset3` is added as an alias of `$` [#3](https://github.com/jmbarbone/fuj/issues/3)
* improved documentation for aliases [#3](https://github.com/jmbarbone/fuj/issues/3)
* improved test coverage -- no longer skipping any functions [#7](https://github.com/jmbarbone/fuj/issues/7)

# fuj 0.1.0

* First release
* Added a `NEWS.md` file to track changes to the package.
