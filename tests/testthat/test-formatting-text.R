test_that("italics work", {
  err <- rlang::catch_cnd(fmt_italic(string = 3, indicator = "*", html = TRUE))
  expect_s3_class(err, "rlang_error")
  expect_match(err$message, "be a character vector")

  err <- rlang::catch_cnd(fmt_italic(
    string = "Make *this* italic.",
    indicator = 2,
    html = TRUE
  ))
  expect_s3_class(err, "rlang_error")
  expect_match(err$message, "be a single string")

  err <- rlang::catch_cnd(fmt_italic(
    string = "Make *this* italic.",
    indicator = "*",
    html = "blue"
  ))
  expect_s3_class(err, "rlang_error")
  expect_match(err$message, "must be `TRUE` or `FALSE`")

  expect_identical(
    fmt_italic(string = "Make *this* italic.", indicator = "*", html = TRUE),
    "Make <em>this</em> italic."
  )
  expect_identical(
    fmt_italic(string = "Make *this* italic.", indicator = "*", html = FALSE),
    "Make \\textit{this} italic."
  )

  col_names <- c("Grade", "*n*", "*p*-value", "Effect size")
  expect_identical(
    fmt_italic(col_names, html = TRUE),
    c("Grade", "<em>n</em>", "<em>p</em>-value", "Effect size")
  )
  expect_identical(
    fmt_italic(col_names, html = FALSE),
    c("Grade", "\\textit{n}", "\\textit{p}-value", "Effect size")
  )

  expect_snapshot(cat(kableExtra::kbl(
    mtcars[1:2, 1:4],
    format = "html",
    escape = FALSE,
    col.names = fmt_italic(col_names, html = TRUE)
  )))
  expect_snapshot(kableExtra::kbl(
    mtcars[1:2, 1:4],
    format = "latex",
    escape = FALSE,
    col.names = fmt_italic(col_names, html = FALSE)
  ))
})
