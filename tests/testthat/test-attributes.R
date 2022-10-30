test_that("exattr", {
  x <- struct(list(), "foo", aa = 1, a = 2)
  expect_identical(x %attr% "a", 2)

  x <- struct(list(), "foo", aa = 1)
  expect_null(x %attr% "a")
})
