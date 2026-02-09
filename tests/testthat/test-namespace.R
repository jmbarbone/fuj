test_that("require_namespace", {
  # returns invisible(TRUE) on success
  expect_true(require_namespace("base"))
  expect_true(require_namespace("base", "methods", "stats"))

  # custom error on failure
  expect_error(require_namespace("1"), class = "namespace_error")

  # only the first package should cause an error
  expect_error(
    require_namespace("base", "1foo", "2foo"),
    class = "namespace_error",
    regexp = namespace_error("1foo")$message,
    fixed = TRUE
  )

  # this should fail because we shouldn't see 2foo
  expect_error(expect_error(
    require_namespace("base", "1foo", "2foo"),
    class = "namespace_error",
    regexp = "2foo",
    fixed = TRUE
  ))

  expect_error(require_namespace("base>1.0"), NA)
  expect_error(require_namespace("utils>=1.0"), NA)
  expect_error(require_namespace("utils>1.0"), NA)
  expect_error(require_namespace(paste0("utils==", getRversion())), NA)

  tryCatch(
    expect_error(
      require_namespace("utils<1.0"),
      sprintf("utils: %s < 1.0", getRversion()),
      fixed = TRUE,
      class = "namespace_error"
    ),
    namespaceError = function(e) invisible()
  )

  expect_error(
    require_namespace("utils<=1.0"),
    sprintf("utils: %s <= 1.0", getRversion()),
    fixed = TRUE,
    class = "namespace_error"
  )
})
