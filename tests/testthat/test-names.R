test_that("set_names()", {
  expect_null(set_names(NULL))
})

test_that("remove_names()", {
  x <- "a"
  expect_identical(remove_names(x), x)

  y <- c(b = "a")
  expect_identical(remove_names(y), x)
})

test_that("%name%", {
  x <- 1:4
  nm <- letters[1:4]

  expect_identical(
    x %names% nm,
    set_names(x, nm)
  )
})

test_that("is_named()", {
  expect_false(is_named(1))
  expect_false(is_named(NULL))
  expect_true(is_named(c(a = 1)))

  x <- 1
  names(x) <- ""
  expect_true(is_named(x))
  expect_false(is_named(x, zero_ok = FALSE))
})
