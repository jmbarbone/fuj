#' New condition
#'
#' Template for a new condition.  See more at [base::conditions]
#'
#' @details The use of `.packageName` when `pkg = TRUE` may not be valid during
#'   active development.  When the attempt to retrieve the `.packageName` object
#'   is unsuccessful, the error is quietly ignored.  However, this should be
#'   successful once the package is build and functions can then utilize this
#'   created object.
#'
#' @param msg,message A message to print
#' @param class Character string of a single condition class
#' @param call A call expression
#' @param type The type (additional class) of condition: either `error"`,
#'   `"warning"` or `NA`, which is treated as `NULL`
#' @param pkg Control or adding package name to condition.  If `TRUE` will try
#'   to get the current package name (via `.packageName`) from, presumably, the
#'   developmental package.  If `FALSE`, no package name is prepended to the
#'   condition class as a new class.  Otherwise, a package can be explicitly set
#'   with a single length character.
#' @return A `condition` with the classes specified from `class` and `type`
#' @examples
#' # empty condition
#' x <- new_condition("informative error message", class = "foo")
#' try(stop(x))
#'
#' # with pkg
#' x <- new_condition("msg", class = "foo", pkg = "bar")
#' # class contains multiple identifiers, including a "bar:fooError"
#' class(x)
#' # message contains package information at the end
#' try(stop(x))
#' @export
new_condition <- function( # nolint cyclocomp_linter,
    msg = "",
    class = NULL,
    call = NULL,
    type = c("error", "warning", NA_character_),
    message = msg,
    pkg = TRUE
) {
  if (!length(class) == 1L && !is.character(class)) {
    stop(cond_new_conditional_class())
  }

  type <- as.character(type)
  type <- match.arg(type)
  class <- as.character(class)

  if (length(type) == 1L && !is.na(type)) {
    class <- collapse(class, "_", type)
    class <- gsub("_([a-z])", "\\U\\1", class, perl = TRUE)
  }

  if (!isFALSE(pkg)) {
    if (isTRUE(pkg)) {
      # may fail to get the package during development
      env <- parent.frame()
      pkg <- try(eval(substitute(.packageName), env), silent = TRUE)
    }

    if (inherits(pkg, "try-error")) {
      pkg <- NULL # nocov
    } else if (is.character(pkg) && length(pkg) == 1L && !is.na(pkg)) {
      class <- c(paste0(pkg, ":", class), class)
    } else {
      stop(cond_new_conditional_pkg())
    }
  } else {
    pkg <- NULL
  }

  message <- sprintf(
    "<%s> %s",
    if (is.null(pkg)) class else class[2L],
    collapse(message)
  )

  class <- unique(c("fujCondition", class, type %|||% NULL, "condition"))
  struct(
    list(message, call),
    class = class,
    names = c("message", "call"),
    package = pkg
  )
}

#' @export
conditionMessage.fujCondition <- function(c) {
  pkg <- attr(c, "package")
  if (!is.null(pkg)) {
    c$message <- paste0(c$message, sprintf("\npackage:%s", pkg))
  }

  NextMethod(c)
}

cond_new_conditional_class <- function() {
  new_condition(
    "`class` must be a single length character",
    class = "newConditionClass",
    pkg = "fuj"
  )
}

cond_new_conditional_pkg <- function() {
  new_condition(
    "`pkg` must be TRUE, FALSE, or a single length character",
    class = "newConditionPackage",
    pkg = "fuj"
  )
}
