progress_bar <- function(
  max = 1,
  char = "=",
  width = NA,
  con = stdout()
) {
  local({
    self <- environment()
    reg.finalizer(self, function(e) e$kill(), onexit = TRUE)

    self$con <- con

    self$max <- max
    self$min <- 0

    self$style <- 3L
    self$value <- 0
    self$killed <- FALSE

    self$nb <- 0L
    self$pc <- -1L
    self$nw <- nchar(char, "w")

    if (self$nw == 0) {
      stop("'char' must have a non-zero width")
    }

    if (is.na(width)) {
      width <- getOption("width")
      width <- width - 10L

      if (self$nw > 1) {
        width <- trunc(width / self$nw)
      }
    }

    # nolint next: object_usage_linter.
    set <- function(value) {
      self$value <- max(min(value, max), min)
      nb <- round(width * self$.norm())
      pc <- round(100 * self$.norm())

      if (nb == self$nb && pc == self$pc) {
        return(invisible(self))
      }

      cat(paste0("\r  |", strrep(" ", self$nw * width + 6)), file = self$con)
      cat(
        paste(
          c(
            "\r  |",
            rep.int(char, nb),
            rep.int(" ", self$nw * (width - nb)),
            sprintf("| %3d%%", pc)
          ),
          collapse = ""
        ),
        file = self$con
      )
      flush(stdout())
      self$nb <- nb
      self$pc <- pc
      invisible(self)
    }

    # nolint next: object_usage_linter.
    .norm <- function(value) {
      (self$value - self$min) / (self$max - self$min)
    }

    # nolint next: object_usage_linter.
    kill <- function() {
      invisible()
      # not needed
      # if (self$killed) {
      #   return(invisible(self))
      # }
      #
      # cat("\n", file = self$con)
      # flush(stdout())
      # self$killed <- TRUE
      # invisible(self)
    }

    self$set(0L)
    invisible(self)
  })
}
