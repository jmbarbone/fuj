#' Require namespace
#'
#' @param package,... Package names
#' @return `TRUE` (invisibly) if found; otherwise errors
#' @examples
#' isTRUE(require_namespace("base")) # returns invisibly
#' try(require_namespace("1package")) # (using a purposefully bad name)
#' @export
require_namespace <- function(package, ...) {
  pkgs <- c(package, ...)
  for (pkg in pkgs) {
    if (!isTRUE(try(requireNamespace(pkg, quietly = TRUE), silent = TRUE))) {
      stop(cond_namespace(pkg))
    }
  }

  invisible(TRUE)
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
