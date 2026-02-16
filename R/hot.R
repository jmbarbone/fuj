#' Hold or Toss
#'
#' @param x A vector of values
#' @param i An indication of which subset values to action.  This can be a
#'   logical vector, an integer vector, or a function that takes `x` as an
#'   argument and returns a logical or integer vector
#' @param na How to handle `NA` values in when `p` is a logical vector, or a
#'   function that returns a logical vector. [fuj::hold()] defaults to dropping
#'   `NA` values, while [fuj::toss()] defaults to keeping `NA` values.  When `p`
#'   is an integer vector, `NA` values are always dropped.
#' @name hot
#' @examples
#' x <- c(1, NA, 3, 4, Inf, 6)
#' twos <- function(x) x %% 2 == 0
#' hold(x, twos) # 4, 6
#' toss(x, twos) # 1, 3, NA, Inf
#'
#' hold(x, twos, na = "keep") # NA, 4, Inf, 6
#' toss(x, twos, na = "drop") # 1, 3
#'
#' i <- c(1:3, NA)
#' x <- letters[1:5]
#' hold(x, i)
#' toss(x, i)
#'
#' @returns
#' - [fuj::hold()] **retains** values in `x` matched against `i`
#' - [fuj::toss()] **removes** values in `x` matched against `i`
NULL

#' @rdname hot
#' @export
hold <- function(x, i, na = c("drop", "keep")) {
  na <- match.arg(na, c("drop", "keep"))

  if (inherits(i, "logical")) {
    i[is.na(i)] <- na == "keep"
    return(x[i])
  }

  if (integerish(i)) {
    return(x[i[!is.na(i)]])
  }

  if (is.function(i)) {
    return(hold(x, vap_vec(x, i), na = na))
  }

  stop(hot_input_error())
}


#' @rdname hot
#' @export
toss <- function(x, i, na = c("keep", "drop")) {
  na <- match.arg(na, c("keep", "drop"))

  if (is.logical(i)) {
    i[is.na(i)] <- na == "drop"
    return(x[!i])
  }

  if (integerish(i)) {
    return(x[-i[!is.na(i)]])
  }

  if (is.function(i)) {
    return(toss(x, vap_vec(x, i), na = na))
  }

  stop(hot_input_error())
}

hot_input_error <- function() {
  input_error(
    "i must be logical, integer, integer-like numeric, or function which",
    " returns a logical, integer, or integer-like numeric"
  )
}
