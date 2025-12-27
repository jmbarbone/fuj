test_that("vap works", {
  x <- 1:3
  expect_identical(vap(x, force), lapply(x, force))

  names(x) <- c("a", "b", "c")
  expect_identical(vap(x, force), lapply(x, force))

  x <- 1:3
  y <- 1:3

  expect_identical(vap2(x, y, sum), Map(sum, x, y))

  names(x) <- c("a", "b", "c")
  names(y) <- c("d", "e", "f")

  expect_identical(vap2(x, y, sum), Map(sum, x, y))

  z <- 1:3
  expect_identical(vap3(x, y, z, sum), Map(sum, x, y, z))

  p <- list(a = x, b = y, c = z)
  expect_identical(vapp(p, sum), with(p, Map(sum, a, b, c)))
})

test_that("vapi() works", {
  x <- 1:3
  expect_true(Reduce(`&&`, vapi(x, identical)))

  names(x) <- c("a", "b", "c")
  expect_true(all(vapi_lgl(x, function(x, i) i == letters[x])))
})

test_that("dates work", {
  x <- as.Date("2020-01-01") + 0:2
  expect_identical(vap_date(x, force), x)

  x <- as.POSIXct(x)
  expect_identical(vap_dttm(x, force), x)

  x <- 0:2
  y <- 0
  expect_identical(
    vap2_date(x, y, `+`),
    as.Date("1970-01-01") + (0:2)
  )

  expect_identical(
    vap2_dttm(x, y, `+`),
    as.POSIXct("1970-01-01", tz = "UTC") + (0:2)
  )

  z <- 1
  expect_identical(
    vapp_date(list(x, y, z), sum),
    as.Date("1970-01-01") + (1:3)
  )
  expect_identical(
    vapp_dttm(list(x, y, z), sum),
    as.POSIXct("1970-01-01", tz = "UTC") + (1:3)
  )
})

test_that("as_vap_fun() works", {
  x <- list(
    list(a = 1L, b = 4L),
    list(a = 2L, b = 5L),
    list(a = 3L, b = 6L)
  )
  expect_identical(vap_int(x, "a"), 1:3)
  expect_identical(vap_int(x, 2), 4:6)

  f <- quote(force)
  expect_identical(vap_int(1:3, f), 1:3)
})

test_that("vap_progress() works", {
  expect_output(
    with_vap_progress(vap_int(1:100, force))
  )
})

test_that("index reporting works", {
  expect_error(
    with_vap_handlers(
      vap(10:1, function(x) if (x == 3) stop("bad"))
    ),
    "index: 8",
    fixed = TRUE
  )

  expect_warning(
    with_vap_handlers(
      vap(10:1, function(x) if (x == 3) warning("bad"))
    ),
    "index: 8",
    fixed = TRUE
  )

  my_erroring_fun <- function(x) {
    if (x == 3) stop("this is an error message")
  }

  my_warninging_fun <- function(x) {
    if (x == 3) warning("this is a warning message")
  }

  expect_snapshot_error(
    with_vap_handlers(
      vap(10:1, my_erroring_fun)
    )
  )

  expect_snapshot_warning(
    with_vap_handlers(
      vap(10:1, my_warninging_fun)
    )
  )

  foo_error <- function() {
    with_vap_handlers(
      vap(10:1, my_erroring_fun)
    )
  }

  foo_warning <- function() {
    with_vap_handlers(
      vap(10:1, my_warninging_fun)
    )
  }

  expect_snapshot_error(foo_error())
  expect_snapshot_warning(foo_warning())
})
