# Like rlang::`%||%` but uses base is.null -- same thing

#' Default value for NULL
#'
#' Replace if `NULL`
#'
#' @details
#' A mostly copy of `rlang`'s `%||%` except does not use [rlang::is_null()],
#'   which, currently, calls the same primitive `is.null` function as
#'   [base::is.null()].
#' This is not to be exported due to conflicts with `purrr`
#'
#' @param x,y If `x` is `NULL` returns `y`; otherwise `x`
#'
#' @name if_null
#' @export
#' @returns `x` if it is not `NULL` (or has length)
`%||%` <- function(x, y) {
  if (is.null(x)) y else x
}

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

