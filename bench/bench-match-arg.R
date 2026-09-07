devtools::load_all(here::here())

library(ggplot2)
library(bench)

I <- 99

# Default: no arg provided, should use choices[1]
fuj_default <- function(x = c("apple", "banana", "orange")) {
  match_arg(x)
}

base_default <- function(x = c("apple", "banana", "orange")) {
  base::match.arg(x)
}

autoplot(print(mark(
  fuj = fuj_default(),
  base = base_default(),
  iterations = I
)))

# Exact match supplied
fuj_exact <- function(x = c("apple", "banana", "orange")) {
  match_arg(x)
}

base_exact <- function(x = c("apple", "banana", "orange")) {
  base::match.arg(x)
}

autoplot(print(mark(
  fuj = fuj_exact("banana"),
  base = base_exact("banana"),
  iterations = I
)))

# Partial matching
fuj_partial <- function(x = c("apple", "apricot", "banana")) {
  match_arg(x, partial = TRUE)
}

base_partial <- function(x = c("apple", "apricot", "banana")) {
  base::match.arg(x)
}

autoplot(print(mark(
  fuj = fuj_partial("app"),
  base = base_partial("app"),
  iterations = I
)))

# `several.ok` / `multiple`
fuj_multiple <- function(x = c("apple", "banana", "orange")) {
  match_arg(x, multiple = TRUE)
}

base_multiple <- function(x = c("apple", "banana", "orange")) {
  base::match.arg(x, several.ok = TRUE)
}

autoplot(print(mark(
  fuj = fuj_multiple(),
  base = base_multiple(),
  iterations = I
)))

autoplot(print(mark(
  fuj = fuj_multiple(c("apple", "orange")),
  base = base_multiple(c("apple", "orange")),
  iterations = I
)))

# Failure path: invalid arg errors
fuj_fail <- function(x = c("apple", "banana", "orange")) {
  match_arg(x)
}

base_fail <- function(x = c("apple", "banana", "orange")) {
  base::match.arg(x)
}

autoplot(print(mark(
  fuj = tryCatch(fuj_fail("pear"), error = \(e) NULL),
  base = tryCatch(base_fail("pear"), error = \(e) NULL),
  iterations = I
)))
