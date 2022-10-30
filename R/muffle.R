#' Muffle messages
#'
#' Aliases for [base::suppressMessages()] and [base::suppressWarnings()]
#'
#' @param expr An expression to evaluate
#' @param fun A function to _muffle_ (or _wuffle_)
#' @param classes A character vector if ckasses to suppress
#' @export
#' @examples
#'
#' # load function
#' foo <- function(...) {
#'   message("You entered :", paste0(...))
#'   c(...)
#' }
#'
#' # wrap around function or muffle the function ti's
#' muffle(foo(1, 2))
#' muffle(fun = foo)(1, 2)
#' sapply(1:3, muffle(fun = foo))
#'
#' # silence warnings
#' wuffle(as.integer("a"))
#' sapply(list(1, "a", "0", ".2"), wuffle(fun = as.integer))
muffle <- function(expr, fun, classes = "message") {
  if (missing(fun)) {
    suppressMessages(expr, classes = classes)
  } else if (missing(expr)) {
    out <- function(...) {}
    body(out) <- substitute(
      fuj::muffle(expr = match.fun(fun)(...), classes = classes),
      environment()
    )
    out
  } else {
    stop(muffleCondition("muffle"))
  }
}

#' @export
#' @rdname muffle
wuffle <- function(expr, fun, classes = "warning") {
  if (missing(fun)) {
    suppressWarnings(expr, classes = classes)
  } else if (missing(expr)) {
    out <- function(...) {}
    body(out) <- substitute(
      fuj::wuffle(expr = match.fun(fun)(...), classes = classes),
      environment()
    )
    out
  } else {
    stop(muffleCondition("wuffle"))
  }
}

muffleCondition <- function(class = c("muffle", "wuffle"), call = NULL) {
  class <- paste0(match.arg(class), "Error")
  struct(
    list0(
      message = paste(class, ": only either `expr` or `fun` must be used"),
      call = NULL,
    ),
    class = c(class, "error", "condition"),
    names = c("message", "call")
  )
}
