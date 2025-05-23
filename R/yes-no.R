#' Yes-no prompt
#'
#' Prompts the user to make a yes/no selection
#'
#' @param ... text to display
#' @param na Text for an NA response.  When NULL, will not provide a possible NA
#' response.  When
#' @param n_yes,n_no The number of yes/no selections
#' @param noninteractive_error While `TRUE`, throws an error when the session
#' is not interactive.  If `FALSE`, will return `NA` instead.
yes_no <- function(
  ...,
  na = NULL,
  n_yes = 1,
  n_no = 2,
  noninteractive_error = TRUE
) {
  override <- getOption("fuj..yes_no.interactive_override")
  is_override <- !is.null(override)

  if (!is_override) {
    if (!interactive()) {
      if (noninteractive_error) {
        stop(cond_yes_no_interactive())
      }
      return(NA)
    }
  } else {
    warning(cond_yes_no_interactive_override())
    # apply on exit so we can test continuous bad responses
    on.exit(options(fuj..yes_no.interactive_override = NULL))
    # do not produce any messages
    cat <- function(...) invisible()
  }

  # basically a rewrite of yesno::yesno()
  msg <- paste0(..., collapse = "")

  yes <- c(
    "Yes",
    "You betcha",
    "Certainly",
    "Absolutely",
    "Of course"
  )

  no <- c(
    "No",
    "Absolutely not",
    "Certainly not",
    "No way",
    "Not a chance",
    "Let me think about it",
    "Not sure",
    "I don't know"
  )

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

    res <- override %||% readline("selection: ")
    res <- wuffle(as.integer(res))

    if (is.na(res)) {
      cat("... enter a numeric response\n")
      next
    }

    if (res == 0) {
      return(NULL)
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

cond_yes_no_interactive <- function() {
  new_condition(
    collapse(
      "yes_no() must be used in an interactive session when",
      "`noninteractive_error` is `TRUE`"
    ),
    "yes_no_interactive"
  )
}

# nolint next: object_length_linter.
cond_yes_no_interactive_override <- function() {
  new_condition(
    collapse(
      "options(fuj..yes_no.interactive_override) was set to TRUE.",
      "\n This should only be set by developers for testing.",
      "Value is being reset to NULL."
    ),
    "yes_no_interactive_override",
    type = "warning"
  )
}
