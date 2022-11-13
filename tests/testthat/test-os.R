test_that("os", {
  env <- Sys.getenv("GH_ACTIONS_OS")
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
