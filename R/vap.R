# builders ----------------------------------------------------------------

# nocov start
vap_ <- function(type) {
  # nolint next: object_usage_linter.
  expr <- substitute(
    {
      delayedAssign("..call", sys.call())
      set_vap_names(as.vector(vap(x, f, ...), ..type..), x)
    },
    list(..type.. = type)
  )
  eval(substitute(as.function(alist(x = , f = , ... = , expr))))
}

vapi_ <- function(type) {
  # nolint next: object_usage_linter.
  expr <- substitute(
    set_vap_names(
      {
        delayedAssign("..call", sys.call())
        as.vector(vap2(x, names(x) %||% seq_along(x), f, ...), ..type..)
      },
      x
    ),
    list(..type.. = type)
  )
  eval(substitute(as.function(alist(x = , f = , ... = , expr))))
}

vap2_ <- function(type) {
  # nolint next: object_usage_linter.
  expr <- substitute(
    {
      delayedAssign("..call", sys.call())
      set_vap_names(as.vector(vap2(x, y, f, ...), ..type..), x)
    },
    list(..type.. = type)
  )
  eval(substitute(as.function(alist(x = , y = , f = , ... = , expr))))
}

vap3_ <- function(type) {
  # nolint next: object_usage_linter.
  expr <- substitute(
    {
      delayedAssign("..call", sys.call())
      set_vap_names(as.vector(vap3(x, y, z, f, ...), ..type..), x)
    },
    list(..type.. = type)
  )
  eval(substitute(as.function(alist(x = , y = , z = , f = , ... = , expr))))
}

vapp_ <- function(type) {
  # nolint next: object_usage_linter.
  expr <- substitute(
    {
      delayedAssign("..call", sys.call())
      set_vap_names(as.vector(vapp(p, f, ...), ..type..), p[[1L]])
    },
    list(..type.. = type)
  )
  eval(substitute(as.function(alist(p = , f = , ... = , expr))))
}

vap_dates_ <- function(fun, type) {
  fun <- substitute(fun)
  func <- as.character(fun)

  fun_call <- switch(
    func,
    vap = quote(vap_dbl(x, f, ...)),
    vapi = quote(vapi_dbl(x, f, ...)),
    vap2 = quote(vap2_dbl(x, y, f, ...)),
    vap3 = quote(vap3_dbl(x, y, z, f, ...)),
    vapp = quote(vapp_dbl(p, f, ...))
  )

  fun <- match.fun(fun)

  # nolint next: object_usage_linter.
  expr <- substitute(
    {
      res <- ..FUN_CALL.. # nolint: object_usage_linter.
      set_vap_names(..TYPE.., res)
    },
    list(
      ..FUN_CALL.. = fun_call,
      ..TYPE.. = switch(
        type,
        date = quote(as.Date(res, origin = "1970-01-01")),
        dttm = quote(as.POSIXct(res, origin = "1970-01-01", tz = "UTC"))
      )
    )
  )

  out <- function() NULL
  formals(out) <- formals(fun)
  body(out) <- substitute(expr)
  out
}
# nocov end

#' Vector applies
#'
#' Alternative to [lapply()], [sapply()], [vapply()], and [mapply()]
#'
#' @details Also includes `_date`, `_dttm` variants that work with `Date` and
#'   `POSIXct` types.
#'
#' - `vap()` uses a single `x` argument
#' - `vapi()` uses a single `x` argument and passes the names (when available,
#'   otherwise index) as the second argument
#' - `vap2()`, `vap3()` use two and three arguments, respectively
#' - `vapp()` uses a pairlist of arguments
#'
#' @section Extras: Two helper functions are provided to set options for a
#'   progress bars (`options(fuj.vap.progress)`) and reporting an index during
#'   and error (`options(fuj.vap.index_error)`).  Two wrapper functions are
#'   provided: [with_vap_progress()] and [with_vap_handlers()], respectively;
#'   the latter may include other handlers in the future.  These are not turned
#'   on by default (or rather, the option settings are set to `FALSE` within
#'   `{fuj}`) as they incur some additional overhead.
#'
#' @param x,y,z Values to map over
#' @param f Function or specification of function to apply.
#' @param p Pairlist of values to map over
#' @param ... Additional arguments passed to `f`
#' @param expr The expression to evaluate.
#'
#' @returns Return for `vap2`, `vap3`, and `vapp` variants, return length is
#'   determined by how `...` is recycled inside [mapply()].  For `vap`, `vapi`,
#'   variants, a vector the length of `x` is returned.
#'
#'   `vap_*()` variants return a vector of the specified type.
#'
#'   [with_vap_progress()] sets an option `vap.progress` to `TRUE` for the
#'   duration of `expr`, which causes a progress bar to be displayed for any
#'   `vap*` calls inside `expr`.
#'
#'   [with_vap_handlers()] sets an option `vap.indexed_errors` to `TRUE` for the
#'   duration of `expr`, which causes errors inside `vap*` calls to include the
#'   index at which the error occurred.
#'
#' @examples
#' vap(letters, toupper)
#' vapi(letters, function(x, i) paste0(i, ": ", toupper(x)))
#' vap_int(set_names(month.name, month.abb), nchar)
#' vap2_dbl(1:5, 6:10, `+`)
#' vapp_int(list(x = 1:5, y = 6:10, z = 11:15), sum)
#'
#' # when f is a character or number, subsetting is performed
#' x <- list(list(a = 1, b = 3), list(a = 2, b = 4))
#' vap_int(x, "a")
#' vap_int(x, 2)
#'
#' # wrap in [with_vap_progress()] to show a progress bar
#' invisible(
#'   with_vap_progress(
#'     vap(1:10 / 20, Sys.sleep)
#'   )
#' )
#'
#' # wrap in [with_vap_handlers()] to report index on error
#' try(
#'   with_vap_handlers(
#'     vap(10:1, function(x) if (x == 3) stop("bad"))
#'   )
#' )
#' @name vap
NULL

