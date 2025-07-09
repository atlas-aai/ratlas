test_that("check_output", {
  expect_equal(check_output(output = "html"), "html")
  expect_equal(check_output(output = "latex"), "latex")
  expect_error(check_output(output = "test"), "must be one of")

  withr::local_options(list(knitr.table.format = "html"))
  expect_equal(check_output(output = NULL),  "html")

  withr::local_options(list(knitr.table.format = "latex"))
  expect_equal(check_output(output = NULL),  "latex")

  withr::local_options(list(knitr.table.format = NULL))
  err <- rlang::catch_cnd(check_output(output = NULL))
  expect_s3_class(err, "rlang_error")
  expect_match(err$message, "specified or defined")
})
