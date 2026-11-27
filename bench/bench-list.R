devtools::load_all(here::here())
library(ggplot2)
library(bench)

.is_empty1 <- function(x) {
  # https://jmbarbone.github.io/posts/wat-na-list/
  vapply(x, identical, NA, quote(expr = ))
}

.is_empty2 <- function(x) {
  as.logical(lapply(x, \(i) identical(i, quote(expr = ))))
}

microbenchmark::microbenchmark(
  .is_empty1(list(1, 2, 3)),
  .is_empty2(list(1, 2, 3)),
  .is_empty1(list(1, quote(expr = ), 3)),
  .is_empty2(list(1, quote(expr = ), 3)),
  .is_empty1(list(quote(expr = ), quote(expr = ))),
  .is_empty2(list(quote(expr = ), quote(expr = ))),
  times = 100000
)

list_old <- function(...) {
  e <- as.list(substitute((...)))[-1L]
  do.call(list, e[!.is_empty1(e)], envir = parent.frame(2))
}

list_new <- function(...) {
  e <- as.call(substitute(list(...)))
  Exec(e[!.is_empty2(e)], parent.frame(2L))
}

autoplot(print(bench::mark(
  list(1, 2, 3),
  lst(1, 2, 3, ),
  list_old(1, 2, 3, ),
  list_new(1, 2, 3, ),
  rlang::list2(1, 2, 3, ),
)))

microbenchmark::microbenchmark(
  list(1, 2, 3),
  lst(1, 2, 3, ),
  list_old(1, 2, 3, ),
  list_new(1, 2, 3, ),
  rlang::list2(1, 2, 3, ),
  times = 100000
)
