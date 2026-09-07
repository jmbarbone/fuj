test_that("available_namespace()", {
  expect_true(available_namespace("base"))
  expect_identical(
    available_namespace("base", "methods", "stats"),
    c(base = TRUE, methods = TRUE, stats = TRUE)
  )
  expect_false(available_namespace("1"))
  expect_identical(
    available_namespace("base", "1foo", "2foo"),
    c("base" = TRUE, "1foo" = FALSE, "2foo" = FALSE)
  )

  expect_true(available_namespace("base > 1.0"))
  expect_true(available_namespace("utils >= 1.0"))
  expect_true(available_namespace("utils > 1.0"))
  expect_true(available_namespace(paste0("utils == ", getRversion())))

  expect_false(available_namespace("utils < 1.0"))
  expect_false(available_namespace(list("utils", "<=", package_version("1.0"))))
  expect_false(available_namespace(
    pkg_req_spec("utils", "<=", package_version("1.0"))
  ))
})

test_that("require_namespace()", {
  # returns invisible(TRUE) on success
  expect_invisible(require_namespace("base"))

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

  expect_error(
    require_namespace("utils < 1.0"),
    sprintf("utils: %s < 1.0", getRversion()),
    fixed = TRUE,
    class = "namespace_error"
  ) |>
    tryCatch(
      namespace_version_error = null,
      namespaceError = null
    )

  expect_error(
    require_namespace("utils <= 1.0"),
    sprintf("utils: %s <= 1.0", getRversion()),
    fixed = TRUE,
    class = "namespace_version_error"
  ) |>
    tryCatch(namespace_error = null)
})

test_that("utils", {
  expect_s3_class(get_pkg_version("fuj"), "package_version")
  expect_s3_class(get_pkg_version("testthat"), "package_version")
  expect_s3_class(get_pkg_version("spelling"), "package_version")
})

test_that("errors", {
  expect_error(
    available_namespace("base <> 1"),
    class = "match_arg_error"
  )

  expect_error(
    available_namespace("base ==1"),
    class = "input_error"
  )
})

test_that("snapshot", {
  expect_snapshot(print(pkg_req_spec("base", "==", "5.0")))
})
