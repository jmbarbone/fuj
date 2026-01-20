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
  fuj.vap.progress = FALSE,
  fuj.vap.indexed_errors = FALSE,
  fuj.verbose = NULL,
  fuj.verbose.fill = FALSE,
  fuj.verbose.label = "verbose: "
)

.onLoad <- function(libname, pkgname) {
  # set options
  options(op.fuj[!names(op.fuj) %in% names(options())]) # nocov
}
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
  fuj.list.active = TRUE,
  fuj.vap.progress = FALSE,
  fuj.vap.indexed_errors = FALSE,
  fuj.verbose = NULL,
  fuj.verbose.fill = FALSE,
  fuj.verbose.label = "verbose: "
)

.onLoad <- function(libname, pkgname) {
  # set options
  options(op.fuj[!names(op.fuj) %in% names(options())]) # nocov
  # try(globalCallingHandlers(`fuj:verbose_message` = fuj_verbose_handler))

  # nocov start
  if (isFALSE(getOption("fuj.list.active", TRUE))) {
    list0 <<- list
    lst <<- list
  }
  # nocov end
}
