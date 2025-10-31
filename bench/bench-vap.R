devtools::load_all(here::here())

options(
  fuj.vap.progress = FALSE,
  fuj.vap.indexed_errors = FALSE
)

library(ggplot2)
library(bench)
library(purrr)

mark_vap_int <- mark::vap_int
mark_vap_dbl <- mark::vap_dbl

n <- 1e4
x <- runif(n)
y <- runif(n)
z <- runif(n)

autoplot(print(mark(
  vap_dbl(x, force),
  map_dbl(x, force),
  mark_vap_dbl(x, force),
  vapply(x, force, NA_real_),
  as.vector(lapply(x, force), "double"),
  iterations = 99
)))

autoplot(print(mark(
  vap2_dbl(x, y, sum),
  map2_dbl(x, y, sum),
  iterations = 99
)))

autoplot(print(mark(
  vapp_dbl(list(x, y, z), sum),
  with_vap_handlers(vapp_dbl(list(x, y, z), sum)),
  pmap_dbl(list(x, y, z), sum),
  iterations = 99
)))

local({
  x <-
    mtcars |>
    split(mtcars$cyl)
  autoplot(print(mark(
    purrr = x |>
      map(\(df) lm(mpg ~ wt, data = df)) |>
      map(summary) |>
      map_dbl("r.squared"),
    fuj = x |>
      vap(\(df) lm(mpg ~ wt, data = df)) |>
      vap(summary) |>
      vap_dbl("r.squared"),
    iterations = 99
  )))
})

autoplot(print(mark(
  purrr = c("foo", "bar") |>
    purrr::set_names() |>
    purrr::map_chr(paste0, ":suffix"),
  fuj = c("foo", "bar") |>
    fuj::set_names() |>
    fuj::vap_chr(paste0, ":suffix"),
  iterations = 99
)))

local({
  x <- y <- z <- runif(1e5)
  autoplot(print(mark(
    mapply(sum, x, y, z, SIMPLIFY = FALSE),
    .mapply(sum, list(x, y, z), list()),
    .mapply(sum, list(x, y, z), NULL),
    iterations = 50
  )))
})
