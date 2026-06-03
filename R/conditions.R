error_to_warning <- function(fun) {
  do.call(substitute, list(body(fun), list(error = warning)))
  body(fun) <- str2expression(gsub(
    "\"error\"",
    "\"warning\"",
    deparse(body(fun)),
    fixed = TRUE
  ))
  fun
}

#' Default Conditions
#'
#' @name conditions
#' @param message,... A character vector of message components; `message` is
#'   used for anything with a default message.
#' @param package Package name.  Default will attempt to find the package by
#'   the calling environment, which must return a character value.  This will
#'   also be passed to the `package` argument in [fuj::new_condition()]
#' @param call The call that generated the condition
NULL

# messages ----------------------------------------------------------------

#' @export
#' @rdname conditions
msg <- function(...) {
  new_condition(
    message = c(...),
    class = "message",
    type = "message",
    package = NULL
  )
}

#' @export
#' @rdname conditions
verbose_message <- function(message, call = NULL) {
  do_verbose <- getOption("fuj.verbose", getOption("verbose"))
  if (is.function(do_verbose)) {
    do_verbose <- do_verbose()
  }

  if (!isTRUE(do_verbose)) {
    # returns a silent condition, I think
    bare_condition("verbose_condition")
  } else {
    new_condition(
      message = message,
      class = "verbose",
      type = "message",
      call = call,
      package = NULL
    )
  }
}

# errors ------------------------------------------------------------------

#' @export
#' @rdname conditions
err <- function(...) {
  new_condition(
    message = c(...),
    type = "error",
    package = NULL
  )
}

#' @export
#' @rdname conditions
input_error <- function(message = "invalid input", ...) {
  new_condition(
    message = c(message, ...),
    class = "input",
    type = "error",
    package = NULL
  )
}

value_error <- function(message = "invalid value", ...) {
  new_condition(
    message = c(message, ...),
    class = "value",
    type = "error"
  )
}

#' @export
#' @rdname conditions
class_error <- function(message = "invalid class", ...) {
  new_condition(
    message = c(message, ...),
    class = "class",
    type = "error",
    package = NULL
  )
}

#' @export
#' @rdname conditions
type_error <- function(message = "invalid type", ...) {
  new_condition(
    message = c(message, ...),
    class = "type",
    type = "error",
    package = NULL
  )
}

#' @export
#' @rdname conditions
interactive_error <- function(
  message = "must be used in an interactive session",
  ...
) {
  new_condition(
    message = c(message, ...),
    class = "interactive",
    type = "error",
    package = NULL
  )
}

#' @export
#' @rdname conditions
namespace_error <- function(package) {
  new_condition(
    message = sprintf("No package found called '%s'", as.character(package)),
    class = list("namespace", I("packageNotFoundError")),
    type = "error",
    package = NULL
  )
}

#' @export
#' @rdname conditions
development_error <- function(..., package = find_package()) {
  check_package(package)
  new_condition(
    message = c(...),
    class = "development",
    type = "error",
    package = package
  )
}

#' @export
#' @rdname conditions
defunct_error <- function(..., package = find_package()) {
  check_package(package)
  new_condition(
    message = c(...),
    class = list("defunct", I("defunctError")),
    type = "error",
    package = package
  )
}

#' @export
#' @rdname conditions
internal_error <- function(
  message = c(
    sprintf("An internal error occurred in '%s'.", package),
    "  Please report this to the package maintainer."
  ),
  ...,
  package = find_package()
) {
  check_package(package)
  new_condition(
    message = c(message, ...),
    class = "internal",
    type = "error",
    package = package
  )
}

# warnings ----------------------------------------------------------------

#' @export
#' @rdname conditions
warn <- function(...) {
  new_condition(
    message = c(...),
    type = "warning",
    package = NULL
  )
}

#' @export
#' @rdname conditions
input_warning <- error_to_warning(input_error)

#' @export
#' @rdname conditions
value_warning <- error_to_warning(value_error)


#' @export
#' @rdname conditions
class_warning <- error_to_warning(class_error)

#' @export
#' @rdname conditions
interactive_warning <- error_to_warning(interactive_error)

#' @export
#' @rdname conditions
namespace_warning <- error_to_warning(namespace_error)

#' @export
#' @rdname conditions
development_warning <- error_to_warning(development_error)

#' @export
#' @rdname conditions
internal_warning <- error_to_warning(internal_error)

#' @export
#' @rdname conditions
deprecated_warning <- function(..., package = find_package()) {
  check_package(package)
  new_condition(
    message = c(...),
    class = list("deprecated", I("deprecatedWarning")),
    type = "warning",
    package = package
  )
}

# conditions --------------------------------------------------------------

cond <- function(message, ...) {
  new_condition(
    message = c(message, ...),
    type = "condition",
    package = NULL
  )
}

bare_condition <- function(class = NULL) {
  structure(
    list(message = NULL, call = NULL),
    class = unique(c(class, "condition"))
  )
}


# helpers -----------------------------------------------------------------

check_package <- function(package) {
  if (!isTRUE(nzchar(package))) {
    stop(input_error("`package` must be a non-empty string"))
  }
}
