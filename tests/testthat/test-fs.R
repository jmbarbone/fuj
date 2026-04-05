test_that("fs works", {
  expect_true(is_path(fp("here")))
  expect_true(is_file_path(file_path("here")))

  expect_identical(
    fp("~/here///there"),
    "~/here/there",
    ignore_attr = TRUE
  )

  expect_identical(
    fp("~/here//there\\\\where"),
    "~/here/there/where",
    ignore_attr = TRUE
  )

  expect_identical(
    fp("~/a", c("b", "c"), "d"),
    c("~/a/b/d", "~/a/c/d"),
    ignore_attr = TRUE
  )

  expect_identical(
    np("~/here//there\\\\where"),
    normalizePath("~/here/there/where", "/", FALSE),
    ignore_attr = TRUE
  )
})


test_that("file_ext<- works", {
  expect_identical(
    {
      x <- fp("here/there/file.old")
      file_ext(x) <- "new"
      x
    },
    fp("here/there/file.new")
  )

  expect_identical(
    {
      x <- "here/there/file.old"
      file_ext(x) <- "new"
      x
    },
    "here/there/file.new"
  )

  expect_identical(
    {
      x <- fp("here/there/file.old")
      file_ext(x) <- "new"
      x
    },
    fp("here/there/file.new")
  )

  expect_identical(
    {
      x <- fp("here/there/file.one.two")
      file_ext(x) <- NULL
      x
    },
    fp("here/there/file.one")
  )
})

test_that("/ and + works", {
  expect_identical(
    fp("this") / "file" + "here",
    fp("this/file.here")
  )
})

test_that("snapshots", {
  skip_if(is_windows())
  expect_snapshot(fp(c("here/there", "every/where", "good\\slash")))
})
