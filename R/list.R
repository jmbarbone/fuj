#' Listing for dots
#'
#' Tries to not complain about empty arguments
#'
#' @param ... Arguments to collect in a list
#' @return A `list` of `...`
#' @examples
#' try(list(1, ))
#' list0(1, )
#' list0(a = 1, )
#' @export
list0 <- function(...) {
  mc <- match.call()
  out <- list()
  off <- 0L

  for (i in seq_len(...length())) {
    tryCatch(
      out <- append(out, ...elt(i)),
      error = function(e) {
        if (!identical(e$message, "argument is missing, with no default")) {
          e$call <- mc
          stop(e)
        }

        assign("off", 1L, parent.frame()$parentenv)
      }
    )
  }

  names(out) <- names(mc)[-1L][seq_len(i - off)]
  out
}
