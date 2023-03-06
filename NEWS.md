# fuj 0.1.2

* `new_condition()` gains a `pkg` argument to control for prepending a package name to the condition call.  The default value of `TRUE` will try to find the `.packageName` object from your package. Change the default setting of `pkg` to prevent this addition. [#12](https://github.com/jmbarbone/fuj/issues/12)
* `require_namespace()` can now accept multiple namespaces.  The first namespace not found will throw an error [#14](https://github.com/jmbarbone/fuj/issues/14)
* `list0()` now correctly throws valid errors [#19](https://github.com/jmbarbone/fuj/issues/19)
* typo fixed in README [#20](https://github.com/jmbarbone/fuj/issues/20)

# fuj 0.1.1

* `subset2` is now exported as an alias of `[[` and `subset3` is added as an alias of `$` [#3](https://github.com/jmbarbone/fuj/issues/3)
* improved documentation for aliases [#3](https://github.com/jmbarbone/fuj/issues/3)
* improved test coverage -- no longer skipping any functions [#7](https://github.com/jmbarbone/fuj/issues/7)

# fuj 0.1.0

* First release
* Added a `NEWS.md` file to track changes to the package.
