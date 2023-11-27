#' Require namespace
#'
#' @param package,... Package names
#' @return `TRUE` (invisibly) if found; otherwise errors
#' @examples
#' isTRUE(require_namespace("base")) # returns invisibly
#' try(require_namespace("1package")) # (using a purposefully bad name)
#' require_namespace("base", "utils")
#' try(require_namespace("base>=3.5", "utils>4.0", "fuj==10.0"))
#' @export
require_namespace <- function(package, ...) {
  package <- c(package, ...)
  comparisons <- regmatches(package, regexec(">=?|<=?|==", package))
  splits <- strsplit(package, comparisons, fixed = TRUE)

  for (i in seq_along(package)) {
    do_require_namespace(
      package = splits[[i]][1],
      version = splits[[i]][2],
      operator = comparisons[[i]]
    )
  }

  invisible(TRUE)
}

# helpers -----------------------------------------------------------------

do_require_namespace <- function(package, version, operator) {
  tryCatch(
    loadNamespace(package),
    packageNotFoundError = function(e) {
      stop(cond_namespace(package))
    }
  )

  if (identical(operator, character())) {
    return()
  }

  operator <- match.arg(trimws(operator), c(">", ">=", "==", "<=", "<"))
  version <- as.package_version(version)

  package_version <- function(package) {
    # already loaded the namespace
    if (package == "base") {
      return(getRversion())
    }

    as.package_version(
      get("spec", get(".__NAMESPACE__.", getNamespace(package)))[["version"]]
    )
  }

  if (switch(
    operator,
    `>` = package_version(package) > version,
    `>=` = package_version(package) >= version,
    `==` = package_version(package) == version,
    `<=` = package_version(package) <= version,
    `<` = package_version(package) < version,
    any = TRUE
  )) {
    stop(cond_namespace_version(package, version, operator))
  }
}

# conditions --------------------------------------------------------------

cond_namespace <- function(package) {
  new_condition(
    msg = sprintf(
      "No package found called '%s'",
      as.character(package)
    ),
    class = "namespace"
  )
}

cond_namespace_version <- function(package, version, operator) {
  new_condition(
    msg = sprintf(
      "Package '%s' not found with version %s%s",
      package,
      operator,
      format(version)
    ),
    class = "namespace_version"
  )
}
