#' New condition
#'
#' Template for a new condition.  See more at [base::conditions]
#'
#' @details The use of `.packageName` when `package = TRUE` may not be valid
#'   during active development.  When the attempt to retrieve the `.packageName`
#'   object is unsuccessful, the error is quietly ignored.  However, this should
#'   be successful once the package is build and functions can then utilize this
#'   created object.
#'
#' @param message A message to print
#' @param class Character string of a single condition class.  If `class` does
#'   not end with the value used in `class`, the suffix is appended with an
#'   underscore (`_`).  This can be ignored if passing `class` as an `AsIs`
#'   vector (i.e., `I("my_class")`).
#' @param type The type (additional class) of condition: `error"`, `"warning"`,
#'   `"message"`, or `NA`, which is treated as `NULL`.
#' @param ... Ignored
#' @param call A call expression
#' @param package Control or adding package name to condition.  If `TRUE` will
#'   try to get the current package name (via `.packageName`) from, presumably,
#'   the developmental package.  If `FALSE` or `NULL`, no package name is
#'   prepended to the condition class as a new class.  Otherwise, a package can
#'   be explicitly set with a single length character.
#' @param pkg Deprecated, see `package`
#' @param msg Deprecated, see `message`
#' @return A `condition` with the classes specified from `class` and `type`
#' @examples
#' # empty condition
#' x <- new_condition(
#'   "informative error message",
#'   class = "foo",
#'   type = "error"
#'  )
#' try(stop(x))
#'
#' # with pkg
#' x <- new_condition("msg", class = "foo", type = "error", package = "bar")
#' # class contains multiple identifiers, including a "bar:fooError"
#' class(x)
#' # message contains package information at the end
#' try(stop(x))
#' @export
new_condition <- function(
  message = "",
  class = "fuj_condition",
  type = c("condition", "error", "warning", "message"),
  ...,
  call = NULL,
  package = find_package(),
  msg,
  pkg
) {
  if (!missing(pkg)) {
    warning(
      deprecated_warning(
        "`new_condition(pkg)` is deprecated; use `new_condition(package)`",
        " instead"
      )
    )
    package <- pkg
  }

  if (!missing(msg)) {
    warning(
      deprecated_warning(
        "`new_condition(msg)` is deprecated; use `new_condition(message)`",
        " instead"
      )
    )
    message <- msg
  }

  if (...length() > 0L) {
    mc <- match.call(expand.dots = FALSE)$...
    warning(
      dots_warning(
        "`...` is ignored in `new_condition()`: ",
        pairlist_to_string(mc)
      )
    )
    return()
  }

  # fmt: skip
  if (!inherits(class, c("list", "character", "AsIs"))) {
    stop(class_error("`class` must be a list, character, or AsIs"))
  }

  force(package)
  if (is.null(package)) {
    package <- FALSE
  }

  type <- as.character(type)
  type <- match.arg(type, c("condition", "error", "warning", "message"))

  if (!inherits(class, "AsIs")) {
    class <- vapply(
      class,
      function(x) {
        # fmt: skip
        if (is.null(x)) {
          x <- "condition" # removed
        } else if (
          inherits(x, "AsIs") ||
          grepl(paste0(type, "$"), x, ignore.case = TRUE)
        ) {
          as.character(x)
        } else  {
          sprintf("%s_%s", x, type)
        }
      },
      FUN.VALUE = NA_character_,
      USE.NAMES = FALSE
    )
  }

  class <- unique(class)

  if (!isFALSE(package)) {
    if (isTRUE(package)) {
      # may fail to get the package during development
      env <- parent.frame() # nocov
      package <- try(eval(substitute(.packageName), env), silent = TRUE) # nocov
    }

    # fmt: skip
    if (inherits(package, "try-error")) {
      package <- NULL # nocov
    } else if (
      is.character(package) &&
      length(package) == 1L &&
      !is.na(package)
    ) {
      class <- c(paste0(package, ":", class), class)
    } else {
      stop(value_error(
        "`pkg` must be TRUE, FALSE, or a single length character"
      ))
    }
  } else {
    package <- NULL
  }

  message <- sprintf(
    "<%s> %s",
    if (is.null(package)) class else class[2L],
    collapse(message)
  )

  class <- unique(c(class, type, "fuj_condition", "condition"))

  struct(
    list(message, call),
    class = class,
    names = c("message", "call"),
    package = package
  )
}

#' @export
conditionMessage.fuj_condition <- function(c) {
  pkg <- attr(c, "package")
  if (!is.null(pkg)) {
    c$message <- paste0(c$message, sprintf("\npackage:%s", pkg))
  }

  NextMethod(c)
}

find_package <- function(env = parent.frame(2L)) {
  top <- topenv(env)
  if (isNamespace(top)) {
    unname(getNamespaceName(top))
  }
}
