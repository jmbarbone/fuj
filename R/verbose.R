#' Verbose
#'
#' Simple verbose condition handling
#'
#' @details [verbose()] can be safely placed in scripts to signal additional
#'   message conditions.  [verbose()] can be controlled with
#'   `options("verbose")` (the default) and an override,
#'   `options("fuj.verbose")`.  The latter can be set to a function whose result
#'   will be used for conditional evaluation.
#'
#'   [make_verbose()] allows for the creation of a custom verbose function.
#'
#' @param ... A message to display.  When `...` is `NULL` (and only `NULL`), no
#'   message will display.
#' @param .fill When `TRUE`, each new line will be prefixed with the verbose
#'   label (controlled through `options("fuj.verbose.fill")`)
#' @param .label A label to prefix the message with (controlled through
#'   `options("fuj.verbose.label")`)
#' @param .verbose When `TRUE` (or is a function when returns `TRUE`) prints out
#'   the message.
#' @returns None, called for its side-effects.  When conditions are met, will
#'   signal a `verboseMessage` condition.
#' @examples
#' op <- options(verbose = FALSE)
#' verbose("will not show")
#'
#' options(verbose = TRUE)
#' verbose("message printed")
#' verbose("multiple lines ", "will be ", "combined")
#' options(op)
#'
#' op <- options(fuj.verbose = function() TRUE)
#' verbose("function will evaluate")
#' verbose(NULL) # nothing
#' verbose(NULL, "something")
#' verbose(if (FALSE) {
#' "`if` returns `NULL` when not `TRUE`, which makes for additional control"
#' })
#' options(op)
#'
#' # make your own verbose
#' verb <- make_verbose("fuj.foo.bar")
#' verb("will not show")
#' options(fuj.foo.bar = TRUE)
#' verb("will show")
#' @export
verbose <- function(
    ...,
    .fill = getOption("fuj.verbose.fill"),
    .label = getOption("fuj.verbose.label"),
    .verbose = getOption("fuj.verbose", getOption("verbose"))
) {
  if (is.function(.verbose)) {
    .verbose <- .verbose()
  }

  if (isTRUE(.verbose)) {
    if (!(is.null(..1) && ...length() == 1L)) {
      message(verbose_message(..., .fill = .fill, .label = .label))
    }
  }

  invisible()
}

#' @param opt An option to use in lieu of `fun.verbose`.  Note:
#'   `options("fuj.verbose")` is temporarily set to `isTRUE(getOption(opt))`
#'   when the function is evaluate, but is reset to its original value on exit.
#' @rdname verbose
#' @export
make_verbose <- function(opt) {
  force(opt)
  as.function(
    c(alist(
      ... = ,
      .fill = getOption("fuj.verbose.fill"),
      .label = getOption("fuj.verbose.label")
    ), substitute({
      # nolint next: object_usage_linter.
      op <- options(fuj.verbose = isTRUE(getOption(opt)))
      on.exit(options(op))
      verbose(
        ...,
        .fill = getOption("fuj.verbose.fill"),
        .label = getOption("fuj.verbose.label")
      )
    }))
  )
}

verbose_message <- function(
    ...,
    .fill = getOption("fuj.verbose.fill"),
    .label = getOption("fuj.verbose.label"),
    .call = NULL
) {
  if (is.function(.label)) {
    .label <- eval(.label(), envir = parent.frame())
  }

  .label <- format(.label)
  if (length(.label) != 1L || !is.character(.label)) {
    stop(cond_verbose_label())
  }

  msg <- if (isTRUE(.fill)) {
    collapse(
      strwrap(
        strsplit(collapse(..., sep = " "), "\n", fixed = TRUE)[[1]],
        getOption("width") - nchar(.label),
        prefix = .label
      ),
      sep = "\n"
    )
  } else {
    .makeMessage(.label, ...)
  }

  struct(
    list(paste0(msg, "\n"), call),
    names = c("message", "call"),
    class = c("verboseMessage", "message", "condition")
  )
}

cond_verbose_label <- function() {
  new_condition(
    "`.label` must be a string of length 1",
    class = "verbose_message_label"
  )
}
