context("Converting number to ordinal number")

test_that("x is numeric", {
  expect_error(check_numeric("try"), "`x` must be numeric.")
})

test_that("x is length one", {
  expect_error(check_xlength(c(1, 2)), "`x` must be length one.")
  expect_error(check_xlength(c(1, 2, 3)), "`x` must be length one.")
})

test_that("x is a valid value", {
  expect_error(check_range(-1), "`x` must be an integer from 1 through 10.")
  expect_error(check_range(20), "`x` must be an integer from 1 through 10.")
  expect_error(check_range(1.5), "`x` must be an integer from 1 through 10.")
})

test_that("x is correctly converted", {
  expect_equal(rat_order_num(1), "first")
  expect_equal(rat_order_num(8), "eighth")
})
