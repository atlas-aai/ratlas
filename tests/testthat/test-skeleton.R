test_that("copying measr pdf files works", {
  # work in a temp directory
  report_dir <- withr::local_tempdir(pattern = "msrpdf")

  measr_pdf_skeleton(report_dir)
  check_files <- list.files(report_dir, recursive = TRUE)

  expect_equal(sort(check_files),
               sort(c("bib/refs.bib", "bib/csl/apa.csl",
                      "figures/pre-generated/measr-letterhead.png",
                      paste0(tolower(basename(report_dir)), ".Rmd"))))
})

test_that("copying techreport html files works", {
  # work in a temp directory
  report_dir <- withr::local_tempdir(pattern = "trhtml")

  techreport_html_skeleton(report_dir)
  check_files <- list.files(report_dir, recursive = TRUE)

  expect_equal(sort(check_files),
               sort(c("_bookdown.yml", "assets/footnote.lua",
                      "assets/style.css", "assets/style.html",
                      "bib/refs.bib", "bib/csl/apa.csl",
                      "index.Rmd",
                      "figures/pre-generated/DLM.png",
                      "front-matter/preface-html.Rmd",
                      "front-matter/preface-latex.Rmd")))
})

test_that("copying techreport pdf files works", {
  # work in a temp directory
  report_dir <- withr::local_tempdir(pattern = "trpdf")

  techreport_pdf_skeleton(report_dir)
  check_files <- list.files(report_dir, recursive = TRUE)

  expect_equal(sort(check_files),
               sort(c("_bookdown.yml", "bib/refs.bib", "bib/csl/apa.csl",
                      "index.Rmd",
                      "figures/pre-generated/atlas-letterhead.jpg",
                      "figures/pre-generated/DLM.png",
                      "front-matter/preface.Rmd")))
})

test_that("copying topicguide docx files works", {
  # work in a temp directory
  report_dir <- withr::local_tempdir(pattern = "tpgdocx")

  topicguide_docx_skeleton(report_dir)
  check_files <- list.files(report_dir, recursive = TRUE)

  expect_equal(sort(check_files),
               sort(c("bib/refs.bib", "bib/csl/apa.csl",
                      "index.Rmd", "_bookdown.yml")))
})

test_that("copying topicguide pdf files works", {
  # work in a temp directory
  report_dir <- withr::local_tempdir(pattern = "tpgpdf")

  topicguide_pdf_skeleton(report_dir)
  check_files <- list.files(report_dir, recursive = TRUE)

  expect_equal(sort(check_files),
               sort(c("bib/refs.bib", "bib/csl/apa.csl",
                      "index.Rmd", "_bookdown.yml")))
})

test_that("copying topicguide rdocx files works", {
  # work in a temp directory
  report_dir <- withr::local_tempdir(pattern = "tpgrdocx")

  topicguide_rdocx_skeleton(report_dir)
  check_files <- list.files(report_dir, recursive = TRUE)

  expect_equal(sort(check_files),
               sort(c("bib/refs.bib", "bib/csl/apa.csl",
                      paste0(tolower(basename(report_dir)), ".Rmd"))))
})