# vaps --------------------------------------------------------------------

#' @export
#' @rdname vap
vap <- function(x, f, ...) {
  delayedAssign("..call", sys.call()) # nolint: object_name_linter, object_usage_linter.
  f <- vapper(f, list(x))
  vapping_handler(lapply(x, f, ...), f)
}

#' @export
#' @rdname vap
vapi <- function(x, f, ...) {
  delayedAssign("..call", sys.call()) # nolint: object_name_linter, object_usage_linter.
  i <- names(x) %||% seq_along(x)
  f <- vapper(f, list(x))
  out <- vapping_handler(.mapply(f, list(x, i), list(...)), f)
  set_vap_names(out, x)
}

#' @export
#' @rdname vap
vap2 <- function(x, y, f, ...) {
  delayedAssign("..call", sys.call()) # nolint: object_name_linter, object_usage_linter.
  f <- vapper(f, list(x, y))
  out <- vapping_handler(.mapply(f, list(x, y), list(...)), f)
  set_vap_names(out, x)
}

#' @export
#' @rdname vap
vap3 <- function(x, y, z, f, ...) {
  delayedAssign("..call", sys.call()) # nolint: object_name_linter, object_usage_linter.
  f <- vapper(f, list(x, y, z))
  out <- vapping_handler(.mapply(f, list(x, y, z), list(...)), f)
  set_vap_names(out, x)
}

#' @export
#' @rdname vap
vapp <- function(p, f, ...) {
  delayedAssign("..call", sys.call()) # nolint: object_name_linter, object_usage_linter.
  f <- vapper(f, p)
  p <- as.pairlist(p)
  out <- vapping_handler(.mapply(f, p, list(...)), f)
  set_vap_names(out, p[[1L]])
}

# vap ---------------------------------------------------------------------

#' @export
#' @rdname vap
vap_lgl <- vap_("logical")

#' @export
#' @rdname vap
vap_int <- vap_("integer")

#' @export
#' @rdname vap
vap_dbl <- vap_("double")

#' @export
#' @rdname vap
vap_chr <- vap_("character")

#' @export
#' @rdname vap
vap_raw <- vap_("raw")

#' @export
#' @rdname vap
vap_cpl <- vap_("complex")

#' @export
#' @rdname vap
vap_date <- vap_dates_(vap, "date")

#' @export
#' @rdname vap
vap_dttm <- vap_dates_(vap, "dttm")

# vapi --------------------------------------------------------------------

#' @export
#' @rdname vap
vapi_lgl <- vapi_("logical")

#' @export
#' @rdname vap
vapi_int <- vapi_("integer")

#' @export
#' @rdname vap
vapi_dbl <- vapi_("double")

#' @export
#' @rdname vap
vapi_chr <- vapi_("character")

#' @export
#' @rdname vap
vapi_raw <- vapi_("raw")

#' @export
#' @rdname vap
vapi_cpl <- vapi_("complex")

#' @export
#' @rdname vap
vapi_date <- vap_dates_(vapi, "date")

#' @export
#' @rdname vap
vapi_dttm <- vap_dates_(vapi, "dttm")

# vap2 --------------------------------------------------------------------

#' @export
#' @rdname vap
vap2_lgl <- vap2_("logical")

#' @export
#' @rdname vap
vap2_int <- vap2_("integer")

#' @export
#' @rdname vap
vap2_dbl <- vap2_("double")

#' @export
#' @rdname vap
vap2_chr <- vap2_("character")

#' @export
#' @rdname vap
vap2_raw <- vap2_("raw")

