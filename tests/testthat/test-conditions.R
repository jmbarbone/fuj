test_that("inform() works", {
  expect_output(
    expect_condition(
      inform("information"),
      class = "fuj::info_condition",
    )
  )
})

test_that("*_condition() works", {
  expect_s3_class(condition("condition"), "condition")
  expect_s3_class(message_condition("message"), "message")
  expect_s3_class(warning_condition("warning"), "warning")
  expect_s3_class(error_condition("error"), "error")
})

test_that("specific errors", {
  expect_error(
    stop(development_error("some development error", package = "fuj")),
    "some development error",
    fixed = TRUE
  )

  expect_error(
    stop(defunct_error("some defunct error", package = "fuj")),
    "some defunct error",
    fixed = TRUE
  )

  expect_error(
    stop(internal_error("some internal error", package = "fuj")),
    "some internal error",
    fixed = TRUE
  )
})

test_that("utils", {
  expect_error(check_package(""), class = "input_error")
})
