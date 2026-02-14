test_that("hold works", {
  expect_identical(
    hold(c(1:5, NA), \(x) x %% 2 == 0),
    c(2L, 4L)
  )

  expect_identical(
    hold(c(1:5, NA), \(x) x %% 2 == 0, na = "keep"),
    c(2L, 4L, NA)
  )

  expect_identical(
    hold(letters[1:5], c(1:3, NA)),
    c("a", "b", "c")
  )
})

test_that("toss works", {
  expect_identical(
    toss(c(1:5, NA), \(x) x %% 2 == 0),
    c(1L, 3L, 5L, NA)
  )

  expect_identical(
    toss(c(1:5, NA), \(x) x %% 2 == 0, na = "drop"),
    c(1L, 3L, 5L)
  )

  expect_identical(
    toss(letters[1:5], c(1:3, NA)),
    c("d", "e")
  )
})

test_that("hot errors", {
  expect_error(hold(1:5, "foo"), class = "fuj:input_error")
  expect_error(toss(1:5, "foo"), class = "fuj:input_error")
})
