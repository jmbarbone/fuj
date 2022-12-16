test_that("muffle()", {
  foo <- function(...) {
    message("You entered :", paste0(...))
    c(...)
  }

  expect_message(muffle(foo(1, 2)), NA)
  expect_message(muffle(fun = foo)(1, 2), NA)
  expect_message(sapply(1:3, muffle(fun = foo)), NA)

  expect_error(muffle(1, as.integer), class = "fuj:muffleError")
})

test_that("muffle()", {
  x <- list("a", 1)
  expect_warning(wuffle(as.integer(x)), NA)
  expect_warning(wuffle(fun = as.integer)(x), NA)
  expect_warning(sapply(x, wuffle(fun = as.integer)), NA)

  expect_error(wuffle(1, as.integer), class = "fuj:wuffleError")
})
