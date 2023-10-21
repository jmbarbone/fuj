#' Verbose
#'
#' Simple verbose condition handling
#'
#' @details [verbose()] can be safely placed in scripts to signal additional
#'   message conditions.  [verbose()] can be controlled with `options(verbose)`
#'   (the default) and an override, `options(fuj.verbose)`.  The latter can be
#'   set to a function whose result will be used for conditional evaluation.
#'
#' @param ... A message to display.  When `...` is `NULL` (and only `NULL`), no
#'   message will display.
#' @returns None, called for its side-effects.  When conditions are met, will
#'   signal a `verboseMessage` condition.
#' @examples
#' op <- options(verbose = FALSE)
#' verbose("will not show")
#'
#' options(verbose = TRUE)
#' verbose("message printed")
#' verbose("multiple lines ", "will be ", "combined")
#' options(op)
#'
#' op <- options(fuj.verbose = function() TRUE)
#' verbose("function will evaluate")
#' verbose(NULL) # nothing
#' verbose(NULL, "something")
#' verbose(if (FALSE) {
#' "`if` returns `NULL` when not `TRUE`, which makes for additional control"
#' })
#' options(op)
#' @export
verbose <- function(...) {
  op <- getOption("fuj.verbose", getOption("verbose"))

  if (is.function(op)) {
    op <- op()
  }

  if (isTRUE(op)) {
    if (!(is.null(..1) && ...length() == 1L)) {
      message(verbose_message(...))
    }
  }

  invisible()
}

verbose_message <- function(..., call = NULL) {
  struct(
    list(.makeMessage("[verbose] ", ..., appendLF = TRUE), call),
    names = c("message", "call"),
    class = c("verboseMessage", "message", "condition")
  )
}
