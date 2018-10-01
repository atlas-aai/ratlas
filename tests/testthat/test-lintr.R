library(lintr)
context("lints")

test_that("Package style", {
  lintr::expect_lint_free()
})
