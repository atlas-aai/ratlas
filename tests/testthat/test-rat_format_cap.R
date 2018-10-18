context("Capitalization formatting")

test_that("x must be a valid value", {
  expect_error(rat_format_cap(1), "`x` must be a character string.")
  expect_error(rat_format_cap(atlas), "object 'atlas' not found")
  expect_error(check_x(14), "`x` must be a character string.")
})

test_that("x must be length one", {
  expect_error(check_singlestring(c("hi", "bye")), "`x` must be length one.")
})

test_that("allwords must be a valid value", {
  expect_error(check_logical(allwords = "yes"),
               "`allwords` must be either TRUE or FALSE.")
  expect_error(check_logical(allwords = 1),
               "`allwords` must be either TRUE or FALSE.")
})

test_that("string is correctly capitalized", {
  expect_match(rat_format_cap("testing is fun!"), "Testing is fun!", all = TRUE)
  expect_match(rat_format_cap("testing is fun!", TRUE),
               "Testing Is Fun!",
               all = TRUE)
})
