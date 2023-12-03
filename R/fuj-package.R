#' @keywords internal
"_PACKAGE"

## usethis namespace: start
## usethis namespace: end
NULL

#' `{fuj}` options
#'
#' Options uses for `{fuj}` functions.
#'
#' @keywords internal
#' @examples
#' names(op.fuj)
#' op.fuj
#' @export
op.fuj <- list(
  fuj.verbose = NULL,
  fuj.verbose.fill = FALSE,
  fuj.verbose.label = "<verboseMessage> "
)

.onLoad <- function(libname, pkgname) {
  # set options
  options(op.fuj[!names(op.fuj) %in% names(options())])
}
