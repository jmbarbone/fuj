#' Encode/factor
#'
#' Low-level encoding and `factor` building
#'
#' @param x A vector of values
#' @param levels A vector of unique values. If `NULL`, the unique values in `x`
#'   are used.
#' @param from,to Vectors of the same length. Values in `x` are matched to
#'   `from` and replaced with the corresponding value in `to`.
#' @param strict If `TRUE`, values in `x` that are not matched to `from` will be
#'   replaced with `NA`. If `FALSE`, they will be left unchanged.
#' @param exclude Values in `x` that will not be matched when recoding;
#'   `exclude` will take priority over `from` in [fuj::encode()].
#' @examples
#' fact(strsplit("factor function", "")[[1L]])
#'
#' # encode() can be used to for the same utility as factor(x, levels, labels)
#' en <- encode(
#'   strsplit("jordan", "")[[1L]],
#'   from = c("a", "o"),
#'   to = "*",
#' )
#'
#' en
#' fact(en)
#' @name encode
NULL

#' @rdname encode
#' @export
#' @returns [fuj::encode()] A vector of the same length as `x` with values
#'   replaced according to `from` and `to`.
encode <- function(x, from, to, strict = FALSE, exclude = NULL) {
  # unfortunately, match() doesn't distinguish between non-matches and
  # incomparables...

  n_to <- length(to)
  n_from <- length(from)

  if (n_to == 1L) {
    to <- rep(to, n_from)
  } else if (n_to != n_from) {
    stop(input_error(
      "`from` and `to` must be the same length, or `to` must be length 1."
    ))
  }

  m <- match(x, from, NA_integer_)
  res <- to[m]

  if (!is.null(exclude)) {
    res[!is.na(match(x, exclude))] <- NA
  }

  if (strict) {
    return(res)
  }

  na <- is.na(m)
  res[na] <- x[na]
  res
}

#' @rdname encode
#' @export
#' @returns [fuj::fact()] A `factor` vector with levels corresponding to the
#'   unique values in `x` (or `levels` if provided).
fact <- function(x, levels = NULL, exclude = NULL) {
  if (is.null(levels)) {
    # slightly more efficient
    levels <- remove_na(unique(x, exclude = NULL))
  }

  res <- match(x, levels, incomparables = exclude)
  attr(res, "levels") <- as.character(levels)
  class(res) <- "factor"
  res
}
