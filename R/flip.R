#' Flip
#'
#' Flip an object.
#'
#' @param x An object
#' @param by Flip by `"rows"` or `"columns"` (partial matches accepted)
#' @param keep_rownames Logical, if `TRUE` will not reset row names; `NULL`
#' @param ... Additional arguments passed to methods
#' @return A `vector` of values, equal length of `x` that is reversed or a
#'   `data frame` with flipped rows/columns
#'
#' @examples
#' flip(letters[1:3])
#' flip(seq.int(9, -9, by = -3))
#' flip(head(iris))
#' flip(head(iris), keep_rownames = TRUE)
#' flip(head(iris), by = "col")
#'
#' @export

flip <- function(x, ...) {
  UseMethod("flip", x)
}

#' @export
#' @rdname flip
flip.default <- function(x, ...) {
  len <- length(x)

  if (len < 2) {
    return(x)
  }

  x[len:1L]
}

#' @export
#' @rdname flip
flip.matrix <- function(
    x,
    by = c("rows", "columns"),
    keep_rownames = NULL,
    ...
) {
  switch(
    match.arg(by),
    rows =  {
      rows <- nrow(x)
      dims <- dimnames(x)

      if (rows < 2) {
        return(x)
      }

      out <- x[rows:1, , drop = FALSE]
      rn <- dims[[1]]

      if (is.null(keep_rownames)) {
        keep_rownames <- !identical(rn, 1:rows)
      }

      if (!keep_rownames) {
        dims[[1]] <- rn
        dimnames(out) <- dims
      }
    },
    columns = {
      cols <- ncol(x)

      if (length(x) == 0L) {
        return(x)
      }

      out <- x[, cols:1L, drop = FALSE]
    }
  )

  out
}

#' @export
#' @rdname flip
flip.data.frame <- function(
    x,
    by = c("rows", "columns"),
    keep_rownames = NULL,
    ...
) {
  switch(
    match.arg(by),
    rows = {
      rows <- nrow(x)

      if (rows < 2) {
        return(x)
      }

      out <- x[rows:1, , drop = FALSE]
      rn <- attr(x, "row.names")

      if (is.null(keep_rownames)) {
        keep_rownames <- !identical(rn, 1:rows)
      }

      if (!keep_rownames) {
        attr(out, "row.names") <- rn # nolint object_name_linter
      }
    },
    columns = {
      cols <- ncol(x)

      if (!cols) {
        return(x)
      }

      out <- x[, cols:1L, drop = FALSE]
    }
  )

  out
}
