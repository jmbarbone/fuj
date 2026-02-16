with_options <- function(op, code) {
  op <- do.call(options, as.list(op))
  on.exit(options(op))
  force(code)
}

pairlist_to_string <- function(pair) {
  nms <- names(pair)
  vals <- as.character(pair)
  paste(nms, "=", vals, collapse = ", ")
}

integerish <- function(x) {
  is.integer(x) ||
    (is.numeric(x) &&
      !any(is.infinite(x)) &&
      all(x == as.integer(x), na.rm = TRUE))
}
