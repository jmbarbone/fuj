# messages ----------------------------------------------------------------

# nolint next: object_name_linter.
verbose_message <- function(message, call = NULL) {
  do_verbose <- getOption("fuj.verbose", getOption("verbose"))
  if (is.function(do_verbose)) {
    do_verbose <- do_verbose()
  }

  if (!isTRUE(do_verbose)) {
    # returns a silent condition, I think
    bare_condition("fuj:verbose_condition")
  } else {
    new_condition(
      message = message,
      class = "verbose",
      type = "message",
      package = "fuj",
      call = call
    )
  }
}

# errors ------------------------------------------------------------------

input_error <- function(message = "invalid input") {
  new_condition(
    message = message,
    class = "input",
    type = "error",
    package = "fuj"
  )
}

value_error <- function(message = "invalid value") {
  new_condition(
    message = message,
    class = "value",
    type = "error",
    package = "fuj"
  )
}

# NOTE currently not being used
class_error <- function(message = "invalid class", ...) {
  new_condition(
    message = c(message, ...),
    class = "class",
    type = "error",
    package = "fuj"
  )
}

type_error <- function(message = "invalid type", ...) {
  new_condition(
    message = c(message, ...),
    class = "type",
    type = "error",
    package = "fuj"
  )
}

interactive_error <- function(
  message = "must be used in an interactive session",
  ...
) {
  new_condition(
    message = c(message, ...),
    class = "interactive",
    type = "error",
    package = "fuj"
  )
}

namespace_error <- function(package) {
  new_condition(
    message = sprintf("No package found called '%s'", as.character(package)),
    class = list("namespace", I("packageNotFoundError")),
    type = "error"
  )
}

# warnings ----------------------------------------------------------------

development_warning <- function(...) {
  new_condition(
    message = c(...),
    class = "development",
    type = "warning",
    package = "fuj"
  )
}

deprecated_warning <- function(...) {
  new_condition(
    message = c(...),
    class = list("deprecated", I("deprecatedWarning")),
    type = "warning",
    package = "fuj"
  )
}

dots_warning <- function(...) {
  new_condition(
    message = c(...),
    class = "dots",
    type = "warning",
    package = "fuj"
  )
}

# conditions --------------------------------------------------------------

# NOTE This might be subject to change.
inform <- function(..., .bare = FALSE, .class = NULL) {
  withRestarts(
    expr = {
      info <- info_condition(..., .bare = .bare, .class = .class)
      signalCondition(info)
      cat(conditionMessage(info), "\n", sep = "")
    },
    muffle_condition = function(cnd) NULL
  )
}

suppress_info <- function(expr, classes = "info_condition") {
  withCallingHandlers(
    expr,
    info_condition = function(cnd) {
      if (inherits(cnd, classes)) {
        tryInvokeRestart("muffle_condition")
      }
    }
  )
}

info_condition <- function(..., .bare = FALSE, .class = NULL) {
  cond <- new_condition(
    message = c(...),
    class = list("info", .class),
    type = "condition",
    package = "fuj"
  )
  if (.bare) {
    cond$message <- c(...)
  }
  cond
}

bare_condition <- function(class = NULL) {
  structure(
    list(message = NULL, call = NULL),
    class = unique(c(class, "condition"))
  )
}
