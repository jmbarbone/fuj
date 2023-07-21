test_that("%colons%", {
  expect_identical(`%colons%`, `%:::%`)

  # errors
  expect_error("fuj" %:::% "not_in_fuj", class = "fuj:colonsError")
  expect_error("fuj" %::% "colons_example", class = "fuj:colonsError")
  expect_error("1" %::% "foo", class = "fuj:namespaceError")

  # successes
  expect_identical("fuj" %:::% "colons_example", "Hello, world")
  expect_identical("base" %::% "[", match.fun("["))
  expect_identical("base" %::% "letters", letters)
})
