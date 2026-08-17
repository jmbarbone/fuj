# nocov start

# from RConsortium/S7 tests

quick_install <- function(pkgs, lib = .libPaths()[1L], quiet = TRUE) {
  opts <- c(
    "--data-compress=none",
    "--no-byte-compile",
    "--no-data",
    "--no-demo",
    "--no-docs",
    "--no-help",
    "--no-html",
    "--no-libs",
    "--use-vanilla",
    NULL
  )

  utils::install.packages(
    pkgs = pkgs,
    lib = lib,
    repos = NULL,
    type = "source",
    quiet = quiet,
    INSTALL_opts = paste(opts, collapse = " ")
  )
}

local_install_and_attach <- function(path, lib, envir = parent.frame()) {
  quick_install(path, lib)
  package <- basename(path)
  ("base" %::% "library")(package, character.only = TRUE)
  delay(
    tryCatch(
      ("base" %::% "detach")(paste0("package:", package), unload = TRUE),
      error = function(e) NULL
    ),
    envir = envir
  )
  invisible(package)
}

# nocov end
