context("Concatenating a vector")
testing <- c("Cheeseburger", "fries", "a milkshake")

test_that("vec must be a valid value", {
  expect_error(rat_connect_vect(testing35), "object 'testing35' not found")
  expect_error(check_vec(1), "`vec` must be a character vector.")
})

test_that("final must be a valid value", {
  expect_error(rat_connect_vect(testing, but), "object 'but' not found")
  expect_error(check_final(2), "`final` must be a character object.")
})

test_that("final must be length one", {
  expect_error(check_finallength(c("cat", "dog")),
               "`final` must be length one.")
})

test_that("vector is correctly concatenated", {
  expect_match(rat_connect_vect(testing),
               "Cheeseburger, fries, and a milkshake",
               all = TRUE)
})

test_that("a vector with length one is returned", {
  expect_match(rat_connect_vect("hello"), "hello")
})

test_that("a vector with length == 2 is correctly concatenated", {
  expect_match(rat_connect_vect(c("hello", "goodbye")), "hello and goodbye")
  expect_match(rat_connect_vect(c("pink", "purple"), "or"), "pink or purple")
})
