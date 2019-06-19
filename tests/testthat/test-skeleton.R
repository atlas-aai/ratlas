context("project-skeletons")

test_that("topicguide docx works", {
  testthat::skip_on_cran()

  # work in a temp directory
  dir <- tempfile()
  dir.create(dir)
  oldwd <- setwd(dir)
  on.exit(setwd(oldwd), add = TRUE)

  topicguide_skeleton(dir)
  check_files <- list.files(dir, recursive = TRUE)

  expect_equal(sort(check_files),
               sort(c("bib/refs.bib", "csl/apa.csl", "index.Rmd",
                      "_bookdown.yml")))
})
