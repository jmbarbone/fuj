#' Colons
#'
#' Get an object from a package
#'
#' @details
#' This is a work around to calling `:::`.
#'
#' @section WARNING:
#' To reiterate from other documentation: it is not advised to use `:::` in
#'   your code as it will retrieve non-exported objects that may be more
#'   likely to change in their functionality that exported objects.
#'
#' @param package Name of the package
#' @param name Name to retrieve
#' @return The variable `name` from package `package`
#' @examples
#' identical("base" %colons% "mean", base::mean)
#' "fuj" %colons% "colons_example" # unexported value
#'
#' @export
`%colons%` <- function(package, name) {
  stopifnot(
    length(package) == 1,
    is.character(package),
    length(name) == 1,
    is.character(name)
  )

  require_namespace(package)

  res <- try(get(name, envir = asNamespace(package)), silent = TRUE)

  if (inherits(res, "try-error")) {
    stop(cond_colons(package, name))
  }

  res
}

cond_colons <- function(package, name) {
  new_condition(
    msg = sprintf(
      "`%s:::%s` not found",
      as.character(package),
      as.character(name)
    ),
    class = "colons"
  )
}

colons_example <- "Hello, world"
