context("tech report rmarkdown renderers")

test_that("techreport-pdf renders", {
  testthat::skip_on_cran()

  # work in a temp directory
  dir <- tempfile()
  dir.create(dir)
  oldwd <- setwd(dir)
  on.exit(setwd(oldwd), add = TRUE)

  techreport_skeleton(dir)
  rmarkdown::render("template.tex")
  expect_true(file.exists("template.pdf"))
})
