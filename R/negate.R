#' Negations
#'
#' Negate an outcome or function
#'
#' @description [fuj::not()] is an _alias_ for [base::!].  [fuj::negate()] is
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
not <- function(x) !x

# nolint start: commented_code_linter.
# NOTE "!" uses an _unnamed_ argument
#
# ```r
# `!`(x = FALSE)
# #> TRUE
# `!`(this_can_be_whatever = FALSE)
# #> TRUE
# formals(`!`)
# #> NULL
# ```
# nolint end: commented_code_linter.

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
    # this has to be formatted as a call so that we appropriate envoke UseMethod
    list(
      ..call.. = eval(substitute(
        as.call(c(..fun.., lapply(names(forms), str2lang))),
        list(..fun.. = fun)
      ))
    )
  )
  neg
}
