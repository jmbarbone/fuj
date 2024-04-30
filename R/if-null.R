#' Default value for `NULL` or no length
#'
#' Replace if `NULL` or not length
#'
#' @details
#' A mostly copy of `rlang`'s `%||%` except does not use `rlang::is_null()`,
#'   which, currently, calls the same primitive [base::is.null] function.
#'
#'   Note: `%||%` is copied from `{base}` if available (**R** versions >= 4.4)
#'
#' @param x,y If `x` is `NULL` returns `y`; otherwise `x`
#'
#' @name if_null
#' @return `x` if it is not `NULL` or has length, depending on check
#' @examples
#' # replace NULL (for R < 4.4)
#' NULL %||% 1L
#' 2L   %||% 1L
#'
#' # replace empty
#' ""       %|||% 1L
#' NA       %|||% 1L
#' double() %|||% 1L
#' NULL     %|||% 1L
#'
#' # replace no length
#' logical() %len% TRUE
#' FALSE     %len% TRUE
NULL

#' @rdname if_null
#' @export
`%||%` <- get0("%||%", baseenv(), "function", ifnotfound = function(x, y) {
  if (is.null(x)) y else x
})

#' @rdname if_null
#' @export
`%|||%` <- function(x, y) {
  if (length(x) && isTRUE(nzchar(x, keepNA = TRUE))) x else y
}

#' @rdname if_null
#' @export
`%len%` <- function(x, y) {
  if (length(x)) x else y
}
