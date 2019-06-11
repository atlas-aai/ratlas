context("tech-report-project-skeletons")

test_that("techreport pdf works", {
  testthat::skip_on_cran()

  # work in a temp directory
  dir <- tempfile()
  dir.create(dir)
  oldwd <- setwd(dir)
  on.exit(setwd(oldwd), add = TRUE)

  techreport_skeleton(dir)
  check_files <- list.files(dir, recursive = TRUE)

  expect_equal(check_files, c(
    "bib/refs.bib", "csl/apa.csl",
    "figure/ATLAS_icon.png", "template.pdf",
    "template.tex"
  ))
})
