test_that("delay() works", {
  foo <- function() {
    x <- 1L
    y <- 2L
    local({
      delay(x <<- x + y)
      y <- 3L
    })
    x
  }

  expect_identical(foo(), 4L)
})

test_that("delay() works -- file remove", {
  temp <- tempfile()
  local({
    writeLines(letters, temp)
    delay(unlink(temp))
    expect_identical(readLines(temp), letters)
  })

  if (file.exists(temp)) {
    unlink(temp)
    failure("delay() did not execute the delayed expression on exit")
  } else {
    succeed("delay() executed the delayed expression on exit")
  }
})
