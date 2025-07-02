test_that("words capitalize", {
  expect_equal(capitalize_words("state"), "State")
  expect_equal(capitalize_words("state", all = TRUE), "State")
  expect_equal(capitalize_words("zip code"), "Zip code")
  expect_equal(capitalize_words("zip code", all = TRUE), "Zip Code")
  expect_equal(capitalize_words("quick brown fox"), "Quick brown fox")
  expect_equal(capitalize_words("quick brown fox", all = TRUE), "Quick Brown Fox")
})
