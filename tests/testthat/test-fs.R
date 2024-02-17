test_that("fs works", {
  expect_true(is_path(fp("here")))
  expect_true(is_file_path(file_path("here")))

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
  expect_snapshot(fp(c("here/there", "every/where", "good\\slash")))
})
