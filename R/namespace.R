#' Require namespace
#'
#' Checks if a package is available and optionally meets a specific version
#' requirement.
#'
#' @description
#' [fuj::require_namespace()] is ultimately a _check_ which will produce an
#' error on the first package that is not available or meets version
#' requirements.  Although this returns `TRUE`, it is not intended to be used in
#' a conditional statement.  Future version may return `invisible()`.  For
#' conditional checks use [fuj::available_namespace()], which will return a
#' named logical instead.
#'
#' [fuj::is_namespace_available()] is an alias for [fuj::available_namespace()].
#'
#' @param package,... Package names
#' @examples
#' isTRUE(require_namespace("base")) # returns invisibly
#' try(require_namespace("1package")) # (using a purposefully bad name)
#' require_namespace("base", "utils")
#' try(require_namespace("base >= 3.5", "utils > 4.0", "fuj == 0.0"))
#'
#' # no error check
#' fuj0 <- if (!available_namespace("fuj == 0.0")) {
#'   "fuj 0.0 does not exist"
#' }
#' fuj0
#' @export
#' @return
#' - [require_namespace()] `TRUE` (invisibly) if found; otherwise errors
require_namespace <- function(package, ...) {
  package <- list(package, ...)
  specs <- lapply(package, \(spec) do.call(pkg_req_spec, as.list(spec)))
  lapply(specs, do_require_namespace)
  invisible(TRUE)
}

#' @rdname require_namespace
#' @export
#' @return
#' - [available_namespace()] A named `logical` vector of same length as input.
#'   Vector names are packages and values are `TRUE` if the package is available
#'   and meets the version requirement, otherwise `FALSE`.
available_namespace <- function(package, ...) {
  package <- list(package, ...)
  specs <- lapply(package, \(spec) do.call(pkg_req_spec, as.list(spec)))
  res <- vapply(
    specs,
    \(spec) do.call(do_available_namespace, spec)[["available"]],
    NA
  )
  names(res) <- vapply(specs, \(spec) spec[["package"]], "")
  res
}

#' @rdname require_namespace
#' @export
is_namespace_available <- available_namespace

# consider exporting?
pkg_req_spec <- function(package, op, version) {
  if (missing(op) && missing(version)) {
    splits <- strsplit(package, " ", fixed = TRUE)[[1L]]
    n <- length(splits)
    if (n == 1L) {
      op <- NULL
      version <- NULL
    } else if (n == 3L) {
      package <- splits[1L]
      op <- splits[2L]
      version <- splits[3L]
    } else {
      stop(input_error(
        "Invalid package requirement specification.  Package requirements must",
        " be in the form of '<package> <op> <version>' ",
        " (e.g., \"fuj >= 0.2.2\") or as a list of three elements, (e.g.,",
        " list(\"fuj\", \">=\", \"0.2.2\")).  Bad spec: ",
        package
      ))
    }
  }

  res <- list(
    package = package,
    op = if (!is.null(op)) pkg_op(op),
    version = if (!is.null(version)) as.package_version(version)
  )
  class(res) <- "pkg_req_spec"
  res
}

#' @export
print.pkg_req_spec <- function(x, ...) {
  if (is.null(x$op) && is.null(x$version)) {
    cat(x$package, "\n")
  } else {
    cat(x$package, x$op, format(x$version), "\n")
  }
  invisible(x)
}

# helpers -----------------------------------------------------------------

do_require_namespace <- function(spec) {
  res <- do.call(do_available_namespace, spec)
  if (!res[["available"]]) {
    stop(namespace_version_error(
      res[["package"]],
      res[["version"]],
      res[["op"]],
      res[["pkg_version"]]
    ))
  }
}


do_available_namespace <- function(package, version, op) {
  if (!is_pkg_available(package)) {
    return(list(available = FALSE, package = package))
  }

  if (is.null(op)) {
    return(list(available = TRUE, package = package))
  }

  op <- pkg_op(op)
  version <- as.package_version(version)
  pkg_version <- get_pkg_version(package)

  list(
    available = do.call(op, list(pkg_version, version)),
    package = package,
    version = version,
    op = op,
    pkg_version = pkg_version
  )
}

pkg_op <- function(op) {
  match_arg(op, c(">", ">=", "==", "<=", "<", "!="))
}

is_pkg_available <- function(package, lib = .libPaths()) {
  package %in% .packages(all.available = TRUE, lib.loc = lib)
}

get_pkg_path <- function(package) {
  if (isNamespaceLoaded(package)) {
    return(asNamespace(package)[[".__NAMESPACE__."]][["path"]])
  }

  for (path in file.path(.libPaths(), package)) {
    # getNamespaceInfo() uses file.access(), but I don't think we _need_ to?
    # if (file.access(path, 5L) == 0L) {
    if (file.exists(path)) {
      return(path)
    }
  }
}

get_pkg_version <- function(package) {
  # already loaded the namespace
  if (package %in% .base_packages) {
    return(getRversion())
  }

  version <- if (isNamespaceLoaded(package)) {
    asNamespace(package)[[".__NAMESPACE__."]][["spec"]][["version"]]
  } else {
    path <- get_pkg_path(package)
    if (file.exists(file <- file.path(path, "Meta", "package.rds"))) {
      readRDS(file)[["DESCRIPTION"]][["Version"]]
    } else if (file.exists(file <- file.path(path, "DESCRIPTION"))) {
      read.dcf(file)[, "Version"]
    }
  }

  as.package_version(version)
}

.base_packages <- c(
  "base",
  "tools",
  "utils",
  "grDevices",
  "graphics",
  "stats",
  "datasets",
  "methods",
  "grid",
  "parallel",
  "splines",
  "stats4",
  "tcltk",
  "compiler"
)

# conditions --------------------------------------------------------------

namespace_version_error <- function(package, version, op, pkg_version) {
  if (is.null(version)) {
    stop(namespace_error(package))
  }
  new_condition(
    message = paste(
      "Package version require not met:",
      sprintf(
        "%1$s is %2$s but %3$s%4$s is required.",
        package,
        format(pkg_version),
        op,
        format(version)
      )
    ),
    class = c("namespace_version", "namespace"),
    package = "fuj",
    type = "error"
  )
}
