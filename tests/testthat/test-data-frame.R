test_that("quick_df()", {
  expect_error(quick_df(1L), class = "fuj:quickDfInputError")
  expect_error(quick_df(list(a = 1:2, b = 1:3)), class = "fuj:quickDfListError")

  expect_identical(
    quick_df(list(a = NULL)),
    struct(list(a = NULL), "data.frame", names = "a", row.names = integer())
  )

  expect_identical(
    quick_df(list(a = integer())),
    data.frame(a = integer(), stringsAsFactors = FALSE)
  )

  expect_equal(
    quick_df(list(a = integer())),
    quick_dfl(a = integer())
  )

  expect_identical(quick_df(NULL), empty_df())
})
