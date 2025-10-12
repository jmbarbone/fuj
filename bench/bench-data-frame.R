devtools::load_all(here::here())
library(ggplot2)
library(bench)

print(mark(
  quick_df(),
  quick_df(list()),
  dataframe(), # same as quick_df(NULL)

  data.frame(),
  data.frame(NULL),
  data.frame(list())
))

autoplot(.Last.value)

print(mark(
  quick_df(list(a = integer(), b = character())),
  dataframe(a = integer(), b = character(), ),
  data.frame(a = integer(), b = character())
))

autoplot(.Last.value)

local({
  c <- b <- a <- seq_len(100)
  print(mark(
    quick_df(list(a = a, b = b, c = c)),
    dataframe(a = a, b = b, c = c, ),
    data.frame(a = a, b = b, c = c),
    data.frame(a, b, c),
  ))
})

autoplot(.Last.value)
