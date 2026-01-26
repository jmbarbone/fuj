devtools::load_all(here::here())
library(ggplot2)
library(bench)

list_old <- function(...) {
  e <- as.list(substitute((...)))[-1L]
  do.call(list, e[!is_empty(e)], envir = parent.frame(2))
}

autoplot(print(bench::mark(
  list(1, 2, 3),
  lst(1, 2, 3, ),
  list_old(1, 2, 3, ),
  rlang::list2(1, 2, 3, ),
)))
