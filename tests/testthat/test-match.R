test_that("is_in(), %out%", {
  res <- is_in(1:10, c(1, 3, 5, 9))
  exp <- c(TRUE, FALSE, TRUE, FALSE, TRUE, FALSE, FALSE, FALSE, TRUE, FALSE)
  expect_identical(res, exp)

  res <- 1:10 %out% c(1, 3, 5, 9)
  expect_identical(res, !exp)
})

test_that("%wo%", {
  res <- letters[1:5] %wo% letters[3:7]
  exp <- c("a", "b")
  expect_identical(res, exp)

})

test_that("%wi%", {
  res <- letters[1:5] %wi% letters[3:7]
  exp <- c("c", "d", "e")
  expect_identical(res, exp)

})

test_that("any_match", {
  expect_true(any_match(2:3, 1:4))
  expect_false(any_match(2:3, 4))
})

test_that("no_match()", {
  expect_true(no_match(1:3, 4))
  expect_false(no_match(1:3, 4:3))
})
