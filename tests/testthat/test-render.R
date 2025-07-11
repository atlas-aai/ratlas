test_that("measr-pdf renders", {
  testthat::skip_on_cran()

  # work in a temp directory
  report_dir <- withr::local_tempdir(pattern = "msrpdf")
  withr::local_dir(report_dir)

  measr_pdf_skeleton(report_dir)
  rmd_name <- tolower(basename(report_dir))
  suppressWarnings(rmarkdown::render(paste0(rmd_name, ".Rmd"),
                                     output_dir = "_report", quiet = TRUE,
                                     envir = new.env()))
  reset_theme_settings()
  expect_true(file.exists(paste0("_report/", stringr::str_to_title(rmd_name),
                                 ".pdf")))
})

test_that("techreport-html renders", {
  testthat::skip_on_cran()

  # work in a temp directory
  report_dir <- withr::local_tempdir(pattern = "trhtml")
  withr::local_dir(report_dir)

  techreport_html_skeleton(report_dir)
  suppressWarnings(bookdown::render_book("index.Rmd", quiet = TRUE,
                                         envir = new.env()))
  reset_theme_settings()
  expect_true(file.exists(paste0("_report/",
                                 stringr::str_to_title("index.html"))))
})

test_that("techreport-pdf renders", {
  testthat::skip_on_cran()

  # work in a temp directory
  report_dir <- withr::local_tempdir(pattern = "trpdf")
  withr::local_dir(report_dir)

  techreport_pdf_skeleton(report_dir)
  suppressWarnings(bookdown::render_book("index.Rmd", quiet = TRUE,
                                         envir = new.env()))
  reset_theme_settings()
  expect_true(file.exists(
    paste0("_report/", stringr::str_to_title(basename(report_dir)), ".pdf")
  ))
})

test_that("topicguide-docx renders", {
  testthat::skip_on_cran()

  # work in a temp directory
  report_dir <- withr::local_tempdir(pattern = "tpgdocx")
  withr::local_dir(report_dir)

  topicguide_docx_skeleton(report_dir)
  suppressWarnings(bookdown::render_book("index.Rmd", quiet = TRUE,
                                         envir = new.env()))
  reset_theme_settings()
  expect_true(file.exists(
    paste0("_report/", stringr::str_to_title(basename(report_dir)), ".docx")
  ))
})

test_that("topicguide-pdf renders", {
  testthat::skip_on_cran()

  # work in a temp directory
  report_dir <- withr::local_tempdir(pattern = "tpgpdf")
  withr::local_dir(report_dir)

  topicguide_pdf_skeleton(report_dir)
  suppressWarnings(bookdown::render_book("index.Rmd", quiet = TRUE,
                                         envir = new.env()))
  reset_theme_settings()
  expect_true(file.exists(
    paste0("_report/", stringr::str_to_title(basename(report_dir)), ".pdf")
  ))
})

test_that("topicguide-rdocx renders", {
  testthat::skip_on_cran()

  # work in a temp directory
  report_dir <- withr::local_tempdir(pattern = "tpgrdocx")
  withr::local_dir(report_dir)

  topicguide_rdocx_skeleton(report_dir)
  rmd_name <- tolower(basename(report_dir))
  suppressWarnings(rmarkdown::render(paste0(rmd_name, ".Rmd"),
                                     output_dir = "_report", quiet = TRUE,
                                     envir = new.env()))
  reset_theme_settings()
  expect_true(file.exists(
    paste0("_report/", stringr::str_to_title(basename(report_dir)), ".docx")
  ))
})
