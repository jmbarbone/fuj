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
  x <- normalizePath(file.path(..., fsep = "/"), "/", FALSE)
  x <- gsub("\\", "/", x, fixed = TRUE)
  x <- gsub("/+", "/", x)
  struct(x, class = c("file_path", "character"))
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
