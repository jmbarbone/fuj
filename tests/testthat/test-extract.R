test_that("alises are correct", {
  expect_identical(subset1,    `[`)
  expect_identical(subset2,    `[[`)
  expect_identical(subset3,    `$`)
  expect_identical(subassign1, `[<-`)
  expect_identical(subassign2, `[[<-`)
  expect_identical(subassign3, `$<-`)
})
