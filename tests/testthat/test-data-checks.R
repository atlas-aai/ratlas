test_that("check_output", {
  expect_equal(check_output(output = "html"), "html")
  expect_equal(check_output(output = "latex"), "latex")
  expect_error(check_output(output = "test"), "should be one of")

  local_knitr_output(output = "html")
  expect_equal(check_output(output = NULL),  "html")

  local_knitr_output(output = "latex")
  expect_equal(check_output(output = NULL),  "latex")

  local_knitr_output(output = NULL)
  err <- rlang::catch_cnd(check_output(output = NULL))
  expect_s3_class(err, "error_bad_argument")
  expect_equal(err$arg, "output")
  expect_match(err$message, "specified or defined")
})
