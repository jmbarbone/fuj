test_that("new_condition() conditions", {
  expect_s3_class(
    new_condition("", I("don't change this")),
    "don't change this"
  )

  expect_error(new_condition(class = 1:2), class = "fuj:class_error")
  expect_error(
    new_condition(class = "foo", package = NA),
    class = "fuj:value_error"
  )

  expect_warning(
    new_condition(class = "foo", pkg = NULL),
    class = "fuj:deprecated_warning"
  )
  expect_error(new_condition(class = "foo", package = FALSE), NA)
  expect_error(new_condition(class = "foo", package = NULL), NA)
})
