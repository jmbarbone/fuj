# Yes-no prompt

Prompts the user to make a yes/no selection

## Usage

``` r
yes_no(..., na = NULL, n_yes = 1, n_no = 2, noninteractive_error = TRUE)
```

## Arguments

- ...:

  text to display

- na:

  Text for an NA response. When NULL, will not provide a possible NA
  response. When

- n_yes, n_no:

  The number of yes/no selections

- noninteractive_error:

  While `TRUE`, throws an error when the session is not interactive. If
  `FALSE`, will return `NA` instead.
