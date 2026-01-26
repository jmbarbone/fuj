# messages ----------------------------------------------------------------

# nolint next: object_name_linter.
verbose_message <- function(msg, call = NULL) {
  do_verbose <- getOption("fuj.verbose", getOption("verbose"))
  if (is.function(do_verbose)) {
    do_verbose <- do_verbose()
  }

  if (!isTRUE(do_verbose)) {
    # returns a silent condition, I think
    bare_condition("fuj:verbose_condition")
  } else {
    new_condition(
      msg = msg,
      class = "verbose_message",
      type = "message",
      package = "fuj",
      call = call
    )
  }
}

# errors ------------------------------------------------------------------

input_error <- function(msg = "invalid input") {
  new_condition(
    msg = msg,
    class = "input_error",
    type = "error",
    package = "fuj"
  )
}

value_error <- function(msg = "invalid value") {
  new_condition(
    msg = msg,
    class = "value_error",
    type = "error",
    package = "fuj"
  )
}

# NOTE currently not being used
class_error <- function(msg = "invalid class", ...) {
  new_condition(
    msg = c(msg, ...),
    class = "class_error",
    type = "error",
    package = "fuj"
  )
}

type_error <- function(msg = "invalid type", ...) {
  new_condition(
    msg = c(msg, ...),
    class = "type_error",
    type = "error",
    package = "fuj"
  )
}

interactive_error <- function(
  msg = "must be used in an interactive session",
  ...
) {
  new_condition(
    msg = c(msg, ...),
    class = "interactive_error",
    type = "error",
    package = "fuj"
  )
}

namespace_error <- function(package) {
  new_condition(
    msg = sprintf("No package found called '%s'", as.character(package)),
    class = c("namespace_error", "packageNotFoundError"),
    type = "error"
  )
}

# warnings ----------------------------------------------------------------

development_warning <- function(...) {
  new_condition(
    msg = c(...),
    class = "development_warning",
    type = "warning",
    package = "fuj"
  )
}

deprecated_warning <- function(...) {
  new_condition(
    msg = c(...),
    class = c("deprecated_warning", "deprecatedWarning"),
    type = "warning",
    package = "fuj"
  )
}


# conditions --------------------------------------------------------------

bare_condition <- function(class = NULL) {
  structure(
    list(message = NULL, call = NULL),
    class = unique(c(class, "condition"))
  )
}
