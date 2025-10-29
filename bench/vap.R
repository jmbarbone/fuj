devtools::load_all(here::here())

library(ggplot2)
library(bench)
library(purrr)

mark_vap_int <- mark::vap_int

x <- 1:1e5
y <- 1:1e5
z <- 1:1e5

autoplot(print(mark(
  vap_int(x, force),
  map_int(x, force),
  mark_vap_int(x, force),
  vapply(x, force, NA_integer_),
  iterations = 99
)))

autoplot(print(mark(
  vap2_int(x, y, sum),
  map2_int(x, y, sum),
  iterations = 99
)))

autoplot(print(mark(
  vapp_int(list(x, y, z), sum),
  pmap_int(list(x, y, z), sum),
  iterations = 99
)))

local({
  x <-
    mtcars |>
    split(mtcars$cyl)
  autoplot(print(mark(
    purrr =
      x |>
      map(\(df) lm(mpg ~ wt, data = df)) |>
      map(summary) |>
      map_dbl("r.squared"),
    fuj =
      x |>
      vap(\(df) lm(mpg ~ wt, data = df)) |>
      vap(summary) |>
      vap_dbl("r.squared"),
    iterations = 99
  )))
})

autoplot(print(mark(
  purrr =
    c("foo", "bar") |>
    purrr::set_names() |>
    purrr::map_chr(paste0, ":suffix"),
  fuj =
    c("foo", "bar") |>
    fuj::set_names() |>
    fuj::vap_chr(paste0, ":suffix"),
  iterations = 99
)))
