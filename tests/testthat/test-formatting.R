test_that("fmt_digits", {
  rand <- runif(5)
  int_rand <- runif(5, min = 1, max = 99)
  err <- rlang::catch_cnd(fmt_digits(rand, digits = -1))
  expect_s3_class(err, "error_bad_argument")
  expect_equal(err$arg, "digits")
  expect_match(err$message, "greater than or equal to zero")

  expect_equal(fmt_digits(rand), sprintf("%0.3f", rand))
  expect_equal(fmt_digits(rand, digits = 2), sprintf("%0.2f", rand))

  expect_equal(fmt_digits(1.45038), "1.450")
  expect_equal(fmt_digits(c(1.2309, 0.3819, NA_real_, 0.0417), digits = 2),
               c("1.23", "0.38", NA_character_, "0.04"))

  expect_equal(fmt_digits(int_rand, digits = 0), sprintf("%0.0f", int_rand))
})

test_that("fmt_prop_pct", {
  rand <- runif(5)

  err <- rlang::catch_cnd(fmt_prop_pct(rand, digits = -1))
  expect_s3_class(err, "error_bad_argument")
  expect_equal(err$arg, "digits")
  expect_match(err$message, "greater than or equal to zero")

  err <- rlang::catch_cnd(fmt_prop_pct(rand * 100, digits = 1))
  expect_s3_class(err, "error_bad_argument")
  expect_equal(err$arg, "x")
  expect_match(err$message, "between 0 and 1")

  rand <- runif(5)
  expect_equal(fmt_prop_pct(rand, fmt_small = FALSE),
               sprintf("%0.0f", rand * 100))
  expect_equal(fmt_prop_pct(rand, digits = 2, fmt_small = FALSE),
               sprintf("%0.2f", rand * 100))

  expect_equal(fmt_prop_pct(c(0.012, 0.009, 0.004, 0.989, 0.994, 0.997)),
               c("1", "1", "< 1", "99", "99", "> 99"))
  expect_equal(fmt_prop_pct(c(0.829, 0.080, NA_real_, 0.313, 0.002, 0.0004,
                              0.998, 0.9999), digits = 1),
               c("82.9", "8.0", NA_character_, "31.3", "0.2", "< 0.1", "99.8",
                 "> 99.9"))
})

test_that("fmt_leading_zero", {
  expect_warning(fmt_leading_zero("1.34"), "Non-zero")
  expect_warning(expect_warning(fmt_leading_zero("a"), "coercion"), "coercion")

  expect_equal(fmt_leading_zero("0.4958"), ".4958")
  expect_equal(fmt_leading_zero("-0.4081"), "-.4081")
  expect_equal(fmt_leading_zero(c("0.394", "0.768", "0.826")),
               c(".394", ".768", ".826"))
  expect_equal(fmt_leading_zero(c("0.394", "0.768", "0.000")),
               c(".394", ".768", ".000"))
  expect_equal(fmt_leading_zero(c("0.394", "0.768", "0")),
               c(".394", ".768", ".000"))
  expect_equal(fmt_leading_zero(c("0.394", "0.7698", "0")),
               c(".394", ".7698", ".0000"))
})

test_that("fmt_minus", {
  expect_equal(fmt_minus("-3.90", output = "html"), "&minus;3.90")
  expect_equal(fmt_minus("-0.00001", output = "html"), "&minus;0.00001")
  expect_equal(fmt_minus("-0", output = "html"), "0")
  expect_equal(fmt_minus("-0.0", output = "html"), "0.0")

  expect_equal(fmt_minus("-3.90", output = "latex"), "--3.90")
  expect_equal(fmt_minus("-0.00001", output = "latex"), "--0.00001")
  expect_equal(fmt_minus("-0", output = "latex"), "0")
  expect_equal(fmt_minus("-0.0", output = "latex"), "0.0")
})

