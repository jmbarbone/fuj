#' Exact attributes
#'
#' Get the exact attributes of an object
#'
#' @inheritParams base::attr
#' @export
#' @return See [base::attr]
exattr <- function(x, which) {
  attr(x, which = which, exact = TRUE)
}

#' @export
#' @rdname exattr
`%attr%` <- function(x, which) {
  exattr(x, which)
}
