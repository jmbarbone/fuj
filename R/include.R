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
#' @param warn_conflicts See `warn.conflicts` in [base::attach()].  The default
#'   `NA` converts all `packageStartupMessage`s to `verboseMessage`s
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

    if (attach_name %in% search()) {
      ("base" %::% "detach")(attach_name, character.only = TRUE)
    }

    verbose("attaching '", attach_name, "' to the search path")
    attach2(
      what = asNamespace(package),
      pos = pos,
      name = attach_name,
      warn = warn
    )
    return(invisible())
  }

  nm <- names(exports)

  if (is.null(nm)) {
    nm <- exports
  }

  attach_name <- paste0("include:", package)
  m <- match(attach_name, search())
  success <- FALSE

  if (is.na(m)) {
    success <- FALSE
    attach2(
      what = NULL,
      pos = pos,
      name = attach_name,
      warn = warn
    )
    on.exit(if (!success) {
      ("base" %::% "detach")(attach_name, character.only = TRUE)
    })
  } else {
    verbose("'", attach_name, "' found in search path at position ", m)
    m <- pos
  }

  package <- asNamespace(package)

  for (i in seq_along(exports)) {
    assign(nm[i], getExportedValue(package, exports[i]), m)
  }

  invisible()
}

attach2 <- function(
    what,
    pos = 2L,
    name = deparse1(substitute(what)),
    warn = NULL
) {
  # the purpose of `include()` is to add it to the search path, so we do need to
  # use `attach()` here
  tryCatch({
    ("base" %::% "attach")(
      what = what,
      pos = pos,
      name = name,
      warn.conflicts = !isFALSE(warn)
    )
  }, packageStartupMessage = function(e)
    if (is.null(warn)) {
      verbose(e$message)
    } else if (isTRUE(warn)) {
      warning(cond_include_conflicts(e$message))
    } else if (isTRUE(is.na(warn))) {
      verbose(e$message)
  })
}

cond_include_conflicts <- function(msg) {
  new_condition(message = msg, class = "includeConflicts", type = "warning")
}
