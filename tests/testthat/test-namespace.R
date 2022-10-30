test_that("require_namespace", {
  expect_error(require_namespace("1"), class = "namespaceError")
  expect_error(require_namespace("base"), NA)
})
