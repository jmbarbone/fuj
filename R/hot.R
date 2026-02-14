#' Hold or Toss
#'
#'
#' @param x A vector of values
#' @param p A preditive.  This can be a logical vector, an integer vector, or a
#'   function that takes `x` as an argument and returns a logical or integer
#'   vector.
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
#' - [fuj::hold()] **retains** values in `x` that are returned as `true` through `p`
#' - [fuj::toss()] **removes** values in `x` that are returned as `true` through `p`
NULL

#' @rdname hot
#' @export
hold <- function(x, p, na = c("drop", "keep")) {
  na <- match.arg(na, c("drop", "keep"))

  if (inherits(p, "logical")) {
    p[is.na(p)] <- na == "keep"
    return(x[p])
  }

  if (integerish(p)) {
    return(x[p[!is.na(p)]])
  }

  if (is.function(p)) {
    return(hold(x, vap_vec(x, p), na = na))
  }

  stop(hot_input_error())
}


#' @rdname hot
#' @export
toss <- function(x, p, na = c("keep", "drop")) {
  na <- match.arg(na, c("keep", "drop"))

  if (is.logical(p)) {
    p[is.na(p)] <- na == "drop"
    return(x[!p])
  }

  if (integerish(p)) {
    return(x[-p[!is.na(p)]])
  }

  if (is.function(p)) {
    return(toss(x, vap_vec(x, p), na = na))
  }

  stop(hot_input_error())
}

hot_input_error <- function() {
  input_error(
    "p must be logical, integer, integer-like numeric, or function which",
    " returns a logical, integer, or integer-like numeric"
  )
}