#' @export
#' @rdname vap
vap2_cpl <- vap2_("complex")

#' @export
#' @rdname vap
vap2_date <- vap_dates_(vap2, "date")

#' @export
#' @rdname vap
vap2_dttm <- vap_dates_(vap2, "dttm")

# vap3 --------------------------------------------------------------------

#' @export
#' @rdname vap
vap3_lgl <- vap3_("logical")

#' @export
#' @rdname vap
vap3_int <- vap3_("integer")

#' @export
#' @rdname vap
vap3_dbl <- vap3_("double")

#' @export
#' @rdname vap
vap3_chr <- vap3_("character")

#' @export
#' @rdname vap
vap3_raw <- vap3_("raw")

#' @export
#' @rdname vap
vap3_cpl <- vap3_("complex")

#' @export
#' @rdname vap
vap3_date <- vap_dates_(vap3, "date")

#' @export
#' @rdname vap
vap3_dttm <- vap_dates_(vap3, "dttm")

# vapp --------------------------------------------------------------------

#' @export
#' @rdname vap
vapp_lgl <- vapp_("logical")

#' @export
#' @rdname vap
vapp_int <- vapp_("integer")

#' @export
#' @rdname vap
vapp_dbl <- vapp_("double")

#' @export
#' @rdname vap
vapp_chr <- vapp_("character")

#' @export
#' @rdname vap
vapp_raw <- vapp_("raw")

#' @export
#' @rdname vap
vapp_cpl <- vapp_("complex")

#' @export
#' @rdname vap
vapp_date <- vap_dates_(vapp, "date")

#' @export
#' @rdname vap
vapp_dttm <- vap_dates_(vapp, "dttm")

# progress ----------------------------------------------------------------

#' @export
#' @rdname vap
with_vap_progress <- function(expr) {
  with_options(list(fuj.vap.progress = TRUE), expr)
}

#' @export
#' @rdname vap
with_vap_handlers <- function(expr) {
  with_options(list(fuj.vap.indexed_errors = TRUE), expr)
}

# helpers -----------------------------------------------------------------

vapper <- function(f, l) {
  # could just do an S3 dispatch, but I don't feel like exporting this
  delayedAssign("..i", 0L) # nolint: object_name_linter.
  delayedAssign("..call", dynGet("..call")) # nolint: object_name_linter, object_usage_linter.)

  fun <- if (is.function(f)) {
    f
  } else if (is.character(f)) {
    eval(substitute(as.function(alist(x = , subset2(x, f)))))
  } else if (is.numeric(f)) {
    f <- as.integer(f)
    eval(substitute(as.function(alist(x = , subset2(x, f)))))
  } else {
    match.fun(f)
  }

  if (getOption("fuj.vap.progress", FALSE)) {
    # progress bar requires passing the index, so reporting errors is included
    n <- do.call(max, as.list(lengths(l)))
    # nolint next: object_name_linter.
    ..pb <- progress_bar(n)
    function(...) {
      ..i <<- ..i + 1L # nolint: object_name_linter.
      on.exit(..pb$set(..i), add = TRUE)
      fun(...)
    }
  } else if (getOption("fuj.vap.indexed_errors", FALSE)) {
    function(...) {
      ..i <<- ..i + 1L # nolint: object_name_linter.
      fun(...)
    }
  } else {
    fun
  }
}

vapping_handler <- function(expr, fun) {
  withCallingHandlers(
    expr,
    # TODO include warning?
    warning = function(con) {
      if (!getOption("fuj.vap.indexed_errors", FALSE)) {
        return()
      }

      e <- environment(fun)
      msg <- if (exists("..i", e, inherits = FALSE)) {
        sprintf(
          "warning at index: %i:\n %s",
          get("..i", e, inherits = FALSE),
          conditionMessage(con)
        )
      } else {
        conditionMessage(con)
      }

      cond <- struct(
        list(msg, environment(fun)$..call),
        class = c("vap_warning", class(con)),
        index = environment(fun)$..i,
        names = c("message", "call")
      )

      warning(cond)
    },
    error = function(con) {
      if (!getOption("fuj.vap.indexed_errors", FALSE)) {
        return()
      }

      e <- environment(fun)
      msg <- if (exists("..i", e, inherits = FALSE)) {
        sprintf(
          "error at index: %i:\n %s",
          get("..i", e, inherits = FALSE),
          conditionMessage(con)
        )
      } else {
        conditionMessage(con)
      }

      cond <- struct(
        list(msg, environment(fun)$..call),
        class = c("vap_error", class(con)),
        index = environment(fun)$..i,
        names = c("message", "call")
      )

      stop(cond)
    }
  )
}

set_vap_names <- function(x, y) {
  if (length(x) == length(y)) {
    names(x) <- names(y)
  }
  x
}
