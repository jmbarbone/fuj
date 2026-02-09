# New condition

Template for a new condition. See more at
[base::conditions](https://rdrr.io/r/base/conditions.html)

## Usage

``` r
new_condition(
  message = "",
  class = "fuj_condition",
  type = c("condition", "error", "warning", "message"),
  ...,
  call = NULL,
  package = find_package(),
  msg,
  pkg
)
```

## Arguments

- message:

  A message to print

- class:

  Character string of a single condition class. If `class` does not end
  with the value used in `class`, the suffix is appended with an
  underscore (`_`). This can be ignored if passing `class` as an `AsIs`
  vector (i.e., `I("my_class")`).

- type:

  The type (additional class) of condition: `error"`, `"warning"`,
  `"message"`, or `NA`, which is treated as `NULL`.

- ...:

  Ignored

- call:

  A call expression

- package:

  Control or adding package name to condition. If `TRUE` will try to get
  the current package name (via `.packageName`) from, presumably, the
  developmental package. If `FALSE` or `NULL`, no package name is
  prepended to the condition class as a new class. Otherwise, a package
  can be explicitly set with a single length character.

- msg:

  Deprecated, see `message`

- pkg:

  Deprecated, see `package`

## Value

A `condition` with the classes specified from `class` and `type`

## Details

The use of `.packageName` when `package = TRUE` may not be valid during
active development. When the attempt to retrieve the `.packageName`
object is unsuccessful, the error is quietly ignored. However, this
should be successful once the package is build and functions can then
utilize this created object.

## Examples

``` r
# empty condition
x <- new_condition(
  "informative error message",
  class = "foo",
  type = "error"
 )
try(stop(x))
#> Error : <foo_error> informative error message

# with pkg
x <- new_condition("msg", class = "foo", type = "error", package = "bar")
# class contains multiple identifiers, including a "bar:fooError"
class(x)
#> [1] "bar:foo_error" "foo_error"     "error"         "fuj_condition"
#> [5] "condition"    
# message contains package information at the end
try(stop(x))
#> Error : <foo_error> msg
#> package:bar
```
