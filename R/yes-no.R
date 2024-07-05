#' Yes-no promprt
#' 
#' Prompts the user to make a yes/no selection
#' 
#' @param ... text to display
#' @param na Text for an NA response
#' @param n_yes,n_no The number of yes/no selections
yes_no <- function(
    ..., 
    na = NULL,
    n_yes = 1,
    n_no = 2
) {
  # basically a rewrite of yesno::yesno()
  msg <- paste0(..., collapse = "")
  yes <- c("Yes", "You betcha", "Certainly", "Absolutely", "Of course")
  no <- c("No", "Absolutely not", "Certainly not", "No way", "Not a chance",
  "Let me think about it", "Not sure", "I don't know")
  
  choices <- c(
    sample(c(sample(yes, n_yes), sample(no, n_no))),
    if (length(na)) sample(na, 1)
  )
  
  cat(msg)
  cat("\n")
  attempt <- 0
  
  repeat {
    if (attempt > 20) {
      stop("What are you doing?")
    }

    if (attempt %% 5L == 0L) {
      cat(sprintf("[%i] %s\n", seq_along(choices), choices), sep = "")
    }

    attempt <- attempt + 1L

    res <- readline("selection: ")

    res <- wuffle(as.integer(res))

    if (is.na(res)) {
      cat("... enter a numeric response\n")
      next
    }

    if (res == 0) {
      return(NULL)
    }
    
    if (res == 0) {
      return(NA)
    }
    
    res <- choices[res]
    
    if (res %in% yes) {
      return(TRUE)
    }
    
    if (res %in% no) {
      return(FALSE)
    }

    if (res %in% na) {
      return(NA)
    }

    cat("... select an appropriate item or 0 to exit\n")
  }
}