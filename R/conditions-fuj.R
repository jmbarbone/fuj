# fuj internal conditions

# conditions --------------------------------------------------------------

info_condition <- function(..., .bare = FALSE, .class = NULL) {
  cond <- new_condition(
    message = c(...),
    class = list("info", .class),
    type = "condition",
    package = "fuj"
  )
  if (.bare) {
    cond$message <- c(...)
  }
  cond
}

# NOTE This might be subject to change.
inform <- function(..., .bare = FALSE, .class = NULL) {
  withRestarts(
    expr = {
      info <- info_condition(..., .bare = .bare, .class = .class)
      signalCondition(info)
      cat(conditionMessage(info), "\n", sep = "")
    },
    muffle_condition = function(cnd) NULL
  )
}

suppress_info <- function(expr, classes = "info_condition") {
  withCallingHandlers(
    expr,
    info_condition = function(cnd) {
      if (inherits(cnd, classes)) {
        tryInvokeRestart("muffle_condition")
      }
    }
  )
}
