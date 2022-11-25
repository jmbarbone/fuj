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
#'   developmental package.  Otherwise, no package name is prepended to the
#'   condition class.
#' @return A `condition` with the classes specified from `class` and `type`
#' @examples
#' # empty condition
#' x <- new_condition("informative error message", class = "foo")
#' try(stop(x))
#'
#' @export
new_condition <- function(
    msg = "",
    class = NULL,
    call = NULL,
    type = c("error", "warning", NA_character_),
    message = msg,
    pkg = TRUE
) {
  stopifnot(length(class) == 1L)
  type <- as.character(type)
  type <- match.arg(type)
  class <- as.character(class)

  if (length(type) == 1L && !is.na(type)) {
    class <- collapse(class, "_", type)
    class <- gsub("_([a-z])", "\\U\\1", class, perl = TRUE)
  }

  if (isTRUE(pkg)) {
    # may fail to get the package during development
    pkg <- try(eval(substitute(.packageName), parent.frame(1)), silent = TRUE)
    if (!inherits(pkg, "try-error")) {
      class <- paste0(pkg, ":", class)
    }
  }

  message <- sprintf("<%s> %s", class, collapse(message))
  class <- unique(c(class, type %|||% NULL, "condition"))
  struct(list(message, call), class = class, names = c("message", "call"))
}
