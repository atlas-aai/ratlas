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

test_that("check_pos_int", {
  err <- rlang::catch_cnd(check_pos_int("a", "check1"))
  expect_s3_class(err, "error_bad_argument")
  expect_equal(err$arg, "check1")
  expect_match(err$message, "numeric scalar")
  expect_equal(err$not, "character")

  err <- rlang::catch_cnd(check_pos_int(1:2, "check1"))
  expect_s3_class(err, "error_bad_argument")
  expect_equal(err$arg, "check1")
  expect_match(err$message, "length 1")
  expect_equal(err$not, 2L)

  err <- rlang::catch_cnd(check_pos_int(NA_real_, "check1"))
  expect_s3_class(err, "error_bad_argument")
  expect_equal(err$arg, "check1")
  expect_match(err$message, "non-missing")

  err <- rlang::catch_cnd(check_pos_int(-2, "check1"))
  expect_s3_class(err, "error_bad_argument")
  expect_equal(err$arg, "check1")
  expect_match(err$message, "greater than zero")

  expect_identical(check_pos_int(3, "check1"), 3L)
  expect_identical(check_pos_int(4L, "check1"), 4L)
})

test_that("check_bound_real", {
  err <- rlang::catch_cnd(check_bound_real("a", "check1", -1, 1))
  expect_s3_class(err, "error_bad_argument")
  expect_equal(err$arg, "check1")
  expect_match(err$message, "numeric")
  expect_equal(err$not, "character")

  err <- rlang::catch_cnd(check_bound_real(-2, "check1", -1, 1))
  expect_s3_class(err, "error_bad_argument")
  expect_equal(err$arg, "check1")
  expect_match(err$message, "between -1 and 1")

  err <- rlang::catch_cnd(check_bound_real(3, "check1", 0, 1))
  expect_s3_class(err, "error_bad_argument")
  expect_equal(err$arg, "check1")
  expect_match(err$message, "between 0 and 1")

  expect_identical(check_bound_real(test <- runif(1), "check1", 0, 1), test)
  expect_identical(check_bound_real(test <- runif(5), "check1", 0, 1), test)
  expect_identical(check_bound_real(test <- runif(1, -1, 1), "check1", -1, 1),
                   test)
  expect_identical(check_bound_real(test <- runif(20, -1, 1), "check1", -1, 1),
                   test)
})

test_that("check_number", {
  err <- rlang::catch_cnd(check_number("a", "check1"))
  expect_s3_class(err, "error_bad_argument")
  expect_equal(err$arg, "check1")
  expect_match(err$message, "numeric")
  expect_equal(err$not, "character")

  expect_equal(check_number(3), 3)
  expect_equal(check_number(1:5), 1:5)
  expect_equal(check_number(3L), 3L)
})

test_that("check_character", {
  err <- rlang::catch_cnd(check_character(4L, "check1"))
  expect_s3_class(err, "error_bad_argument")
  expect_equal(err$arg, "check1")
  expect_match(err$message, "character")
  expect_equal(err$not, "integer")

  expect_equal(check_character("a"), "a")
  expect_equal(check_character(c("jake")), "jake")
  expect_equal(check_character(letters), letters)
})
