#' Verbose
#'
#' Show messages when verbose
#'
#' @param ...,.fun Configurations for how messages will displayed
#' @returns The result of `.fun` when `getOption("verbose")` is `TRUE`,
#'   otherwise nothing, invisibly
#' @export
#' @examples
#' op <- options(verbose = FALSE)
#' verbose("no message")
#' options(verbose = TRUE)
#' verbose("message")
#' options(op)

verbose <- function(..., .fun = "message") {
  if (isTRUE(getOption("verbose"))) {
    if (!(is.null(..1) && ...length() == 1L)) {
      return(match.fun(.fun)(...))
    }
  }

  invisible()
}
