test_that("italics work", {
  err <- rlang::catch_cnd(fmt_italic(string = 3, indicator = "*",
                                     html = TRUE))
  expect_s3_class(err, "error_bad_argument")
  expect_equal(err$arg, "string")
  expect_match(err$message, "be character")

  err <- rlang::catch_cnd(fmt_italic(string = "Make *this* italic.",
                                     indicator = 2, html = TRUE))
  expect_s3_class(err, "error_bad_argument")
  expect_equal(err$arg, "indicator")
  expect_match(err$message, "be character")

  err <- rlang::catch_cnd(fmt_italic(string = "Make *this* italic.",
                                     indicator = "*", html = "blue"))
  expect_s3_class(err, "error_bad_argument")
  expect_equal(err$arg, "html")
  expect_match(err$message, "be a logical")


  expect_identical(fmt_italic(string = "Make *this* italic.", indicator = "*",
                              html = TRUE),
                   "Make <em>this</em> italic.")
  expect_identical(fmt_italic(string = "Make *this* italic.", indicator = "*",
                              html = FALSE),
                   "Make \\textit{this} italic.")

  col_names <- c("Grade", "*n*", "*p*-value", "Effect size")
  expect_identical(fmt_italic(col_names, html = TRUE),
                   c("Grade", "<em>n</em>", "<em>p</em>-value", "Effect size"))
  expect_identical(fmt_italic(col_names, html = FALSE),
                   c("Grade", "\\textit{n}", "\\textit{p}-value",
                     "Effect size"))

  expect_snapshot(kableExtra::kbl(mtcars[, 1:4], format = "html",
                                  escape = FALSE,
                                  col.names = fmt_italic(col_names,
                                                         html = TRUE)))
  expect_snapshot(kableExtra::kbl(mtcars[, 1:4], format = "latex",
                                  escape = FALSE,
                                  col.names = fmt_italic(col_names,
                                                         html = FALSE)))
})

test_that("apa words works", {
  err <- rlang::catch_cnd(apa_words("14"))
  expect_s3_class(err, "error_bad_argument")
  expect_equal(err$arg, "x")
  expect_match(err$message, "numeric scalar")

  expect_identical(apa_words(14), "14")
  expect_identical(apa_words(3L), "three")
  expect_identical(apa_words(6930), "6,930")

  expect_identical(apa_words(1, ordinal = TRUE), "1st")
  expect_identical(apa_words(2, ordinal = TRUE), "2nd")
  expect_identical(apa_words(3, ordinal = TRUE), "3rd")
  expect_identical(apa_words(4, ordinal = TRUE), "4th")
  expect_identical(apa_words(5, ordinal = TRUE), "5th")
  expect_identical(apa_words(11, ordinal = TRUE), "11th")
  expect_identical(apa_words(12, ordinal = TRUE), "12th")
  expect_identical(apa_words(13, ordinal = TRUE), "13th")
  expect_identical(apa_words(21, ordinal = TRUE), "21st")
  expect_identical(apa_words(33, ordinal = TRUE), "33rd")
  expect_identical(apa_words(55, ordinal = TRUE), "55th")
  expect_identical(apa_words(62, ordinal = TRUE), "62nd")
  expect_identical(apa_words(101, ordinal = TRUE), "101st")
  expect_identical(apa_words(113, ordinal = TRUE), "113th")
})
