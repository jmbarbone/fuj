test_that("include() works", {
  skip_if_not_installed("parallel")
  old <- search()
  on.exit(detach2("include:parallel"))
  include("parallel")
  expect_identical(setdiff(search(), old), "include:parallel")
})

test_that("include() works with exports", {
  skip_if_not_installed("parallel")
  old <- search()
  on.exit(detach2("include:parallel"))
  include("parallel", "clusterApply")
  include("parallel", c(n_cores = "detectCores"))
  expect_identical(setdiff(search(), old), "include:parallel")
  expect_identical(clusterApply, "parallel" %::% "clusterApply")
  expect_identical(n_cores, "parallel" %::% "detectCores")
})

test_that("include() works with conflicts", {
  foo <- 1

  with_include_fuj <- function(code) {
    op <- options(verbose.fuj = TRUE)
    on.exit({
      options(op)
      detach2("include:fuj")
    })
    force(code)
  }

  with_include_fuj({
    expect_message(include("fuj", c(foo = "include"), warn = FALSE), NA)
  })

  with_include_fuj({
    expect_warning(
      include("fuj", c(foo = "include"), warn = TRUE),
      class = "includeConflictsWarning",
    )
  })

  with_include_fuj({
    expect_message(
      include("fuj", c(foo = "include"), warn = NA),
      class = "packageStartupMessage"
    )
  })

  with_include_fuj({
    expect_message(
      include("fuj", c(foo = "include"), warn = NULL),
      class = "verboseMessage",
    )
  })

  with_include_fuj({
    expect_warning(
      include("fuj", c(foo = "include"), warn = TRUE),
      class = "includeConflictsWarning",
    )
  })

  with_include_fuj({
    expect_silent(include("fuj", c(foo = "include"), warn = FALSE))
  })
})
