#' File path
#'
#' Lightweight file path functions
#'
#' @description [is_path()] checks for either a `path` class or an `fs_path`,
#' the latter useful for the `fs` package.
#'
#' @param ... Path components, passed to [file.path()]
#' @param x An object to test
#' @return
#' - [fp()]: A `character` vector of the normalized path with a "path" class
#' - [is_path()]: A `TRUE` or `FALSE` value
#' @export
#' @examples
#' fp("here")
#' fp("~/there")
fp <- function(...) {
  struct(
    normalizePath(file.path(..., fsep = "/"), "/", mustWork = FALSE),
    class = c("path", "character")
  )
}

#' @export
print.path <- function(x, ...) {
  cat(x, "\n")
  invisible(x)
}

#' @export
#' @rdname fp
is_path <- function(x) {
  inherits(x, c("path", "fs_path"))
}
