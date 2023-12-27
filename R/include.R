#' Include exports in Search Path
#'
#' Include (attach) a package and specific exports to Search Path
#'
#' @description [include()] checks whether or not the namespace has been loaded
#'   to the [base::search()] path.  It uses the naming convention
#'   `include:{package}` to denote the differences from loading via
#'   [base::library()] or [base::require()]. When `exports` is `NULL`, the
#'   environment is detached from the search path if found.  When `exports` is
#'   not `NULL`,
#'
#'   **Note:** This function has the specific purpose of affecting the search
#'   path.  Use `options(fuj.verbose = TRUE)` or `options(verbose = TRUE)` for
#'   more information.
#'
#' @param exports A character vector of exports.  When named, these exports will
#'   be aliases as such.
#' @inheritParams base::loadNamespace
#' @inheritParams base::attach
#' @param lib See `lib.loc` in [base::loadNamespace()]
#' @param warn See `warn.conflicts` in [base::attach()].  The default `NA`
#'   converts all `packageStartupMessage`s to `verboseMessage`s
#' @returns Nothing, called for its side-effects
#' @examples
#' # include(package) will ensure that the entire package is attached
#' include("fuj")
#' head(ls("include:fuj"), 20)
#' detach("include:fuj", character.only = TRUE)
#'
#' # include a single export
#' include("fuj", "collapse")
#'
#' # include multiple exports, and alias
#' include("fuj", c(
#'   no_names = "remove_names",
#'   match_any = "any_match"
#' ))
#'
#' # include an export where the alias has a warn conflict
#' include("fuj", c(attr = "exattr"))
#'
#' # note that all 4 exports are included
#' ls("include:fuj")
#'
#' # all exports are the same
#' identical(collapse, fuj::collapse)
#' identical(no_names, fuj::remove_names)
#' identical(match_any, fuj::any_match)
#' identical(attr, fuj::exattr)
#' @export
include <- function(
    package,
    exports = NULL,
    lib = .libPaths(),
    pos = 2L,
    warn = NULL
) {
  package <- as.character(substitute(package))
  loadNamespace(package, lib.loc = lib)

  if (is.null(exports)) {
    attach_name <- paste0("include:", package)
    detach2(attach_name)
    verbose("attaching '", attach_name, "' to the search path")
    attach2(
      x = asNamespace(package),
      pos = pos,
      name = attach_name,
      warn = warn
    )
    return(invisible())
  }

  nm <- names(exports) %||% exports
  attach_name <- paste0("include:", package)
  env <- match(attach_name, search())
  success <- FALSE

  if (is.na(env)) {
    success <- FALSE
    attach2(pos = pos, name = attach_name, warn = warn)
    on.exit(if (!success) detach2(attach_name))
    env <- pos
  } else {
    verbose("'", attach_name, "' found in search path at position ", env)
  }

  package <- asNamespace(package)
  env <- as.environment(env)
  for (i in seq_along(exports)) {
    assign(nm[i], getExportedValue(package, exports[i]), env)
  }
  check_conflicts(attach_name, warn = warn)
  success <- TRUE
  invisible()
}

detach2 <- function(
    name = search()[pos],
    pos = if (is.null(pattern)) 2 else grep(pattern, search(), ...),
    pattern = NULL,
    ...
) {
  force(pattern)
  force(pos)
  force(name)

  if (name %out% search()) {
    return()
  }

  ("base" %::% "detach")(name, character.only = TRUE)
}

attach2 <- function(
    x = NULL,
    pos = 2L,
    name = deparse1(substitute(x)),
    warn = NULL
) {
  if (name %in% search()) {
    return()
  }
  # the purpose of `include()` is to add it to the search path, so we do need to
  # use `attach()` here
  tryCatch({
    ("base" %::% "attach")(
      what = x,
      pos = pos,
      name = name,
      warn.conflicts = !isFALSE(warn)
    )
  }, packageStartupMessage = function(e) {
    # TODO this needs to be documented
    if (is.null(warn)) {
      verbose(e$message)
    } else if (isTRUE(warn)) {
      warning(cond_include_conflicts(e$message))
    } else if (isTRUE(is.na(warn))) {
      packageStartupMessage(e$message)
    }
  }, simpleMessage = function(e) {
    verbose(e$message)
  })
}

cond_include_conflicts <- function(msg) {
  new_condition(message = msg, class = "includeConflicts", type = "warning")
}

check_conflicts <- function(name, warn = NULL) {
  cons <- conflicts(detail = TRUE)[[name]]
  if (!length(cons)) {
    return()
  }

  # typically attach() uses 'by = FALSE'
  msg <- sprintf(
    "the following objects are masked from '%s':\n  %s",
    name,
    collapse(cons, sep = "\n  ")
  )

  if (is.null(warn)) {
    verbose(msg)
  } else if (isTRUE(warn)) {
    warning(cond_include_conflicts(msg))
  } else if (isTRUE(is.na(warn))) {
    packageStartupMessage(msg)
  }
}
