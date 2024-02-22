test_that("fs works", {
  expect_true(is_path(fp("here")))
  expect_true(is_file_path(file_path("here")))
})

test_that("fs works on windows", {
  skip_if_not(is_windows())

  np <- function(x) normalizePath(x, winslash = "/", FALSE)

  expect_identical(
    fp("~/here///there"),
    np("~/here/there"),
    ignore_attr = TRUE
  )

  expect_identical(
    fp("~/here//there\\\\where"),
    np("~/here/there/where"),
    ignore_attr = TRUE
  )

  expect_identical(
    fp("~/a", c("b", "c"), "d"),
    np(c("~/a/b/d", "~/a/c/d")),
    ignore_attr = TRUE
  )
})

test_that("fs works on not windows", {
  skip_if(is_windows())

  expect_identical(
    fp("here///there"),
    "here/there",
    ignore_attr = TRUE
  )

  expect_identical(
    fp("here//there\\\\where"),
    "here/there/where",
    ignore_attr = TRUE
  )

  expect_identical(
    fp("a", c("b", "c"), "d"),
    c("a/b/d", "a/c/d"),
    ignore_attr = TRUE
  )
})

test_that("snapshots", {
  skip_if(is_windows())
  expect_snapshot(fp(c("here/there", "every/where", "good\\slash")))
})
