context("Capitalizing every word")
string <- "Testing is fun!"

test_that("x must be a valid value", {
  expect_error(rat_cap_words(1), "non-character argument")
  expect_error(rat_cap_words(atlas), "object 'atlas' not found")
})

test_that("string is correctly capitalized", {
  expect_match(rat_cap_words(string), "Testing Is Fun!", all = TRUE)
  expect_match(rat_cap_words("a b c d e"), "A B C D E", all = TRUE)
})
