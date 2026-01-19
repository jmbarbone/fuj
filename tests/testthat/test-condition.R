test_that("new_condition() conditions", {
  expect_error(new_condition(), class = "fuj:input_error")
  expect_error(new_condition(class = 1:2), class = "fuj:input_error")
  expect_error(
    new_condition(class = "foo", pkg = NA),
    class = "fuj:value_error"
  )

  expect_error(new_condition(class = "foo", pkg = FALSE), NA)
})
