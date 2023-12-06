test_that("%colons%", {
  expect_identical(`%colons%`, `%:::%`)

  # errors
  expect_error("fuj" %:::% "not_in_fuj", class = "colonsError")
  expect_error("fuj" %::% "colons_example", class = "colonsError")
  expect_error("1" %::% "foo", class = "namespaceError")
  expect_error(1 %::% "foo", class = "colonsPackageNameError")
  expect_error(c("a", "b") %::% "foo", class = "colonsPackageNameError")

  # successes
  expect_identical("fuj" %:::% "colons_example", "Hello, world")
  expect_identical("base" %::% "[", match.fun("["))
  expect_identical("base" %::% "letters", letters)
})
