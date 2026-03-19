#' Arithmetic wrappers
#'
#' @name alias_arithmetic
#' @return See [base::Arithmetic]
#' @examples
#'         add(7, 2) # +
#'    subtract(7, 2) # -
#'    multiply(7, 2) # *
#'      divide(7, 2) # /
#' raise_power(7, 2) # ^
#'   remainder(7, 2) # %%
#'  divide_int(7, 2) # %/%
NULL

#' @export
#' @usage NULL
#' @rdname alias_arithmetic
add <- base::`+`

#' @export
#' @rdname alias_arithmetic
#' @usage NULL
subtract <- base::`-`

#' @export
#' @rdname alias_arithmetic
#' @usage NULL
multiply <- base::`*`

#' @export
#' @rdname alias_arithmetic
#' @usage NULL
divide <- base::`/`

#' @export
#' @rdname alias_arithmetic
#' @usage NULL
raise_power <- base::`^`

#' @export
#' @rdname alias_arithmetic
#' @usage NULL
remainder <- base::`%%`

#' @export
#' @rdname alias_arithmetic
#' @usage NULL
divide_int <- base::`%/%`
