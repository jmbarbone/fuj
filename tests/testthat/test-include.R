test_that("include() works", {
  skip_if_not_installed("parallel")
  old <- search()
  include("parallel")
  expect_identical(setdiff(search(), old), "include:parallel")
  detach2("include:parallel")

  old <- search()
  include(parallel)
  expect_identical(setdiff(search(), old), "include:parallel")
  detach2("include:parallel")
})

test_that("include() doesn't add multiple times", {
  old <- search()
  include(test_path("include.R"))
  include(test_path("include.R"))
  expect_identical(search(), append(old, "include:include", 1))
  detach2("include:include")
  detach2("include:include") # in case of failure

  include(test_path("include-name.R"))
  include(test_path("include-name.R"))
  expect_identical(search(), append(old, "attachName", 1))
  detach2("attachName")
  detach2("attachName") # in case of failure

  skip_if_not_installed("parallel")
  include("parallel")
  include("parallel")
  expect_identical(search(), append(old, "include:parallel", 1))
  detach2("include:parallel")
  detach2("include:parallel") # in case of failure
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

test_that("include path names", {
  old <- search()
  include(testthat::test_path("include.R"))
  expect_identical(setdiff(search(), old), "include:include")
  expect_identical(ls("include:include"), c("bar", "foo"))
  detach2("include:include")

  include(testthat::test_path("include-name.R"))
  expect_identical(setdiff(search(), old), "attachName")
  expect_identical(ls("attachName"), c("bar", "foo"))
  expect_identical(
    ls("attachName", all.names = TRUE),
    c(".AttachName", "bar", "foo")
  )
  detach2("attachName")
})

test_that("include AsIs", {
  old <- search()
  include(I("parallel"))
  expect_identical(setdiff(search(), old), "include:parallel")
  detach2("include:parallel")
})

test_that("attach2() works", {
  with_attach <- function(warn = NULL) {
    on.exit({
      detach2("foo")
      detach2("bar")
    })
    with_verbose({
      attach2(list(foo = 1), name = "foo")
      attach2(list(foo = 2), name = "bar", warn = warn)
    })
  }

  expect_message(with_attach(NULL), class = "verboseMessage")
  expect_message(with_attach(NA), class = "packageStartupMessage")
  expect_warning(with_attach(TRUE), class = "includeConflictsWarning")

  do_attach <- function() {
    on.exit(detach2("foo"))
    attach2(list(a = 1), name = "foo")
    attach2(list(a = 1), name = "foo")
  }

  expect_silent(do_attach())
})
