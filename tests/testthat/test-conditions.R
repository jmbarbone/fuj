test_that("inform() works", {
  expect_output(
    expect_condition(
      inform("information"),
      class = "fuj:info_condition",
    )
  )
})
