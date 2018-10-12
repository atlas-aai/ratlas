context("test-rat_num2word")

test_that("x must be a valid value", {
  expect_error(rat_num2word(testing123test),
               "object 'testing123test' not found")
})

test_that("only one x value is inputted", {
  expect_warning(rat_num2word(c(2, 4, 6, 8)))
})

test_that("x is correctly converted to word", {
  expect_match(rat_num2word(0), "zero")
  expect_match(rat_num2word(1), "one")
  expect_match(rat_num2word(2), "two")
  expect_match(rat_num2word(3), "three")
  expect_match(rat_num2word(4), "four")
})

test_that("if x is not an integer in [0, 9], return x", {
  expect_equal(rat_num2word(11), 11)
  expect_match(rat_num2word("twenty"), "twenty")
  expect_match(rat_num2word("puppy"), "puppy")
})
