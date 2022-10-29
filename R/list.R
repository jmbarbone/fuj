
#' Listing for dots
#'
#' Tries to not complain about empty arguments
#'
#' @param ... Arguments to collect in a list
#' @returns A `list` of `...`
#' @export
#' @examples
#' try(list(1,))
#' list0(1,)
list0 <- function(...) {
  parent <- parent.frame()
  mc <- match.call()
  n <- vapply(mc, nzchar, NA)

  if (all(n)) {
    list(...)
  } else {
   eval(mc[n], envir = parent)
  }
}
