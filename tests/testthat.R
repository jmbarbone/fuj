# This file is part of the standard setup for testthat.
# It is recommended that you do not modify it.
#
# Where should you do additional test configuration?
# Learn more about the roles of various files in:
# * https://r-pkgs.org/tests.html
# * https://testthat.r-lib.org/reference/test_package.html#special-files

options(fuj.list.active = TRUE)
library(testthat)
library(fuj, mask.ok = list(testthat = "not"))

test_check("fuj")
