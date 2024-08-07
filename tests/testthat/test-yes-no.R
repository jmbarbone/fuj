test_that("yes_no()", {
  options(fuj..yes_no.interactive_override = NULL)
  expect_error(yes_no(), class = "yesNoInteractiveError")
  expect_identical(yes_no(noninteractive_error = FALSE), NA)

  options(fuj..yes_no.interactive_override = 0)
  expect_warning(
    expect_null(yes_no()),
    class = "yesNoInteractiveOverrideWarning"
  )

  options(fuj..yes_no.interactive_override = 1)
  expect_warning(
    expect_true(yes_no(n_no = 0)),
    class = "yesNoInteractiveOverrideWarning"
  )

  options(fuj..yes_no.interactive_override = 1)
  expect_warning(
    expect_false(yes_no(n_yes = 0)),
    class = "yesNoInteractiveOverrideWarning"
  )

  options(fuj..yes_no.interactive_override = 4)
  expect_warning(
    expect_identical(yes_no(na = "four"), NA),
    class = "yesNoInteractiveOverrideWarning"
  )

  options(fuj..yes_no.interactive_override = 9)
  expect_error(
    expect_warning(
      yes_no(),
      class = "yesNoInteractiveOverrideWarning"
    )
  )

  options(fuj..yes_no.interactive_override = "a")
  expect_error(
    expect_warning(
      yes_no(),
      class = "yesNoInteractiveOverrideWarning"
    )
  )
})
