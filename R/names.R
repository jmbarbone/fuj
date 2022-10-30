
is_named <- function(x) {
  !is.null(names(x))
}

#' Set names
#'
#' Sets or removes names
#'
#' @param x A vector of values
#' @param nm A vector of names
#' @return
#' * `set_names()`: `x` with `nm` values assigned to names (if `x` is `NULL`, `NULL` is returned)
#' * `remove_names()`: `x` without names
#' * `names_switch()`: `character` vector of equal length `x` where names and values are switched
#'
#' @export
set_names <- function(x, nm = x) {
  if (is.null(x)) return(NULL)
  `names<-`(x, nm)
}

#' @rdname set_names
#' @export
remove_names <- function(x) {
  `names<-`(x, NULL)
}

#' @rdname set_names
#' @export
`%names%` <- function(x, nm) {
  set_names(x, nm)
}
