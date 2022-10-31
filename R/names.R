#' Set names
#'
#' Sets or removes names
#'
#' @param x A vector of values
#' @param nm A vector of names
#' @return `x` with `nm` values assigned to names (if `x` is `NULL`, `NULL` is
#'   returned)
#'
#' @name names
#' @export
set_names <- function(x, nm = x) {
  if (is.null(x)) return(NULL)
  `names<-`(x, validate_names(nm))
}

#' @rdname names
#' @export
remove_names <- function(x) {
  `names<-`(x, NULL)
}

#' @rdname names
#' @export
`%names%` <- function(x, nm) {
  set_names(x, validate_names(nm))
}

#' @rdname names
#' @param zero_ok If `TRUE` allows use of `""` as a _special_ name
is_named <- function(x, zero_ok = TRUE) {
  nm <- names(x)
  !is.null(nm) && if (zero_ok) TRUE else all(nzchar(nm))
}

validate_names <- function(x) {
  x[lengths(x) == 0L] <- NA_character_
  as.character(x)
}
