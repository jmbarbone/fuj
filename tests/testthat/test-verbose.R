test_that("verbose() works", {
  with_options(c(op.fuj, verbose = FALSE), {
    expect_silent(verbose("will not show"))

    with_options(list(verbose = TRUE), {
      expect_condition(verbose("message printed"), class = "verboseMessage")
      expect_message(
        verbose("multiple lines ", "will be ", "combined"),
        class = "verboseMessage"
      )
    })

    with_options(list(fuj.verbose = function() TRUE), {
      expect_condition(
        verbose("function will evaluate"),
        class = "verboseMessage"
      )
      expect_silent(verbose(NULL))
      expect_message(verbose(NULL, "something"))
      expect_silent(
        verbose(if (FALSE) {
          "`if` returns `NULL` when not `TRUE`, for additional control"
        })
      )
    })

    with_options(list(fuj.verbose = TRUE), {
      expect_error(
        verbose("", .label = 1:2),
        class = "verboseMessageLabelError"
      )
    })
  })
})

test_that("verbose.label as function works", {
  with_options(
    list(
      fuj.verbose.label = function() "[function]",
      fuj.verbose = TRUE
    ), {
      expect_message(
        verbose("message printed"),
        class = "verboseMessage",
        regexp = "[function]",
        fixed = TRUE
      )
    })
})

test_that("verbose.fill works", {
  with_options(list(fuj.verbose.fill = TRUE, fuj.verbose = TRUE), {
    regexp <- paste(
      getOption("fuj.verbose.label"),
      c("one", "two"),
      sep = "",
      collapse = "\n"
    )

    expect_message(
      verbose("one\ntwo"),
      class = "verboseMessage",
      regexp = regexp,
      fixed = TRUE
    )
  })
})

test_that("make_verbose() works", {
  verb <- make_verbose("fuj.testthat.verbose")
  expect_silent(verb("will not show"))

  with_options(list(fuj.testthat.verbose = TRUE), {
    expect_condition(verb("will show"), class = "verboseMessage")
  })
})
