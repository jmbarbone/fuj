
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
  `names<-`(x, nm)
}

#' @rdname names
#' @export
remove_names <- function(x) {
  `names<-`(x, NULL)
}

#' @rdname names
#' @export
`%names%` <- function(x, nm) {
  set_names(x, nm)
}

#' @rdname names
is_named <- function(x) {
  !is.null(names(x))
}
