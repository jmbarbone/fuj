#' Muffle messages
#'
#' Aliases for [base::suppressMessages()] and [base::suppressWarnings()]
#'
#' @param expr An expression to evaluate
#' @param fun A function to _muffle_ (or _wuffle_)
#' @param classes A character vector if classes to suppress
#' @return The result of `expr` or a `function` wrapping `fun`
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
#' @export
muffle <- function(expr, fun, classes = "message") {
  do_muffle("muffle", expr, fun, classes)
}

#' @export
#' @rdname muffle
wuffle <- function(expr, fun, classes = "warning") {
  do_muffle("wuffle", expr, fun, classes)
}

# helpers -----------------------------------------------------------------

do_muffle <- function(
    type = c("muffle", "wuffle"),
    expr,
    fun,
    classes,
    env = parent.frame()
) {
  type <- match.arg(type)

  if (missing(fun)) {
    fun <- switch(type, muffle = suppressMessages, wuffle = suppressWarnings)
    return(fun(expr = expr, classes = classes))
  }

  if (missing(expr)) {
    out <- as.function(alist(... = , ))
    out_body <- alist()
    out_body[[1]] <- substitute(get(type, asNamespace("fuj")))
    out_body$expr <- substitute(match.fun(fun)(...), env = env)
    out_body$classes <- classes
    body(out) <- as.call(out_body)
    environment(out) <- parent.frame(2)
    return(out)
  }

  stop(cond_muffle(type))
}

cond_muffle <- function(class = c("muffle", "wuffle")) {
  class <- match.arg(class)
  new_condition("only either `expr` or `fun` must be used", class = class)
}
