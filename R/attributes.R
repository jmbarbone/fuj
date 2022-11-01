#' Exact attributes
#'
#' Get the exact attributes of an object
#'
#' @inheritParams base::attr
#' @export
#' @return See [base::attr]
#' @examples
#' foo <- struct(list(), "foo", aa = TRUE)
#'   attr(foo, "a")  # TRUE : partial match successful
#' exattr(foo, "a")  # NULL : partial match failed
#' exattr(foo, "aa") # TRUE : exact match
exattr <- function(x, which) {
  attr(x, which = which, exact = TRUE)
}

#' @export
#' @rdname exattr
`%attr%` <- function(x, which) {
  exattr(x, which)
}
