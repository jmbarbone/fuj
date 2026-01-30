with_options <- function(op, code) {
  op <- do.call(options, as.list(op))
  on.exit(options(op))
  force(code)
}

catln <- function(...) {
  cat(..., "\n", sep = "")
}
