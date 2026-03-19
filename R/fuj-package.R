#' @keywords internal
"_PACKAGE"

## usethis namespace: start
## usethis namespace: end
NULL

#' `{fuj}` options
#'
#' Options uses for [fuj::fuj-package] functions.
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
  # nocov start
  options(op.fuj[!names(op.fuj) %in% names(options())])

  if (isFALSE(getOption("fuj.list.active", TRUE))) {
    list0 <<- base::list
    lst <<- base::list
  }

  switch(
    Sys.info()[["sysname"]],
    Windows = is_windows_ <<- TRUE,
    Darwin = is_macos_ <<- TRUE,
    Linux = is_linux_ <<- TRUE
  )
  # nocov end
}
