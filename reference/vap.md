# Vector applies

Apply a function over elements of a `vector`.

## Usage

``` r
vap(x, f, ...)

vapi(x, f, ...)

vap2(x, y, f, ...)

vap3(x, y, z, f, ...)

vapp(p, f, ...)

vap_vec(x, f, ...)

vap_lgl(x, f, ...)

vap_int(x, f, ...)

vap_dbl(x, f, ...)

vap_chr(x, f, ...)

vap_raw(x, f, ...)

vap_cpl(x, f, ...)

vap_date(x, f, ...)

vap_dttm(x, f, ...)

vapi_lgl(x, f, ...)

vapi_int(x, f, ...)

vapi_dbl(x, f, ...)

vapi_chr(x, f, ...)

vapi_raw(x, f, ...)

vapi_cpl(x, f, ...)

vapi_date(x, f, ...)

vapi_dttm(x, f, ...)

vap2_lgl(x, y, f, ...)

vap2_int(x, y, f, ...)

vap2_dbl(x, y, f, ...)

vap2_chr(x, y, f, ...)

vap2_raw(x, y, f, ...)

vap2_cpl(x, y, f, ...)

vap2_date(x, y, f, ...)

vap2_dttm(x, y, f, ...)

vap3_lgl(x, y, z, f, ...)

vap3_int(x, y, z, f, ...)

vap3_dbl(x, y, z, f, ...)

vap3_chr(x, y, z, f, ...)

vap3_raw(x, y, z, f, ...)

vap3_cpl(x, y, z, f, ...)

vap3_date(x, y, z, f, ...)

vap3_dttm(x, y, z, f, ...)

vapp_lgl(p, f, ...)

vapp_int(p, f, ...)

vapp_dbl(p, f, ...)

vapp_chr(p, f, ...)

vapp_raw(p, f, ...)

vapp_cpl(p, f, ...)

vapp_date(p, f, ...)

vapp_dttm(p, f, ...)

with_vap_progress(expr)

with_vap_handlers(expr)
```

## Arguments

- x, y, z:

  Values to map over

- f:

  Function or specification of function to apply.

- ...:

  Additional arguments passed to `f`

- p:

  A list of values (i.e., parameters) to map over

- expr:

  The expression to evaluate.

## Value

For `vap()`, `vapi()`, returns a `list` with length of `x`. For
`vap2()`, `vap3()`, and `vap()`, return length is determined by how
`...` is recycled inside
[`mapply()`](https://rdrr.io/r/base/mapply.html).

All have type variants (e.g., `vap_chr()`, `vapi_int()`, `vap3_dbl()`)
which return a vector of the corresponding class, with the same length
of `x`, or following the same recycling rules as
[`mapply()`](https://rdrr.io/r/base/mapply.html) for multiple inputs.
These returns are *coerced*, rather than *checked*, and may result in
unexpected outputs. Likely, warnings or errors will be signaled
accordingly.

`vap_vec()` is a variant of `vap()` that returns a *flattened* vector.
This has similar behavior as
[`base::sapply()`](https://rdrr.io/r/base/lapply.html), in that a `list`
will be returned if the
[`base::unlist()`](https://rdrr.io/r/base/unlist.html)'d output has
multiple values in an element.

`with_vap_progress()` sets an option `vap.progress` to `TRUE` for the
duration of `expr`, which causes a progress bar to be displayed for any
`vap*` calls inside `expr`.

`with_vap_handlers()` sets an `options(vap.indexed_errors = TRUE)` for
the duration of `expr`, which causes errors inside `vap` calls to
include the index at which the error occurred.

## Details

Like [`lapply()`](https://rdrr.io/r/base/lapply.html),
[`mapply()`](https://rdrr.io/r/base/mapply.html), and family, the `vap`
functions provide a means of applying a function to each element of a
`vector`, and controlling return types. The `vap` family provides extra
tools and controls, as well as *date* outputs (i.e., `_date`, `_dttm`
variants that work with `Date` and `POSIXct` types).

- `vap()` uses a single `x` argument

- `vapi()` uses a single `x` argument and passes the names (when
  available, otherwise index) as the second argument

- `vap2()`, `vap3()` use two and three arguments, respectively

- `vapp()` uses a pairlist of arguments

## Extras

Two helper functions are provided to set options for a progress bars
(`options(fuj.vap.progress)`) and reporting an index during and error
(`options(fuj.vap.index_error)`). Two wrapper functions are provided:
`with_vap_progress()` and `with_vap_handlers()`, respectively; the
latter may include other handlers in the future. These are not turned on
by default (or rather, the option settings are set to `FALSE` within
`{fuj}`) as they incur some additional overhead.

## Examples

``` r
fruits <- c("apple", "banana", "pear")
vap(fruits, toupper)
#> [[1]]
#> [1] "APPLE"
#> 
#> [[2]]
#> [1] "BANANA"
#> 
#> [[3]]
#> [1] "PEAR"
#> 
vapi(fruits, function(x, i) paste0(i, ": ", toupper(x)))
#> [[1]]
#> [1] "1: APPLE"
#> 
#> [[2]]
#> [1] "2: BANANA"
#> 
#> [[3]]
#> [1] "3: PEAR"
#> 
vap_int(set_names(month.name, month.abb), nchar)
#> Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec 
#>   7   8   5   5   3   4   4   6   9   7   8   8 
vap2_dbl(1:5, 6:10, `+`)
#> [1]  7  9 11 13 15
vapp_int(list(x = 1:5, y = 6:10, z = 11:15), sum)
#> [1] 18 21 24 27 30

# return type is coerced:
vap_int(1:5, paste0, "9")  # character -> integer
#> [1] 19 29 39 49 59
vap_date(month.name, nchar) # integer -> Date
#>  [1] "1970-01-08" "1970-01-09" "1970-01-06" "1970-01-06" "1970-01-04"
#>  [6] "1970-01-05" "1970-01-05" "1970-01-07" "1970-01-10" "1970-01-08"
#> [11] "1970-01-09" "1970-01-09"

# when f is a character or number, subsetting is performed
x <- list(list(a = 1, b = 3), list(a = 2, b = 4))
vap_int(x, "a")
#> [1] 1 2
vap_int(x, 2)
#> [1] 3 4

# wrap in [with_vap_progress()] to show a progress bar
invisible(
  with_vap_progress(
    vap(1:10 / 20, Sys.sleep)
  )
)
#>   |                                                                              |                                                                      |   0%  |                                                                              |=======                                                               |  10%  |                                                                              |==============                                                        |  20%  |                                                                              |=====================                                                 |  30%  |                                                                              |============================                                          |  40%  |                                                                              |===================================                                   |  50%  |                                                                              |==========================================                            |  60%  |                                                                              |=================================================                     |  70%  |                                                                              |========================================================              |  80%  |                                                                              |===============================================================       |  90%  |                                                                              |======================================================================| 100%

# wrap in [with_vap_handlers()] to report index on error
try(
  with_vap_handlers(
    vap(10:1, function(x) if (x == 3) stop("bad"))
  )
)
#> Error in vap(10:1, function(x) if (x == 3) stop("bad")) : 
#>   error at index: 8:
#>  bad
```
