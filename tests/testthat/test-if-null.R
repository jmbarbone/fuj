test_that("%||%", {
  expect_identical(NULL %||% 1L, 1L)
  expect_identical(2L   %||% 1L, 2L)
})

test_that("%|||%", {
  expect_identical(""       %|||% 1L, 1L)
  expect_identical(NA       %|||% 1L, 1L)
  expect_identical(double() %|||% 1L, 1L)
  expect_identical(NULL     %|||% 1L, 1L)
})

test_that("%len%", {
  expect_true(logical() %len% TRUE)
  expect_false(FALSE    %len% TRUE)
})
