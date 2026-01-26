test_that("multiplication works", {
  foo <- function(x) {
    if (!inherits(x, "list")) {
      stop(class_error("`x` must be of class 'list'"))
    }
  }

  expect_error(foo(NULL), class = "fuj:class_error")
  expect_error(foo(list()), NA)
})
