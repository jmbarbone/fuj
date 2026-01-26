check_option <- function() {
  testthat::skip_if_not(getOption("fuj.list.active", TRUE))
}

test_that("list0", {
  expect_identical(list0(1, 2), list(1, 2))
  check_option()
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

  check_option()
  obj <- list0(a = 1, 2, c = 3, )
  exp <- list(a = 1, 2, c = 3)
  expect_identical(obj, exp)
})

test_that("handles NA_character_ [#60]", {
  expect_identical(lst(NA_character_), list(NA_character_))
  check_option()
  expect_identical(lst(NA_character_, ), list(NA_character_))
})
