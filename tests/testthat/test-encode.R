test_that("encode() works", {
  expect_identical(
    encode(c("a", "b", "c"), from = c("a", "o"), to = "*"),
    c("*", "b", "c")
  )

  expect_identical(
    encode(1:4, 1:3, 0),
    c(0, 0, 0, 4)
  )

  expect_identical(
    encode(1:4, 1:3, 0, strict = TRUE),
    c(0, 0, 0, NA)
  )

  expect_identical(
    encode(
      c("a", "b", "c", "d"),
      letters,
      1:26,
      exclude = "b"
    ),
    c("1", NA_character_, "3", "4")
  )

  expect_error(
    encode(NULL, 1:2, 1:3),
    class = "input_error"
  )
})

test_that("fact() works", {
  expect_identical(
    fact(c("c", "a", "b")),
    factor(c("c", "a", "b"), levels = c("c", "a", "b"))
  )
})
