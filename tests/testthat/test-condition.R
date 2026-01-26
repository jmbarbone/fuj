test_that("new_condition() conditions", {
  expect_error(new_condition(), class = "fuj:input_error")
  expect_error(new_condition(class = 1:2), class = "fuj:input_error")
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
