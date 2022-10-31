#' Listing for dots
#'
#' Tries to not complain about empty arguments
#'
#' @param ... Arguments to collect in a list
#' @return A `list` of `...`
#' @examples
#' try(list(1, ))
#' list0(1, )
#' @export
list0 <- function(...) {
  mc <- match.call()
  parent <- parent.frame()
  tryCatch(
    list(...),
    error = function(e) {
      if (identical(e$message, "argument is missing, with no default")) {
        return(eval(mc[seq_len(...length())], envir = parent))
      }
    }
  )
}
