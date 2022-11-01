#' Determine operating systems
#'
#' @return `TRUE` or `FALSE`
#' @examples
#' is_windows()
#' is_macos()
#' is_linux()
#' @name os
NULL

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
