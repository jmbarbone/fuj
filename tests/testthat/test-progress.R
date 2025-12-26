test_that("progress_bar()", {
  con <- file()
  on.exit(if (isOpen(con)) close(con))
  pb <- progress_bar(con = con)
  for (i in 1:10 / 10) {
    pb$set(i)
  }
  pb$set(i)
  expect_true(length(readLines(con, warn = FALSE)) > 10)
})

test_that("progress_bar() errors", {
  expect_error(progress_bar(char = character()))
  expect_error(progress_bar(char = 1:2))
  expect_error(progress_bar(char = NA))
})
