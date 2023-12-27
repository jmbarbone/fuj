test_that("include() works", {
  skip_if_not_installed("parallel")
  old <- search()
  include("parallel")
  expect_identical(setdiff(search(), old), "include:parallel")
  detach2("include:parallel")
})

test_that("include() works with exports", {
  skip_if_not_installed("parallel")
  old <- search()
  include("parallel", "clusterApply")
  include("parallel", c(n_cores = "detectCores"))
  expect_identical(setdiff(search(), old), "include:parallel")
  expect_identical(clusterApply, "parallel" %::% "clusterApply")
  expect_identical(n_cores, "parallel" %::% "detectCores")
  detach2("include:parallel")
})

test_that("include() works with conflicts", {
  with_include_fuj <- function(code) {
    on.exit({
      detach2("include:fuj")
      detach2("foo")
    })
    # creates a dummy environment on the search path to force a conflict with an
    # object, 'foo'
    attach2(list(foo = "foo"), name = "foo")
    with_options(c(fuj.verbose = TRUE), code)
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
