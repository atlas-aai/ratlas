context("rmarkdown renderers")

test_that("topicguide-docx renders", {
  testthat::skip_on_cran()

  # work in a temp directory
  dir <- tempfile()
  dir.create(dir)
  oldwd <- setwd(dir)
  on.exit(setwd(oldwd), add = TRUE)

  topicguide_skeleton(dir)
  rmarkdown::render("index.Rmd")
  expect_true(file.exists("index.docx"))
})


test_that("techreport-pdf renders", {
  testthat::skip_on_cran()

  # work in a temp directory
  dir <- tempfile()
  dir.create(dir)
  oldwd <- setwd(dir)
  on.exit(setwd(oldwd), add = TRUE)

  techreport_skeleton(dir)
  rmarkdown::render("index.Rmd")
  expect_true(file.exists("template.pdf"))
})
