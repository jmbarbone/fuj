test_that("windows", {
  skip_if_not(startsWith(Sys.getenv("GH_ACTIONS_OS"), "windows"))
  expect_true(is_windows())
  expect_false(is_macos())
  expect_false(is_linux())
})

test_that("macos", {
  skip_if_not(startsWith(Sys.getenv("GH_ACTIONS_OS"), "macos"))
  expect_false(is_windows())
  expect_true(is_macos())
  expect_false(is_linux())
})

test_that("linux (ubuntu)", {
  skip_if_not(startsWith(Sys.getenv("GH_ACTIONS_OS"), "ubuntu"))
  expect_false(is_windows())
  expect_false(is_macos())
  expect_true(is_linux())
})
