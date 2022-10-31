#' Quick DF
#'
#' This is a speedier implementation of `as.data.frame()` but does not provide
#' the same sort of checks. It should be used with caution.
#'
#' @return A `data.frame`; if `x` is `NULL` a `data.frame` with `0` rows and `0`
#'   columns is returned (similar to calling `data.frame()` but faster)
#' @examples
#'
#' # unnamed will use make.names()
#' x <- list(1:10, letters[1:10])
#' quick_df(x)
#'
#' # named is preferred
#' names(x) <- c("numbers", "letters")
#' quick_df(x)
#'
#' # empty data.frame
#' quick_df(NULL)
#'
#' @name quick_df
NULL

#' @export
#' @rdname quick_df
#' @param x A list or `NULL` (see return)
quick_df <- function(x = NULL) {
  if (is.null(x)) {
    return(empty_df())
  }

  if (!is.list(x)) {
    stop(quickdfInputCondition())
  }

  n <- unique(lengths(x))

  if (length(n) != 1L) {
    stop(quickdfListCondition())
  }

  struct(
    x  = x,
    class ="data.frame",
    names = names(x) %||% make.names(1:length(x)),
    row.names = c(NA_integer_, -n)
  )
}

empty_df <- function() {
  struct(list(), "data.frame", row.names = integer(), names = character())
}

#' @export
#' @rdname quick_df
#' @param ... Columns as `tag = value` (passed to `list()`)
quick_dfl <- function(...) {
  quick_df(list(...))
}


# conditions --------------------------------------------------------------

quickdfListCondition <- function() {
  new_condition("`x` does not have equal length", class = "quickdfList")
}

quickdfInputCondition <- function() {
  new_condition("`x` is not a list", class = "quickdfInput")
}
