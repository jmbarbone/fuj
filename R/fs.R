#' File path
#'
#' Lightweight file path functions
#'
#' @description [is_path()] checks for either a `file_path` class or an
#'   `fs_path`, the latter useful for the `fs` package.
#'
#'   [file_path()] is an alias for [fp()] and [is_file_path()] is an alias for
#'   [is_path()].
#'
#' @param ... Path components, passed to [file.path()]
#' @param x An object to test
#' @return
#' - [fp()]/[file_path()]: A `character` vector of the normalized path with a
#' `"file_path"` class
#' - [is_path()]/[is_file_path()]: A `TRUE` or `FALSE` value
#' @export
#' @examples
#' fp("here")
#' fp("~/there")
#' fp("back\\slash")
#' fp("remove//extra\\\\slashes")
#' fp("a", c("b", "c"), "d")
fp <- function(...) {
  x <- normalizePath(file.path(..., fsep = "/"), "/", FALSE)
  x <- gsub("\\", "/", x, fixed = TRUE)
  x <- gsub("/+", "/", x)
  struct(x, class = c("file_path", "character"))
}

#' @export
#' @rdname fp
file_path <- fp

#' @export
print.file_path <- function(x, ...) {
  writeLines(x)
  invisible(x)
}

#' @export
#' @rdname fp
is_path <- function(x) {
  inherits(x, c("file_path", "fs_path"))
}

#' @export
#' @rdname fp
is_file_path <- is_path
