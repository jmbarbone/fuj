# New condition

Template for a new condition. See more at
[base::conditions](https://rdrr.io/r/base/conditions.html)

## Usage

``` r
new_condition(
  msg = "",
  class = NULL,
  call = NULL,
  type = c("error", "warning", "message", NA_character_),
  message = msg,
  pkg = package()
)
```

## Arguments

- msg, message:

  A message to print

- class:

  Character string of a single condition class

- call:

  A call expression

- type:

  The type (additional class) of condition: `error"`, `"warning"`,
  `"message"`, or `NA`, which is treated as `NULL`.

- pkg:

  Control or adding package name to condition. If `TRUE` will try to get
  the current package name (via `.packageName`) from, presumably, the
  developmental package. If `FALSE` or `NULL`, no package name is
  prepended to the condition class as a new class. Otherwise, a package
  can be explicitly set with a single length character.

## Value

A `condition` with the classes specified from `class` and `type`

## Details

The use of `.packageName` when `pkg = TRUE` may not be valid during
active development. When the attempt to retrieve the `.packageName`
object is unsuccessful, the error is quietly ignored. However, this
should be successful once the package is build and functions can then
utilize this created object.

## Examples

``` r
# empty condition
x <- new_condition("informative error message", class = "foo")
try(stop(x))
#> Error : <fooError> informative error message

# with pkg
x <- new_condition("msg", class = "foo", pkg = "bar")
# class contains multiple identifiers, including a "bar:fooError"
class(x)
#> [1] "fujCondition" "bar:fooError" "fooError"     "error"        "condition"   
# message contains package information at the end
try(stop(x))
#> Error : <fooError> msg
#> package:bar
```
