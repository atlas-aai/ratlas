context("Capitalization formatting")
string <- "Testing is fun!"

test_that("x must be a valid value", {
  expect_error(rat_format_cap(1), "non-character argument")
  expect_error(rat_format_cap(atlas), "object 'atlas' not found")
})

test_that("allwords must be a valid value", {
  expect_error(rat_format_cap(string, allwords = yes), "object 'yes' not found")
})

test_that("string is correctly capitalized", {
  expect_match(rat_format_cap(string), "Testing is fun!", all = TRUE)
  expect_match(rat_format_cap("a b c d e"), "A b c d e", all = TRUE)
  expect_match(rat_format_cap(string, allwords = TRUE), "Testing Is Fun!", all = TRUE)
})
