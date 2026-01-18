#' Quick DF
#'
#' This is a speedier implementation of `as.data.frame()` but does not provide
#' the same sort of checks. It should be used with caution.
#'
#' @return A `data.frame`; if `x` is `NULL` a `data.frame` with `0` rows and `0`
#'   columns is returned (similar to calling `data.frame()` but faster).
#'   `empty_df()` returns a `data.frame` with `0` rows and `0` columns.
#'
#' @examples
#' # unnamed will use make.names()
#' x <- list(1:10, letters[1:10])
#' quick_df(x)
#'
#' # named is preferred
#' names(x) <- c("numbers", "letters")
#' quick_df(x)
#'
#' # empty data.frame
#' empty_df() # or quick_df(NULL)
#'
#' @name quick_df
NULL

#' @export
#' @rdname quick_df
#' @param x A list or `NULL` (see return)
quick_df <- function(x = NULL) {
  if (is.null(x)) {
    return(.empty_df)
  }

  if (!is.list(x)) {
    stop(cond_quick_df_input())
  }

  n <- unique(lengths(x))

  switch(
    length(n) + 1L,
    .empty_df,
    {
      x <- x[!vapply(x, is.null, NA)]
      names(x) <- names(x) %||% seq_along(x)
      class(x) <- "data.frame"
      attr(x, "row.names") <- c(NA_integer_, -n)
      x
    }
  ) %||%
    stop(cond_quick_df_list())
}

#' @export
#' @rdname quick_df
empty_df <- function() {
  .empty_df
}

# pre-build a `data.frame` with the `struct()` utility from fuj.  Is this really
# necessary?  Only if we want the absolute best times for
.empty_df <- list()
class(.empty_df) <- "data.frame"
attr(.empty_df, "row.names") <- integer()
names(.empty_df) <- character()

#' @export
#' @rdname quick_df
#' @param ... Columns as `tag = value` (passed to `list()`)
quick_dfl <- function(...) {
  .Deprecated(
    msg = paste0(
      "quick_dfl(...) is deprecated in {fuj} 0.9.0 and will be removed in a",
      " future version.  Please use quick_df(list(...)), dataframe(...) instead"
    )
  )
  quick_df(lst(...))
}

#' Data frame
#'
#' Unsure if I want to export this
#'
#' @rdname quick_df
# conditions --------------------------------------------------------------
#' @examples
#' b <- 3:4
#' dataframe(
#'   a = 1:2,
#'   b = b,
#'   c, # dropped
#' )
#' @export
dataframe <- function(...) {
  columns <- as.list(substitute(list(...))[-1L])
  columns <- columns[names(columns) != ""]
  columns <- lapply(columns, eval, envir = parent.frame(1L))
  quick_df(columns)
}

cond_quick_df_list <- function() {
  new_condition("`x` does not have equal length", class = "quick_df_list")
}

cond_quick_df_input <- function() {
  new_condition("`x` is not a list", class = "quick_df_input")
}
