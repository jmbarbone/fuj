test_that("require_namespace", {
  expect_error(require_namespace("1"), class = "fuj:namespaceError")
  expect_error(require_namespace("base"), NA)
})
