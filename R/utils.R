#' Utilities
#'
#' Additional utilities
#'
#' @param x A vector of values
#' @param pair A named list of values
#' @param expr Expression to evaluate\
#'
#' @name fuj_utils
#' @keywords internal
#' @noRd
NULL

#' @rdname fuj_utils
#' @noRd
remove_na <- function(x) {
  x[!is.na(x)]
}

#' @rdname fuj_utils
#' @noRd
with_options <- function(pair, expr) {
  op <- do.call(options, as.list(pair))
  on.exit(options(op))
  force(expr)
}

#' @rdname fuj_utils
#' @noRd
pairlist_to_string <- function(pair) {
  nms <- names(pair)
  vals <- as.character(pair)
  paste(nms, "=", vals, collapse = ", ")
}

#' @rdname fuj_utils
#' @noRd
integerish <- function(x) {
  is.integer(x) ||
    (is.numeric(x) &&
      !any(is.infinite(x)) &&
      all(x == as.integer(x), na.rm = TRUE))
}

# nolint next: object_name_linter.
isNA <- function(x) {
  is.logical(x) && length(x) == 1L && is.na(x)
}
