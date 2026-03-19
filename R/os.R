# overwritten by .onLoad()
is_windows_ <- FALSE
is_macos_ <- FALSE
is_linux_ <- FALSE

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
is_windows <- function() is_windows_

#' @export
#' @rdname os
is_macos <- function() is_macos_

#' @export
#' @rdname os
is_linux <- function() is_linux_
