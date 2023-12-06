test_that("verbose() works", {
  op <- options(c(op.fuj, verbose = FALSE))
  on.exit(options(op))
  expect_silent(verbose("will not show"))

  options(verbose = TRUE)
  expect_condition(verbose("message printed"), class = "verboseMessage")
  expect_message(
    verbose("multiple lines ", "will be ", "combined"),
    class = "verboseMessage"
  )

  op <- options(fuj.verbose = function() TRUE)
  expect_condition(verbose("function will evaluate"), class = "verboseMessage")
  expect_silent(verbose(NULL))
  expect_message(verbose(NULL, "something"))
  expect_silent(
    verbose(if (FALSE) {
      "`if` returns `NULL` when not `TRUE`, which makes for additional control"
    })
  )

  options(fuj.verbose = TRUE)
  expect_error(verbose("", .label = 1:2), class = "verboseMessageLabelError")
})

test_that("verbose.label as function works", {
  op <- options(
    fuj.verbose.label = function() "[function]",
    fuj.verbose = TRUE
  )

  on.exit(options(op))

  expect_message(
    verbose("message printed"),
    class = "verboseMessage",
    regexp = "[function]",
    fixed = TRUE
  )
})

test_that("verbose.fill works", {
  op <- options(fuj.verbose.fill = TRUE, fuj.verbose = TRUE)
  on.exit(options(op))

  expect_message(
    verbose("one\ntwo"),
    class = "verboseMessage",
    regexp = "<verboseMessage> one\n<verboseMessage> two",
    fixed = TRUE
  )
})

test_that("make_verbose() works", {
  verb <- make_verbose("fuj.testthat.verbose")
  expect_silent(verb("will not show"))

  op <- options(fuj.testthat.verbose = TRUE)
  on.exit(options(op))
  expect_condition(verb("will show"), class = "verboseMessage")
})
