test_that("match_arg() works", {
  expect_identical(match_arg("a", c("a", "b")), "a")
  expect_identical(match_arg("b", c("a", "b")), "b")
  expect_identical(match_arg("a", c("a", "b"), multiple = TRUE), "a")
  expect_identical(
    match_arg(c("a", "b"), c("a", "b"), multiple = TRUE),
    c("a", "b")
  )

  expect_identical((\(x = 1:2) match_arg(x))(), 1L)
})

test_that("match_arg() match_arg_error", {
  expect_error(match_arg("a", c("b", "c")), class = "match_arg_error")
  expect_error(match_arg(-1, list(a = 1:2)), class = "match_arg_error")
  expect_error(match_arg(0, list(a = 1:2, 3:4)), class = "match_arg_error")
  expect_error(
    match_arg(list(b = 3:4), list(a = 1:2)),
    class = "match_arg_error"
  )

  expect_error(
    match_arg(-1, list(1L ~ 0:1, 2L, \() {} ~ 3:5)),
    class = "match_arg_error"
  )
})

test_that("match_arg() errors", {
  expect_error(
    match_arg("a", c("a", "a", "b", "c", "c")),
    class = "value_error"
  )
})

test_that("match_arg(NULL)", {
  expect_error(match_arg(NULL), class = "input_error")
  expect_null(match_arg(NULL, null = "null"))
  expect_identical(match_arg(NULL, 1:2, null = "first"), 1L)
  expect_identical(match_arg(NULL, 1:2, null = "all"), 1:2)
  expect_error(match_arg(NULL, null = "none"), class = "match_arg_error")
  expect_error(match_arg(NULL, 1), class = "input_error")
})
