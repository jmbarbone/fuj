#' Negations
#'
#' Negate an outcome or function
#'
#' @description [fuj::not()] is an alias for [base::!].  [fuj::negate()] is
#' a variation of [base::Negate()] with an extra steps to preserve the original
#' function and maintain the function formals.
#'
#' @examples
#' identical(not(TRUE), FALSE)
#'
#' different <- negate(identical)
#' different(formals(identical), formals(identical))
#'
#' @name negate
NULL

#' @rdname negate
#' @export
#' @param x An object
#' @returns [fuj::not()] See [base::!]
not <- base::`!`

#' @rdname negate
#' @export
#' @param fun A function
#' @returns [fuj::negate()] A `function`, which is the negation of `fun`
negate <- function(fun) {
  forms <- formals(match.fun(fun))
  fun <- substitute(fun)
  neg <- function() {}
  formals(neg) <- forms
  body(neg) <- substitute(
    not(..call..),
    list(
      ..call.. = eval(substitute(
        as.call(c(..fun.., lapply(names(forms), str2lang))),
        list(..fun.. = fun)
      ))
    )
  )
  neg
}
