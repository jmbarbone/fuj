# Encode/factor

Low-level encoding and `factor` building

## Usage

``` r
encode(x, from, to, strict = FALSE, exclude = NULL)

fact(x, levels = NULL, exclude = NULL)
```

## Arguments

- x:

  A vector of values

- from, to:

  Vectors of the same length. Values in `x` are matched to `from` and
  replaced with the corresponding value in `to`.

- strict:

  If `TRUE`, values in `x` that are not matched to `from` will be
  replaced with `NA`. If `FALSE`, they will be left unchanged.

- exclude:

  Values in `x` that will not be matched when recoding; `exclude` will
  take priority over `from` in `encode()`.

- levels:

  A vector of unique values. If `NULL`, the unique values in `x` are
  used.

## Value

`encode()` A vector of the same length as `x` with values replaced
according to `from` and `to`.

`fact()` A `factor` vector with levels corresponding to the unique
values in `x` (or `levels` if provided).

## Examples

``` r
fact(strsplit("factor function", "")[[1L]])
#>  [1] f a c t o r   f u n c t i o n
#> Levels: f a c t o r   u n i

# encode() can be used to for the same utility as factor(x, levels, labels)
en <- encode(
  strsplit("jordan", "")[[1L]],
  from = c("a", "o"),
  to = "*",
)

en
#> [1] "j" "*" "r" "d" "*" "n"
fact(en)
#> [1] j * r d * n
#> Levels: j * r d n
```
