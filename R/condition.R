#' New condition
#'
#' Template for a new condition.  See more at [base::conditions]
#'
#' @param msg,message A message to print
#' @param class Character string of a single condition class
#' @param call A call expression
#' @param type The type (additional class) of condition: either `error"`,
#'   `"warning"` or `NA`, which is treated as `NULL`
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
    message = msg
) {
  stopifnot(length(class) == 1L)
  type <- as.character(type)
  type <- match.arg(type)
  class <- as.character(class)

  if (length(type) == 1L && !is.na(type)) {
    class <- collapse(class, "_", type)
    class <- gsub("_([a-z])", "\\U\\1", class, perl = TRUE)
  }

  message <- sprintf("<%s> %s", class, collapse(message))
  class <- unique(c(class, type %|||% NULL, "condition"))
  struct(list(message, call), class = class, names = c("message", "call"))
}
