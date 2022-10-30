
#' Require namespace
#'
#' @param package The name of a package
#' @export
#' @returns `TRUE` (invisibly) if found; otherwise errors
require_namespace <- function(package) {
  ok <- try(wuffle(requireNamespace)(package, quietly = TRUE), silent = TRUE)

  if (isTRUE(ok)) {
    return(invisible(TRUE))
  }

  stop(namespaceCondition(package))
}

namespaceCondition <- function(package) {
  new_condition(
    msg = sprintf(
      "No package found called '%s'",
      as.character(package)
    ),
    class = "namespace"
  )
}
