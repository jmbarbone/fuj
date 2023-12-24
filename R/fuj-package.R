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
# nolint next: object_name_linter.
op.fuj <- list(
  fuj.verbose = NULL,
  fuj.verbose.fill = FALSE,
  fuj.verbose.label = "verbose: "
)

.onLoad <- function(libname, pkgname) {
  # set options
  options(op.fuj[!names(op.fuj) %in% names(options())]) # nocov
}
