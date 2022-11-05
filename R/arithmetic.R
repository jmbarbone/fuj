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
add <- `+`

#' @export
#' @rdname alias_arithmetic
#' @usage NULL
subtract <- `-`

#' @export
#' @rdname alias_arithmetic
#' @usage NULL
multiply <- `*`

#' @export
#' @rdname alias_arithmetic
#' @usage NULL
divide <- `/`

#' @export
#' @rdname alias_arithmetic
#' @usage NULL
raise_power <- `^`

#' @export
#' @rdname alias_arithmetic
#' @usage NULL
remainder <- `%%`

#' @export
#' @rdname alias_arithmetic
#' @usage NULL
divide_int <- `%/%`
