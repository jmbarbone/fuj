test_that("negate() works", {
  different <- negate(identical)
  expect_identical(formals(different), formals(identical))
  expect_true(different(different, identical))
})
