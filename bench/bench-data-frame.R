devtools::load_all(here::here())
library(bench)

plot(print(mark(
  quick_df(),
  quick_df(list()),
  dataframe(), # same as quick_df(NULL)

  data.frame(),
  data.frame(NULL),
  data.frame(list()),
  mutframe()
)))

plot(print(mark(
  quick_df(list(a = integer(), b = character())),
  dataframe(a = integer(), b = character(), ),
  data.frame(a = integer(), b = character()),
  mutframe(a = integer(), b = character())
)))

local({
  c <- b <- a <- seq_len(100)
  plot(print(mark(
    quick_df(list(a = a, b = b, c = c)),
    dataframe(a = a, b = b, c = c, ),
    data.frame(a = a, b = b, c = c),
    data.frame(a, b, c),
    mutframe(a = a, b = b, c = c)
  )))
})

local({
  library(plyr, include.only = "quickdf")
  on.exit(detach("package:plyr"))
  n <- 1e4
  sl <- sample(letters, n, TRUE)

  microbenchmark::microbenchmark(
    quick_df = quick_df(list(a = 1:n, b = 1:n, c = 1:n, x = sl)),
    quickdf = quickdf(list(a = 1:n, b = 1:n, c = 1:n, x = sl)),
    data.frame = data.frame(a = 1:n, b = 1:n, c = 1:n, x = sl),
    dataframe = dataframe(a = 1:n, b = 1:n, c = 1:n, x = sl),
    mutframe = mutframe(a = 1:n, b = 1:n, c = 1:n, x = sl),
    times = 1000
  )
  plot(print(mark(
    quick_df(list(a = 1:n, b = 1:n, c = 1:n, x = sl)),
    quickdf(list(a = 1:n, b = 1:n, c = 1:n, x = sl)),
    data.frame(a = 1:n, b = 1:n, c = 1:n, x = sl),
    dataframe(a = 1:n, b = 1:n, c = 1:n, x = sl),
    mutframe(a = 1:n, b = 1:n, c = 1:n, x = sl)
  )))
})
