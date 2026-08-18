# Match arguments

Much like [`base::match.arg()`](https://rdrr.io/r/base/match.arg.html)
with a few key differences:

- Will not perform partial matching (by default)

- Will not return error messages with curly quotations

- Special handling for `NULL` values

- Allows recoding of values via named lists or lists of formulas

## Usage

``` r
match_arg(
  arg,
  choices,
  multiple = FALSE,
  partial = getOption("fuj.match_arg.partial", FALSE),
  null = c("error", "first", "all", "null")
)
```

## Arguments

- arg:

  The argument

- choices:

  The available choices; named lists will return the name (a character)
  for when matched to the value within the list element. A list of
  formula objects (preferred) retains the LHS of the formula as the
  return value when matched to the RHS of the formula.

- multiple:

  If `TRUE` allows multiple values to be returned

- partial:

  If `TRUE` allows partial matching via
  [`base::pmatch()`](https://rdrr.io/r/base/pmatch.html)

- null:

  Controls how `arg = NULL` is handled

## Value

A single value from `arg` matched on `choices`

## Details

Argument matching for an argument

## Examples

``` r
fruits <- function(x = c("apple", "banana", "orange")) {
  match_arg(x)
}

fruits()         # apple
#> [1] "apple"
try(fruits("b")) # must be exact fruits("banana")
#> Error : <fuj::match_arg_error> fuj::match_arg(x) failed: `"b"` is not one of `c("apple", "banana", "orange")`

pfruits <- function(x = c("apple", "apricot", "banana")) {
  match_arg(x, partial = TRUE)
}
pfruits()          # apple
#> [1] "apple"
try(pfruits("ap")) # fuj:arg_match_error
#> Error : <fuj::match_arg_error> fuj::match_arg(x) failed: `"ap"` is not one of `c("apple", "apricot", "banana")`
pfruits("app")     # apple
#> [1] "apple"

afruits <- function(x = c("apple", "banana", "orange")) {
  match_arg(x, multiple = TRUE)
}

afruits() # apple, banana, orange
#> [1] "apple"  "banana" "orange"

# can have multiple responses
how_much <- function(x = list(too_few = 0:2, ok = 3:5, too_many = 6:10)) {
  match_arg(x)
}

how_much(1)
#> [1] 1
how_much(3)
#> [1] 3
how_much(9)
#> [1] 9

# use a list of formulas instead
ls <- list(1L ~ 0:1, 2L, 3L ~ 3:5)
sapply(0:5, match_arg, choices = ls)
#> [1] 0 1 2 3 4 5
```
