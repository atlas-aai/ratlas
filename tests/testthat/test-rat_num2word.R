context("test-rat_num2word")

test_that("x must be numeric", {
  expect_error(check_numeric("try"), "`x` must be numeric.")
  expect_error(check_numeric(c("try", "to")), "`x` must be numeric.")
})

test_that("x is length one", {
  expect_error(check_xlength(c(1, 2, 3)), "`x` must be length one.")
})

test_that("x is correctly converted to word", {
  expect_match(rat_num2word(0), "zero")
  expect_match(rat_num2word(1), "one")
  expect_match(rat_num2word(2), "two")
  expect_match(rat_num2word(3), "three")
  expect_match(rat_num2word(4), "four")
})

test_that("x in an integer from 0 to 10", {
  expect_error(check_range09(-1), "`x` must be an integer from 0 through 9.")
  expect_error(check_range09(20), "`x` must be an integer from 0 through 9.")
  expect_error(check_range09(1.5), "`x` must be an integer from 0 through 9.")
})
