context("Converting number to ordinal number")

test_that("x is correctly converted", {
  expect_equal(rat_order_num(1), "first")
  expect_equal(rat_order_num(8), "eighth")
})

test_that("x is returned if it is not an integer between 1 and 10", {
  expect_equal(rat_order_num(23), 23)
  expect_equal(rat_order_num('third'), 'third')
})
