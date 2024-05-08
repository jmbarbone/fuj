test_that("list0", {
  expect_identical(list0(1, 2), list(1, 2))
  expect_identical(list0(1, 2, ), list(1, 2))

  foo <- function(...) list0(...)
  expect_identical(foo(1, 2, "c", ), list(1, 2, "c"))

  expect_error(list0(1, `__not_a_variable__`))
  expect_error(list0(1, `__not_a_variable__`, ))
})

test_that("handles names [#25]", {
  obj <- list0(a = 1, 2, c = 3)
  exp <- list(a = 1, 2, c = 3)
  expect_identical(obj, exp)

  obj <- list0(a = 1, 2, c = 3, )
  exp <- list(a = 1, 2, c = 3)
  expect_identical(obj, exp)
})

test_that("handles NA_character_ [#60]", {
  expect_identical(lst(NA_character_), list(NA_character_))
})
