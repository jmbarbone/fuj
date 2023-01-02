test_that("new_condition() conditions", {
  expect_error(new_condition(), class = "fuj:newConditionClassError")
  expect_error(new_condition(class = 1:2), class = "fuj:newConditionClassError")
  expect_error(
    new_condition(class = "foo", pkg = NA),
    class = "fuj:newConditionPackageError"
  )

  expect_error(new_condition(class = "foo", pkg = FALSE), NA)
})
