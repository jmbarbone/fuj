# Colons

Get an object from a namespace

## Usage

``` r
package %::% name

package %:::% name

package %colons% name
```

## Arguments

- package:

  Name of the package

- name:

  Name to retrieve

## Value

The variable `name` from package `package`

## Details

The functions mimic the use of `::` and `:::` for extracting values from
namespaces. `%colons%` is an alias for `%::%`.

## WARNING

To reiterate from other documentation: it is not advised to use `:::` in
your code as it will retrieve non-exported objects that may be more
likely to change in their functionality that exported objects.

## See also

[`help("::")`](https://rdrr.io/r/base/ns-dblcolon.html)

## Examples

``` r
identical("base" %::% "mean", base::mean)
#> [1] TRUE
"fuj" %:::% "colons_example" # unexported value
#> [1] "Hello, world"
```
