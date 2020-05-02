test_that("copying topicguide docx files works", {
  testthat::skip_on_cran()

  # work in a temp directory
  dir <- create_local_rmd_dir()

  topicguide_docx_skeleton(dir)
  check_files <- list.files(dir, recursive = TRUE)

  expect_equal(sort(check_files),
               sort(c("bib/refs.bib", "csl/apa.csl",
                      paste0(tolower(basename(dir)), ".Rmd"),
                      "_bookdown.yml")))
})

test_that("copying topicguide pdf files works", {
  testthat::skip_on_cran()

  # work in a temp directory
  dir <- create_local_rmd_dir()

  topicguide_pdf_skeleton(dir)
  check_files <- list.files(dir, recursive = TRUE)

  expect_equal(sort(check_files),
               sort(c("bib/refs.bib", "csl/apa.csl", "_bookdown.yml",
                      paste0(tolower(basename(dir)), ".Rmd"),
                      "figures/pre-generated/letterhead.png",
                      "figures/pre-generated/letterhead.jpg",
                      "figures/pre-generated/ATLAS.png",
                      "figures/pre-generated/DLM.png",
                      "figures/pre-generated/I-SMART.png")))
})

test_that("copying techreport pdf files works", {
  testthat::skip_on_cran()

  # work in a temp directory
  dir <- create_local_rmd_dir()

  techreport_skeleton(dir)
  check_files <- list.files(dir, recursive = TRUE)

  expect_equal(sort(check_files),
               sort(c("_bookdown.yml", "bib/refs.bib", "csl/apa.csl",
                      paste0(tolower(basename(dir)), ".Rmd"),
                      "figures/pre-generated/letterhead.png",
                      "figures/pre-generated/letterhead.jpg",
                      "figures/pre-generated/ATLAS.png",
                      "figures/pre-generated/DLM.png",
                      "figures/pre-generated/I-SMART.png",
                      "front-matter/preface.Rmd")))
})
