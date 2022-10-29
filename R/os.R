is_windows <- function() {
  Sys.info()[["sysname"]] == "Windows"
}

is_macos <- function() {
  Sys.info()[["sysname"]] == "Darwin"
}

is_linux <- function() {
  Sys.info()[["sysname"]] == "Linux"
}