test_that("fmt_replace_na", {
  expect_error(fmt_replace_na(NA_real_, "&mdash;"), "character vector")
  expect_equal(fmt_replace_na(NA_character_, "&mdash;"), "&mdash;")
  expect_equal(fmt_replace_na(NA_real_, 4), 4)

  test <- c(0.4630685, 0.7966377, 0.5037911, NA, 0.6172584, 0.3771406) %>%
    fmt_digits() %>%
    fmt_replace_na()
  expect_equal(test, c("0.463", "0.797", "0.504", "&mdash;", "0.617", "0.377"))
})

test_that("paste0_after", {
  expect_equal(paste0_after("arg1", "arg2", .first = "arg3"),
               "arg3arg1arg2")
})

test_that("fmt_corr", {
  test <-  c(-0.41483, 0.24283, 0.72335, -1.00000, -0.40425,
             -0.41140, 0.89842,      NA, -0.15477,  1.00000)
  test2 <- c(-0.41483, 2.00000, 0.72335, -1.00000, -0.40425,
             -0.41140, 0.89842,      NA, -0.15477,  1.00000)

  err <- rlang::catch_cnd(fmt_corr(test2, digits = 3))
  expect_s3_class(err, "error_bad_argument")
  expect_equal(err$arg, "x")
  expect_match(err$message, "between -1 and 1")

  err <- rlang::catch_cnd(fmt_corr(test, digits = -1))
  expect_s3_class(err, "error_bad_argument")
  expect_equal(err$arg, "digits")
  expect_match(err$message, "greater than zero")

  check1 <- test %>%
    fmt_corr(digits = 3)
  expect_equal(check1, c("&minus;.415", ".243", ".723", "&minus;1.000",
                         "&minus;.404", "&minus;.411", ".898", NA,
                         "&minus;.155", "1.000"))

  check2 <- test %>%
    fmt_corr(digits = 2)
  expect_equal(check2, c("&minus;.41", ".24", ".72", "&minus;1.00",
                         "&minus;.40", "&minus;.41", ".90", NA,
                         "&minus;.15", "1.00"))
})

test_that("fmt_prop", {
  test <-  c(0.85319, 1.00000, 0.85479,       NA, 0.69029,
             0.00100, 0.12918, 0.86919,  0.16885, 0.00000)
  test2 <- c(0.85319, 1.00000, 0.85479,       NA, 0.69029,
             0.00100, 0.12918, 0.86919, -0.16885, 0.00000)

  err <- rlang::catch_cnd(fmt_prop(test2, digits = 3))
  expect_s3_class(err, "error_bad_argument")
  expect_equal(err$arg, "x")
  expect_match(err$message, "between 0 and 1")

  err <- rlang::catch_cnd(fmt_prop(test, digits = -1))
  expect_s3_class(err, "error_bad_argument")
  expect_equal(err$arg, "digits")
  expect_match(err$message, "greater than zero")

  check1 <- test %>%
    fmt_prop(digits = 3)
  expect_equal(check1, c(".853", "> .999", ".855",     NA,   ".690",
                         ".001",  ".129", ".869", ".169", "< .001"))

  check1_2 <- test %>%
    fmt_prop(digits = 3, fmt_small = FALSE)
  expect_equal(check1_2, c(".853", "1.000", ".855",     NA,   ".690",
                           ".001",  ".129", ".869", ".169", ".000"))

  check2 <- test %>%
    fmt_prop(digits = 2)
  expect_equal(check2, c(".85",   "> .99", ".85",    NA,   ".69",
                         "< .01",  ".13", ".87", ".17", "< .01"))

  check2_2 <- test %>%
    fmt_prop(digits = 2, fmt_small = FALSE)
  expect_equal(check2_2, c(".85",   "1.00", ".85",    NA,   ".69",
                           ".00",  ".13", ".87", ".17", ".00"))

  check3 <- test %>%
    fmt_prop(digits = 2, fmt_small = FALSE)
  expect_equal(check3, c(".85", "1.00", ".85",    NA, ".69",
                         ".00",  ".13", ".87", ".17", ".00"))
})
