test_that("%colons%", {
  expect_identical(`%colons%`, `%:::%`)

  # errors
  expect_error("fuj" %:::% "not_in_fuj", class = "fuj:colons_error")
  expect_error("fuj" %::% "colons_example", class = "fuj:colons_error")
  expect_error("1" %::% "foo", class = "fuj:namespace_error")
  expect_error(1 %::% "foo", class = "fuj:input_error")
  expect_error(c("a", "b") %::% "foo", class = "fuj:input_error")

  # successes
  expect_identical("fuj" %:::% "colons_example", "Hello, world")
  expect_identical("base" %::% "[", match.fun("["))
  expect_identical("base" %::% "letters", letters)
})
