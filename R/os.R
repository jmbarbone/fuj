
#' Determine operating systems
#'
#' @returns `TRUE` or `FALSE`
#' @name os
NULL

# nocov start

#' @export
#' @rdname os
is_windows <- function() {
  Sys.info()[["sysname"]] == "Windows"
}

#' @export
#' @rdname os
is_macos <- function() {
  Sys.info()[["sysname"]] == "Darwin"
}

#' @export
#' @rdname os
is_linux <- function() {
  Sys.info()[["sysname"]] == "Linux"
}

# nocov end
