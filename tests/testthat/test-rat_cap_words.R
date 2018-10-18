context("Capitalizing every word")
string <- "Testing is fun!"

test_that("x must be character", {
  expect_error(check_char(123), "`x` must be character.")
})

test_that("x is length one", {
  expect_error(check_xlength(c(1, 2, 3)), "`x` must be length one.")
})

test_that("string is correctly capitalized", {
  expect_match(rat_cap_words(string), "Testing Is Fun!", all = TRUE)
  expect_match(rat_cap_words("a b c d e"), "A B C D E", all = TRUE)
})
