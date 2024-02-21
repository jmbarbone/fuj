test_that("fs works", {
  expect_true(is_path(fp("here")))
  expect_true(is_file_path(file_path("here")))

  expect_identical(
    fp("~/here///there"),
    path.expand("~/here/there"),
    ignore_attr = TRUE
  )

  expect_identical(
    fp("~/here//there\\\\where"),
    path.expand("~/here/there/where"),
    ignore_attr = TRUE
  )

  expect_identical(
    fp("~/a", c("b", "c"), "d"),
    path.expand(c("~/a/b/d", "~/a/c/d")),
    ignore_attr = TRUE
  )
})

test_that("snapshots", {
  skip_if(is_windows())
  expect_snapshot(fp(c("here/there", "every/where", "good\\slash")))
})
