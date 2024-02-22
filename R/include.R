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
#' @section `package` class handling: When `package` is a [name] or [AsIs],
#'   assumed an installed package.  When `package` is a file path (via
#'   [is_path()]) then `package` is assumed a file path.  When just a string, a
#'   viable path is checked first; if it doesn't exist, then it is assumed a
#'   package.
#'
#'   When the package is [source()]'d the name of the environment defaults to
#'   the base name of `x` (file extension removed).  However, if the object
#'   `.AttachName` is found in the sourced file, then that is used as the
#'   environment name for the [search()] path.
#'
#'   **Note:** [include()] won't try to _attach_ an environment a second time,
#'   however, when `package` is a path, it must be [source()]ed each time to
#'   check for the `.AttachName` object.  If there are any side effects, they
#'   will be repeated each time `include(path)` is called.
#'
#' @param package A package name.  This can be given as a [name] or a character
#'   string. See section `package` class handling.
#' @param exports A character vector of exports.  When named, these exports will
#'   be aliases as such.
#' @param lib See `lib.loc` in [base::loadNamespace()].
#' @param pos An integer specifying the position in the [search()] path to
#'   attach the new environment.
#' @param warn See `warn.conflicts` in [base::attach()], generally.  The default
#'   `NULL` converts all `messages`s with masking errors to `verboseMessage`s,
#'   `TRUE` converts to `includeConflictsWarning` messages, `NA` uses
#'   `packageStartupMessages`, and `FALSE` silently ignores conflicts.
#' @returns The attached environment, invisibly.
#' @examples
#' # include(package) will ensure that the entire package is attached
#' include(fuj)
#' head(ls("include:fuj"), 20)
#' detach("include:fuj", character.only = TRUE)
#'
#' # include a single export
#' include(fuj, "collapse")
#'
#' # include multiple exports, and alias
#' include(fuj, c(
#'   no_names = "remove_names",
#'   match_any = "any_match"
#' ))
#'
#' # include an export where the alias has a warn conflict
#' include(fuj, c(attr = "exattr"))
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
  if (is.name(match.call()$package)) {
    path <- FALSE
    package <- as.character(substitute(package))
  } else if (inherits(package, "AsIs")) {
    path <- FALSE
  } else {
    path <- is_path(package) || file.exists(package)
  }

  if (path) {
    env <- new.env()
    # Because the .AttachName variable needs to be searched, we need to source
    # the file first and then determine what the name is
    source(package, local = env, echo = FALSE, verbose = FALSE)

    name <- get0(
      ".AttachName",
      envir = env,
      ifnotfound = paste0("include:", gsub("\\.[Rr]$", "", basename(package)))
    )

    if (name %in% search()) {
      return(invisible())
    }

    attach2(
      x = env,
      pos = pos,
      name = get0(".AttachName", env, ifnotfound = name)
    )
    return(invisible(env))
  }

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

  ns <- asNamespace(package)
  env <- as.environment(env)
  for (i in seq_along(exports)) {
    assign(nm[i], getExportedValue(ns, exports[i]), env)
  }

  check_conflicts(attach_name, warn = warn)
  success <- TRUE
  invisible(env)
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
  },
  message = function(e) {
    if (grepl("following object", e$message, fixed = TRUE)) {
      attach_warn(warn, e$message)
    }
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

  attach_warn(warn, msg)
}

attach_warn <- function(warn, msg) {
  if (is.null(warn)) {
    verbose(msg)
  } else if (isTRUE(warn)) {
    warning(cond_include_conflicts(msg))
  } else if (isTRUE(is.na(warn))) {
    packageStartupMessage(msg)
  }
}
