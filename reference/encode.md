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

## Details

`encode()` is a general purpose function for replacing values in a
vector.

`fact()` is a low-level function for building `factor` vectors. It does
not perform any [`sort()`](https://rdrr.io/r/base/sort.html)ing of
levels (unlink [`base::factor()`](https://rdrr.io/r/base/factor.html)).
Re-leveling can be done by applying `encode()` to the levels of a
`factor` object.

## Examples

``` r
fact(strsplit("factor function", "")[[1L]], exclude = " ")
#>  [1] f    a    c    t    o    r    <NA> f    u    n    c    t    i    o    n   
#> Levels: f a c t o r u n i

# encode() can be used to for the same utility as factor(x, levels, labels)
# (note: applying to levels can be more efficient)
(x <- fact(strsplit("jordan", "")[[1L]]))
#> [1] j o r d a n
#> Levels: j o r d a n
levels(x) <- encode(levels(x), from = c("a", "o"), to = "*")
x
#> [1] j * r d * n
#> Levels: j * r d n
```
