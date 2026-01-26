#' File path operations
#'
#' Lightweight file path functions
#'
#' @description [is_path()] checks for either a `file_path` class or an
#'   `fs_path`, the latter useful for the `fs` package.
#'
#'   [file_path()] is an alias for [fp()] and [is_file_path()] is an alias for
#'   [is_path()].
#'
#'   [set_file_ext()] changes the file extension of a file path, removing any
#'   existing extension first.  [file_ext<-()] serves as an alias.
#'
#' @param ... Path components, passed to [file.path()]
#' @param x An object to test
#' @return
#' - [fp()]/[file_path()]: A `character` vector of the normalized path with a
#' `"file_path"` class
#' - [is_path()]/[is_file_path()]: A `TRUE` or `FALSE` value
#' - [set_file_ext()]/[file_ext<-()]: The file path with the updated extension
#' @export
#' @examples
#' fp("here")
#' fp("~/there")
#' fp("back\\slash")
#' fp("remove//extra\\\\slashes")
#' fp("a", c("b", "c"), "d")
#'
#' # supports / and +
#' (x <- fp("here") / "subdir" + "ext")
#'
#' # change file extension
#' file_ext(x) <- "txt"
#' x
#' file_ext(x) <- ".txt.gz"
#' x
#' file_ext(x) <- NULL
#' x
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

#' @export
#' @rdname fp
#' @param value The new file extension.  When `NULL`, removes the current
#'   extension
#' @param compression If `TRUE`, also removes common compression extensions
set_file_ext <- function(x, value, compression = TRUE) {
  if (compression) {
    x <- sub("([^.]+)\\.(gz|bz2|xz|zip|7z|zip)$", "\\1", x)
  }

  x <- sub("([^.]+)\\.[[:alnum:]]+$", "\\1", x)

  if (is.null(value)) {
    return(x)
  }

  if (!startsWith(value, ".")) {
    value <- sprintf(".%s", value)
  }

  if (inherits(x, "file_path")) {
    x <- x + value
  } else {
    x <- sprintf("%s%s", x, value)
  }

  x
}

#' @export
#' @rdname fp
`file_ext<-` <- function(x, compression = TRUE, value) {
  set_file_ext(x = x, value = value, compression = compression)
}

#' @export
`+.file_path` <- function(e1, e2) {
  fp(sprintf("%s%s%s", e1, if (startsWith(e2, ".")) "" else ".", e2))
}

#' @export
`/.file_path` <- function(e1, e2) {
  fp(e1, e2)
}
