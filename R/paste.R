#' Collapse
#'
#' Simple wrapper for concatenating strings
#'
#' @inheritParams base::paste
#' @export
#' @return A `character` vector of concatenated values.  See [base::paste] for
#'   more details.
collapse <- function(..., sep = "") {
  ls <- list(...)
  paste0(unlist(ls), collapse = sep)
}
