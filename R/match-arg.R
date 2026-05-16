#' Match arguments
#'
#' Argument matching for an argument
#'
#' @description Much like [base::match.arg()] with a few key differences:
#' * Will not perform partial matching (by default)
#' * Will not return error messages with curly quotations
#' * Special handling for `NULL` values
#' * Allows recoding of values via named lists or lists of formulas
#'
#' @param arg The argument
#' @param choices The available choices; named lists will return the name (a
#'   character) for when matched to the value within the list element.  A list
#'   of formula objects (preferred) retains the LHS of the formula as the return
#'   value when matched to the RHS of the formula.
#' @param multiple If `TRUE` allows multiple values to be returned
#' @param partial If `TRUE` allows partial matching via [base::pmatch()]
#' @param null Controls how `arg = NULL` is handled
#' @return A single value from `arg` matched on `choices`
#'
#' @examples
#' fruits <- function(x = c("apple", "banana", "orange")) {
#'   match_arg(x)
#' }
#'
#' fruits()         # apple
#' try(fruits("b")) # must be exact fruits("banana")
#'
#' pfruits <- function(x = c("apple", "apricot", "banana")) {
#'   match_arg(x, partial = TRUE)
#' }
#' pfruits()          # apple
#' try(pfruits("ap")) # fuj:arg_match_error
#' pfruits("app")     # apple
#'
#' afruits <- function(x = c("apple", "banana", "orange")) {
#'   match_arg(x, multiple = TRUE)
#' }
#'
#' afruits() # apple, banana, orange
#'
#' # can have multiple responses
#' how_much <- function(x = list(too_few = 0:2, ok = 3:5, too_many = 6:10)) {
#'   match_arg(x)
#' }
#'
#' how_much(1)
#' how_much(3)
#' how_much(9)
#'
#' # use a list of formulas instead
#' ls <- list(1L ~ 0:1, 2L, 3L ~ 3:5)
#' sapply(0:5, match_arg, choices = ls)
#' @export
match_arg <- function(
  arg,
  choices,
  multiple = FALSE,
  partial = getOption("fuj.match_arg.partial", FALSE),
  null = c("error", "first", "all", "null")
) {
  nulls <- c("error", "first", "all", "null")
  null_arg <- do_match_arg(null, nulls, FALSE, FALSE)

  if (inherits(null_arg, "_match_arg_error")) {
    stop(match_arg_error(
      expr = str2lang("null"),
      value = null,
      choices = eval(formals(match_arg)$null)
    ))
  }

  expr <- as.expression(substitute(arg))
  force(arg)

  if (is.null(arg)) {
    switch(
      null_arg$value,
      null = return(NULL),
      first = return(match_arg(choices, choices)),
      all = return(match_arg(choices, choices, multiple = TRUE)),
      error = stop(input_error("NULL is not an allowed value for arg")),
      stop(internal_error()) # nocov
    )
  }

  missing_choices <- missing(choices)
  if (missing_choices) {
    parent <- sys.parent()
    forms <- formals(sys.function(parent))
    choices <- eval(forms[[as.character(expr)]], envir = parent)
  }

  marg <- cleanup_arg_list(arg)
  mchoices <- cleanup_arg_list(choices)

  if (anyDuplicated(all_choices <- unlist(mchoices$choices))) {
    bad <- unique(all_choices[duplicated(all_choices)])
    stop(value_error("multiple values in choices: ", toString(bad)))
  }

  res <- do_match_arg(marg$choices, mchoices$choices, multiple, partial)

  if (inherits(res, "_match_arg_error")) {
    stop(match_arg_error(
      expr = expr,
      value = arg,
      choices = choices
    ))
  }

  res$value
}

do_match_arg <- function(arg, choices, multiple, partial) {
  m <- (if (partial) pmatch else match)(arg, choices)
  m <- remove_na(m)

  if (!length(m)) {
    return(struct(list(), "_match_arg_error"))
  }

  if (!multiple) {
    m <- m[1L]
  }

  list(match = m, value = unlist(choices[m], use.names = FALSE))
}

cleanup_arg_list <- function(x) {
  x <- as.list(x)
  env <- parent.frame()

  eval_expr <- function(x, i) {
    eval(as.expression(x[[i]]), env)
  }

  out <- list(values = NULL, choices = NULL)
  nms <- names(x)
  for (i in seq_along(x)) {
    if (inherits(x[[i]], "formula")) {
      out$values[[i]] <- eval_expr(x[[i]], 2L)
      out$choices[[i]] <- eval_expr(x[[i]], 3L)
    } else {
      out$values[[i]] <- if (isTRUE(nzchar(nms[i]))) nms[i] else x[[i]]
      out$choices[[i]] <- x[[i]]
    }
  }

  out$values <- rep(out$values, lengths(out$choices))
  out$choices <- unlist(lapply(out$choices, as.list), recursive = FALSE)
  out
}

match_arg_error <- function(expr, value, choices) {
  new_condition(
    message = sprintf(
      "fuj::match_arg(%s) failed: `%s` is not one of `%s`",
      as.character(expr),
      deparse(value),
      deparse(choices)
    ),
    class = "match_arg",
    type = "error",
    package = "fuj"
  )
}
