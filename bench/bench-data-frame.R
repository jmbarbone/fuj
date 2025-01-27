devtools::load_all(here::here())
library(ggplot2)
library(bench)

print(mark(
  dataframe(), # same as quick_df(NULL)
  quick_df(),
  quick_df(list()),

  data.frame(),
  data.frame(NULL),
  data.frame(list())
))

autoplot(.Last.value)

print(mark(
  dataframe(a = integer(), b = character(), ),
  data.frame(a = integer(), b = character())
))

autoplot(.Last.value)

local({
  c <- b <- a <- seq_len(100)
  print(mark(
    dataframe(a = a, b = b, c = c, ),
    data.frame(a = a, b = b, c = c)
  ))
})

autoplot(.Last.value)
