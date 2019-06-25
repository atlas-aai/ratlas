context("vignette renders")

test_that("vignette renders", {
  testthat::skip_on_cran()

  # work in a temp directory
  dir <- tempfile()
  dir.create(dir)
  oldwd <- setwd(dir)
  on.exit(setwd(oldwd), add = TRUE)

  vignette_skeleton(dir)
  rmarkdown::render("report-writing-vignette.Rmd")
  expect_true(file.exists("report-writing-vignette.html"))
})
