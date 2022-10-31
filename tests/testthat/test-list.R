test_that("list0", {
  expect_identical(list0(1, 2), list(1, 2))
  expect_identical(list0(1, 2, ), list(1, 2))

  foo <- function(...) list0(...)
  expect_identical(foo(1, 2, "c", ), list(1, 2, "c"))
})
