#' Require namespace
#'
#' @param package The name of a package
#' @return `TRUE` (invisibly) if found; otherwise errors
#' @examples
#' isTRUE(require_namespace("base")) # returns invisibly
#' try(require_namespace("1package")) # (using a purposefully bad name)
#' @export
require_namespace <- function(package) {
  ok <- try(wuffle(requireNamespace)(package, quietly = TRUE), silent = TRUE)

  if (isTRUE(ok)) {
    return(invisible(TRUE))
  }

  stop(cond_namespace(package))
}

cond_namespace <- function(package) {
  new_condition(
    msg = sprintf(
      "No package found called '%s'",
      as.character(package)
    ),
    class = "namespace"
  )
}
