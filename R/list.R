#' Listing for dots
#'
#' Tries to not complain about empty arguments
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
  e <- as.list(substitute(list(...)))[-1L]
  do.call(list, e[is_not_empty(e)], envir = parent.frame(2))
}

#' @export
#' @rdname list0
lst <- list0

is_not_empty <- function(x) {
  # https://jmbarbone.github.io/posts/wat-na-list/
  x <- x != substitute()
  x | is.na(x)
}
