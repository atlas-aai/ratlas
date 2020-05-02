test_that("x must be a valid value", {
  expect_error(check_apa_decimal("a"), "length one numeric vector")
  expect_error(check_apa_decimal(1:10), "length one numeric vector")
  expect_error(check_apa_decimal(2), "-1 and 1 and non-missing")
  expect_error(check_apa_decimal(-2), "-1 and 1 and non-missing")
  expect_error(check_apa_decimal(NA_real_), "-1 and 1 and non-missing")
})

test_that("digits must be a valid value", {
  expect_error(check_digits("a"), "length one numeric vector")
  expect_error(check_digits(1:10), "length one numeric vector")
  expect_error(check_digits(-1), "one or missing")
  expect_error(check_digits(0), "one or missing")
  expect_error(check_digits(NA_real_), "one or missing")
})

test_that("apa decimals round", {
  expect_equal(rat_apa_decimal(-0.44860516, digits = 3), "-.449")
  expect_equal(rat_apa_decimal(0.98244517,  digits = 2), ".98")
  expect_equal(rat_apa_decimal(0.08264625,  digits = 1), ".1")
  expect_equal(rat_apa_decimal(-0.54044132, digits = 2), "-.54")
  expect_equal(rat_apa_decimal(0.06634024,  digits = 2), ".07")
})
