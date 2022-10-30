
#' Listing for dots
#'
#' Tries to not complain about empty arguments
#'
#' @param ... Arguments to collect in a list
#' @returns A `list` of `...`
#' @export
#' @examples
#' try(list(1,))
#' list0(1,)
list0 <- function(...) {
  mc <- match.call()
  parent <- parent.frame()
  tryCatch(
    list(...),
    error = function(e) {
      if (identical(e$message, "argument is missing, with no default")) {
        return(eval(mc[seq_len(...length())], envir = parent))
      }

      mc[1] <- call("list")
      eval(mc, envir = parent)
    }
  )
}
