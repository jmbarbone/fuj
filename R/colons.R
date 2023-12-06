#' Colons
#'
#' Get an object from a namespace
#'
#' @details The functions mimic the use of `::` and `:::` for extracting values
#' from namespaces.  `%colons%` is an alias for `%::%`.
#'
#' @section WARNING: To reiterate from other documentation: it is not advised to
#'   use `:::` in your code as it will retrieve non-exported objects that may be
#'   more likely to change in their functionality that exported objects.
#'
#' @param package Name of the package
#' @param name Name to retrieve
#' @return The variable `name` from package `package`
#' @examples
#' identical("base" %::% "mean", base::mean)
#' "fuj" %:::% "colons_example" # unexported value
#'
#' @name colons
#' @seealso `help("::")`
NULL

#' @rdname colons
#' @export
`%::%` <- function(package, name) {
  colons_check(package, name)
  tryCatch(
    getExportedValue(asNamespace(package), name),
    error = function(e) stop(cond_colons(package, name, 2))
  )
}

#' @rdname colons
#' @export
`%:::%` <- function(package, name) {
  colons_check(package, name)
  tryCatch(
    get(name, envir = asNamespace(package)),
    error = function(e) stop(cond_colons(package, name, 3))
  )
}

#' @rdname colons
#' @export
`%colons%` <- `%:::%`

cond_colons <- function(package, name, n) {
  new_condition(
    msg = sprintf(
      "`%s%s%s` not found",
      as.character(package),
      strrep(":", n),
      as.character(name)
    ),
    class = "colons"
  )
}

colons_check <- function(package, name) {
  ok <- wuffle(try({
    length(package) == 1 &&
      is.character(package) &&
      length(name) == 1 &&
      is.character(name)
  }, silent = TRUE))


  if (!isTRUE(ok)) {
    stop(cond_colons_package_name())
  }

  require_namespace(package)
}

colons_example <- "Hello, world"

cond_colons_package_name <- function() {
  new_condition(
    msg = "`package` and `name` must be strings of length 1",
    class = "colons_package_name"
  )
}
