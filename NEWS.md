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
