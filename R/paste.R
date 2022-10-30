#' Collapse
#'
#' Simple wrapper for concatenating strings
#'
#' @inheritParams base::paste
#' @export
collapse <- function(..., sep = "") {
  ls <- list(...)
  paste0(unlist(ls), collapse = sep)
}
