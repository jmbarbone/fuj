test_that("alises are correct", {
  expect_identical(add,         `+`)
  expect_identical(subtract,    `-`)
  expect_identical(multiply,    `*`)
  expect_identical(divide,      `/`)
  expect_identical(raise_power, `^`)
  expect_identical(remainder,   `%%`)
  expect_identical(divide_int,  `%/%`)
})
