# Verbose

Simple verbose condition handling

## Usage

``` r
verbose(
  ...,
  .fill = getOption("fuj.verbose.fill"),
  .label = getOption("fuj.verbose.label"),
  .verbose = getOption("fuj.verbose", getOption("verbose"))
)

make_verbose(opt)
```

## Arguments

- ...:

  A message to display. When `...` is `NULL` (and only `NULL`), no
  message will display.

- .fill:

  When `TRUE`, each new line will be prefixed with the verbose label
  (controlled through `options("fuj.verbose.fill")`)

- .label:

  A label to prefix the message with (controlled through
  `options("fuj.verbose.label")`)

- .verbose:

  When `TRUE` (or is a function when returns `TRUE`) prints out the
  message.

- opt:

  An option to use in lieu of `fun.verbose`. Note:
  `options("fuj.verbose")` is temporarily set to
  `isTRUE(getOption(opt))` when the function is evaluate, but is reset
  to its original value on exit.

## Value

None, called for its side-effects. When conditions are met, will signal
a `verboseMessage` condition.

## Details

`verbose()` can be safely placed in scripts to signal additional message
conditions. `verbose()` can be controlled with `options("verbose")` (the
default) and an override, `options("fuj.verbose")`. The latter can be
set to a function whose result will be used for conditional evaluation.

`make_verbose()` allows for the creation of a custom verbose function.

## Examples

``` r
op <- options(verbose = FALSE)
verbose("will not show")

options(verbose = TRUE)
verbose("message printed")
#> verbose: message printed
verbose("multiple lines ", "will be ", "combined")
#> verbose: multiple lines will be combined
options(op)

op <- options(fuj.verbose = function() TRUE)
verbose("function will evaluate")
#> verbose: function will evaluate
verbose(NULL) # nothing
verbose(NULL, "something")
#> verbose: something
verbose(if (FALSE) {
"`if` returns `NULL` when not `TRUE`, which makes for additional control"
})
options(op)

# make your own verbose
verb <- make_verbose("fuj.foo.bar")
verb("will not show")
options(fuj.foo.bar = TRUE)
verb("will show")
#> verbose: will show
```
