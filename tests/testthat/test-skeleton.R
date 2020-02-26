context("project-skeletons")

test_that("copying topicguide docx files works", {
  testthat::skip_on_cran()

  # work in a temp directory
  dir <- tempfile()
  dir.create(dir)
  oldwd <- setwd(dir)
  on.exit(setwd(oldwd), add = TRUE)

  topicguide_docx_skeleton(dir)
  check_files <- list.files(dir, recursive = TRUE)

  expect_equal(sort(check_files),
               sort(c("bib/refs.bib", "csl/apa.csl", "index.Rmd",
                      "_bookdown.yml")))
})

test_that("copying topicguide pdf files works", {
  testthat::skip_on_cran()

  # work in a temp directory
  dir <- tempfile()
  dir.create(dir)
  oldwd <- setwd(dir)
  on.exit(setwd(oldwd), add = TRUE)

  topicguide_pdf_skeleton(dir)
  check_files <- list.files(dir, recursive = TRUE)

  expect_equal(sort(check_files),
               sort(c("bib/refs.bib", "csl/apa.csl", "index.Rmd",
                      "figures/pre-generated/letterhead.png",
                      "figures/pre-generated/letterhead.jpg",
                      "figures/pre-generated/ATLAS.png",
                      "figures/pre-generated/DLM.png",
                      "figures/pre-generated/I-SMART.png")))
})

test_that("copying techreport pdf files works", {
  testthat::skip_on_cran()

  # work in a temp directory
  dir <- tempfile()
  dir.create(dir)
  oldwd <- setwd(dir)
  on.exit(setwd(oldwd), add = TRUE)

  techreport_skeleton(dir)
  check_files <- list.files(dir, recursive = TRUE)

  expect_equal(sort(check_files),
               sort(c("bib/refs.bib", "csl/apa.csl", "index.Rmd",
                      "figures/pre-generated/letterhead.png",
                      "figures/pre-generated/letterhead.jpg",
                      "figures/pre-generated/ATLAS.png",
                      "figures/pre-generated/DLM.png",
                      "figures/pre-generated/I-SMART.png",
                      "front-matter/preface.Rmd")))
})
