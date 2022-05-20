test_that("unknown template errors", {
  expect_error(find_resource("topicguide", "template2.docx"),
               "Couldn't find template")
  expect_error(find_resource("techreport", "template2.tex"),
               "Couldn't find template")
})

test_that("techreport-pdf renders", {
  testthat::skip_on_cran()

  # work in a temp directory
  dir <- create_local_rmd_dir(dir = fs::file_temp(pattern = "trpdf"))

  techreport_pdf_skeleton(dir)
  rmd_name <- tolower(basename(dir))
  suppressWarnings(bookdown::render_book(paste0(rmd_name, ".Rmd"), quiet = TRUE))
  expect_true(file.exists(paste0("_report/", stringr::str_to_title(rmd_name),
                                 ".pdf")))
})

test_that("topicguide-pdf renders", {
  testthat::skip_on_cran()

  # work in a temp directory
  dir <- create_local_rmd_dir(dir = fs::file_temp(pattern = "tpgpdf"))

  topicguide_pdf_skeleton(dir)
  rmd_name <- tolower(basename(dir))
  suppressWarnings(bookdown::render_book(paste0(rmd_name, ".Rmd"), quiet = TRUE))
  expect_true(file.exists(paste0("_report/", stringr::str_to_title(rmd_name),
                                 ".pdf")))
})

test_that("topicguide-docx renders", {
  testthat::skip_on_cran()

  # work in a temp directory
  dir <- create_local_rmd_dir(dir = fs::file_temp(pattern = "tpgdocx"),
                              copy = TRUE)

  topicguide_docx_skeleton(dir)
  rmd_name <- tolower(basename(dir))
  suppressWarnings(bookdown::render_book(paste0(rmd_name, ".Rmd"), quiet = TRUE,
                                         clean_envir = FALSE))
  expect_true(file.exists(paste0("_report/", stringr::str_to_title(rmd_name),
                                 ".docx")))
})

test_that("slides-html renders", {
  testthat::skip_on_cran()

  resources <- ratlas_file("rmarkdown", "templates", "atlas-presentation",
                           "skeleton")

  sub_dirs <- list.dirs(resources, recursive = TRUE, full.names = FALSE)
  sub_dirs <- sub_dirs[-which(sub_dirs == "")]
  files <- list.files(resources, recursive = TRUE, include.dirs = FALSE)

  # work in a temp directory
  dir <- create_local_rmd_dir(dir = fs::file_temp(pattern = "xgnhtml"))
  new_dir <- c(dir, file.path(dir, sub_dirs))
  fs::dir_create(new_dir)

  source <- file.path(resources, files)
  target <- file.path(dir, files)
  file.copy(source, target)
  suppressWarnings(rmarkdown::render("skeleton.Rmd", quiet = TRUE))
  expect_true(file.exists("skeleton.html"))

  render1 <- slides_html()
  render2 <- slides_html(nature = list(navigation = list(click = TRUE)))
  expect_false(identical(render1, render2))
})
