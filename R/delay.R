#' Delay the evaluation of an expression until the end of a function or block.
#'
#' @param expr An expression to be evaluated later.
#' @param envir The environment in which to evaluate the expression.
#' @inheritParams base::on.exit add after
#' @export
#' @examples
#' local({
#'   x <- 1L
#'   delay(message("x = ", x))
#'   x <- 2L
#' })
#' @return None, called for its side-effects
delay <- function(expr, envir = parent.frame(), add = TRUE, after = FALSE) {
  delayed_expr <- as.call(list(function() expr))
  args <- list(expr = delayed_expr, add = add, after = after)
  do.call(on.exit, args, envir = envir)
}
