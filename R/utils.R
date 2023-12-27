
# nocov start
# only used in testing
with_verbose <- function(code) {
  with_options(c(fuj.verbose = TRUE), code)
}
# nocov end

with_options <- function(op, code) {
  op <- do.call(options, as.list(op))
  on.exit(options(op))
  force(code)
}
