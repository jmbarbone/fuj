#' Listing for dots
#'
#' Tries to not complain about empty arguments
#'
#' If `options(fuj.list.active = FALSE)` is set to prior to package loading,
#' this function becomes an alias for [base::list()], disabling the special
#' behavior.
#'
#' @param ... Arguments to collect in a list
#' @return A `list` of `...`
#' @examples
#' try(list(1, ))
#' list0(1, )
#' try(list(a = 1, ))
#' list0(a = 1, )
#' try(list(a = 1, , c = 3, ))
#' list0(a = 1, , c = 3, )
#' @export
list0 <- function(...) {
  e <- as.list(substitute((...)))[-1L]
  eval(as.call(c(list, e[!is_empty(e)])), envir = parent.frame(2L))
}

#' @export
#' @rdname list0
lst <- list0

is_empty <- function(x) {
  # https://jmbarbone.github.io/posts/wat-na-list/
  vapply(x, identical, NA, quote(expr = ))
}
