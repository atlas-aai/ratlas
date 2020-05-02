test_that("x must be a valid value", {
  expect_error(check_cap_words(1), "length one character vector")
  expect_error(check_cap_words(TRUE), "length one character vector")
  expect_error(check_cap_words(c("a", "b", "c")), "length one character vector")
  expect_error(check_cap_words(NA_character_), "non-missing")
})

test_that("all must be a valid value", {
  expect_error(check_all("a"), "length one logical vector")
  expect_error(check_all(1:10), "length one logical vector")
  expect_error(check_all(NA), "non-missing")
})

test_that("words capitalize", {
  expect_equal(rat_cap_words("state"), "State")
  expect_equal(rat_cap_words("state", all = TRUE), "State")
  expect_equal(rat_cap_words("zip code"), "Zip code")
  expect_equal(rat_cap_words("zip code", all = TRUE), "Zip Code")
  expect_equal(rat_cap_words("quick brown fox"), "Quick brown fox")
  expect_equal(rat_cap_words("quick brown fox", all = TRUE), "Quick Brown Fox")
})
