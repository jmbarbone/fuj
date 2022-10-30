test_that("%colons%", {
  expect_error("fuj" %colons% "not_in_fuj", class = "colonsError")
  expect_error("1" %colons% "foo", class = "namespaceError")

  expect_identical("base" %colons% "[", match.fun("["))
  expect_identical("base" %colons% "letters", letters)
})
