test_that("collapse()", {
  expect_identical(
    collapse(list(1:3, letters[1:3]), 5:7, letters[5:7]),
    "123abc567efg"
  )

  expect_identical(
    collapse(1:3, letters[5:7], sep = "_"),
    "1_2_3_e_f_g"
  )
})
