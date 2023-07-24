test_that("verbose() works", {
  op <- options(verbose = FALSE)
  expect_silent(verbose("will not show"))

  options(verbose = TRUE)
  expect_condition(verbose("message printed"), class = "verboseMessage")
  expect_message(
    verbose("multiple lines ", "will be ", "combined"),
    class = "verboseMessage"
  )

  options(op)

  op <- options(fuj.verbose = function() TRUE)
  expect_condition(verbose("function will evaluate"), class = "verboseMessage")
  expect_silent(verbose(NULL))
  expect_message(verbose(NULL, "something"))
  expect_silent(
    verbose(if (FALSE) {
      "`if` returns `NULL` when not `TRUE`, which makes for additional control"
    })
  )

  options(op)
})
