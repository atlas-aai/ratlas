test_that("copying topicguide docx files works", {
  testthat::skip_on_cran()

  # work in a temp directory
  dir <- create_local_rmd_dir(dir = fs::file_temp(pattern = "copytpgdocx"))

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
  dir <- create_local_rmd_dir(dir = fs::file_temp(pattern = "copytpgpdf"))

  topicguide_pdf_skeleton(dir)
  check_files <- list.files(dir, recursive = TRUE)

  expect_equal(sort(check_files),
               sort(c("bib/refs.bib", "csl/apa.csl", "_bookdown.yml",
                      paste0(tolower(basename(dir)), ".Rmd"),
                      "figures/pre-generated/letterhead.png",
                      "figures/pre-generated/letterhead.jpg",
                      "figures/pre-generated/ATLAS.png",
                      "figures/pre-generated/DLM.png",
                      "figures/pre-generated/DCPS.png",
                      "figures/pre-generated/I-SMART.png")))
})

test_that("copying techreport pdf files works", {
  testthat::skip_on_cran()

  # work in a temp directory
  dir <- create_local_rmd_dir(dir = fs::file_temp(pattern = "copytrpdf"))

  techreport_pdf_skeleton(dir)
  check_files <- list.files(dir, recursive = TRUE)

  expect_equal(sort(check_files),
               sort(c("_bookdown.yml", "bib/packages.bib", "bib/refs.bib",
                      "csl/apa.csl",
                      paste0(tolower(basename(dir)), ".Rmd"),
                      "figures/pre-generated/letterhead.png",
                      "figures/pre-generated/letterhead.jpg",
                      "figures/pre-generated/ATLAS.png",
                      "figures/pre-generated/DLM.png",
                      "figures/pre-generated/DCPS.png",
                      "figures/pre-generated/I-SMART.png",
                      "figures/pre-generated/NCDB.png",
                      "front-matter/preface.Rmd")))
})

test_that("copying techreport html files works", {
  testthat::skip_on_cran()

  # work in a temp directory
  dir <- create_local_rmd_dir(dir = fs::file_temp(pattern = "copytrhtml"))

  techreport_html_skeleton(dir)
  check_files <- list.files(dir, recursive = TRUE)

  expect_equal(sort(check_files),
               sort(c("_bookdown.yml", "assets/footnote.lua",
                      "assets/style.css", "assets/style.html",
                      "bib/refs.bib", "csl/apa.csl",
                      "index.Rmd",
                      "figures/pre-generated/letterhead.png",
                      "figures/pre-generated/letterhead.jpg",
                      "figures/pre-generated/ATLAS.png",
                      "figures/pre-generated/DLM.png",
                      "figures/pre-generated/DCPS.png",
                      "figures/pre-generated/I-SMART.png",
                      "front-matter/preface-html.Rmd",
                      "front-matter/preface-latex.Rmd")))
})
