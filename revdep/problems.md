# mark (0.8.3)

* GitHub: <https://github.com/jmbarbone/mark>
* Email: <mailto:jmbarbone@gmail.com>
* GitHub mirror: <https://github.com/cran/mark>

Run `revdepcheck::revdep_details(, "mark")` for more info

## Newly broken

*   checking examples ... ERROR
     ```
     Running examples in ‘mark-Ex.R’ failed
     The error most likely occurred in:
     
     > ### Name: match_arg
     > ### Title: Match arguments
     > ### Aliases: match_arg
     > 
     > ### ** Examples
     > 
     > x <- c("apple", "banana", "orange")
     > match_arg("b", x)
     [1] "banana"
     > 
     > # Produces error
     > try(match_arg("pear", x))
     Error: pear : 'pear' did not match of of the following:
        'apple', 'banana', 'orange'
     Execution halted
     ```

*   checking tests ...
     ```
       Running ‘spelling.R’
       Running ‘testthat.R’
      ERROR
     Running the tests in ‘tests/testthat.R’ failed.
     Last 13 lines of output:
       ── Failure ('test-md5.R:14:3'): md5() works ────────────────────────────────────
       Expected `md5(quick_dfl(a = 1))` to be identical to "45aa38750405b63fd8cb81b938cdf76b".
       Differences:
       `actual`:   "289f2a369034118bf9ab8f7557f3fbcc"
       `expected`: "45aa38750405b63fd8cb81b938cdf76b"
       
       ── Failure ('test-within.R:33:3'): between_more() works ────────────────────────
       Expected `between_more(1:2, 3, 2)` to throw a warning with class <betweenMoreLrWarning>.
       ── Failure ('test-within.R:70:3'): within() ────────────────────────────────────
       Expected `within(1:2, 3, 2)` to throw a warning with class <withinLrWarning>.
       
       [ FAIL 3 | WARN 33 | SKIP 8 | PASS 357 ]
       Error:
       ! Test failures.
       Execution halted
     ```

