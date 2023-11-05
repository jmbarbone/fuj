test_that("os", {
  # basic testing to hit coverage
  expect_identical(sum(is_windows(), is_macos(), is_linux()), 1L)

  # more exact testing
  env <- Sys.getenv("GH_ACTIONS_OS")
  skip_if(env == "", "GH_ACTIONS_OS not set")

  env <- regmatches(env, regexpr("[a-z]+", env))

  switch(
    env,
    windows = {
      expect_true(is_windows())
      expect_false(is_macos())
      expect_false(is_linux())
    },
    macos = {
      expect_false(is_windows())
      expect_true(is_macos())
      expect_false(is_linux())
    },
    ubuntu = {
      expect_false(is_windows())
      expect_false(is_macos())
      expect_true(is_linux())
    }
  )
})
