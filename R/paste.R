#' Collapse
#'
#' Simple wrapper for concatenating strings
#'
#' @inheritParams base::paste
#' @return A `character` vector of concatenated values.  See [base::paste] for
#'   more details.
#'
#' @examples
#' collapse(1:10)
#' collapse(list("a", b = 1:2))
#' collapse(quick_dfl(a = 1:3, b = 4:6), sep = "-")
#' @export
collapse <- function(..., sep = "") {
  paste0(unlist(lst(...)), collapse = sep)
}
