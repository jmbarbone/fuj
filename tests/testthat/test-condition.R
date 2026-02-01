test_that("new_condition(I(class))", {
  expect_s3_class(
    new_condition("", I("don't change this")),
    "don't change this"
  )
})

test_that("new_condition() conditions", {
  expect_error(new_condition(class = 1:2), class = "fuj:class_error")
  expect_error(
    new_condition(class = "foo", package = NA),
    class = "fuj:value_error"
  )

  expect_error(new_condition(class = "foo", package = FALSE), NA)
  expect_error(new_condition(class = "foo", package = NULL), NA)

  expect_warning(
    new_condition(.not_an_argument = 1),
    class = "fuj:dots_warning"
  )

  expect_warning(new_condition(pkg = "this"), class = "fuj:deprecated_warning")
  expect_warning(new_condition(msg = "this"), class = "fuj:deprecated_warning")
})
