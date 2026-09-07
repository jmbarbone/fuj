# Default Conditions

Default Conditions

## Usage

``` r
message_condition(..., class = NULL)

msg(..., class = NULL)

verbose_message(message, call = NULL)

error_condition(..., class = NULL)

err(..., class = NULL)

input_error(message = "invalid input", ...)

value_error(message = "invalid value", ...)

class_error(message = "invalid class", ...)

type_error(message = "invalid type", ...)

interactive_error(message = "must be used in an interactive session", ...)

namespace_error(package)

development_error(..., package = find_package())

defunct_error(..., package = find_package())

internal_error(
  message = c(sprintf("An internal error occurred in '%s'.", package),
    "  Please report this to the package maintainer."),
  ...,
  package = find_package()
)

warning_condition(..., class = NULL)

wrn(..., class = NULL)

input_warning(message = "invalid input", ...)

value_warning(message = "invalid value", ...)

class_warning(message = "invalid class", ...)

interactive_warning(message = "must be used in an interactive session", ...)

namespace_warning(package)

development_warning(..., package = find_package())

internal_warning(
  message = c(sprintf("An internal error occurred in '%s'.", package),
    "  Please report this to the package maintainer."),
  ...,
  package = find_package()
)

deprecated_warning(..., package = find_package())
```

## Arguments

- class:

  A class names for the condition; `message_condition()`,
  `warning_condition()`, `error_condition()` will always use classes
  `"message"`, `"warning"`, `"error"`, respectively.

- message, ...:

  A character vector of message components; `message` is used for
  anything with a default message.

- call:

  The call that generated the condition

- package:

  Package name. Default will attempt to find the package by the calling
  environment, which must return a character value. This will also be
  passed to the `package` argument in
  [`new_condition()`](https://jmbarbone.github.io/fuj/reference/new_condition.md)
