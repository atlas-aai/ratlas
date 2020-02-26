context("rmarkdown renderers")

test_that("unknown template errors", {
  expect_error(find_resource("topicguide", "template2.docx"),
               "Couldn't find template")
  expect_error(find_resource("techreport", "template2.tex"),
               "Couldn't find template")
})

test_that("topicguide-docx renders", {
  testthat::skip_on_cran()
  testthat::skip_on_travis()
  testthat::skip_on_appveyor()

  # work in a temp directory
  dir <- tempfile()
  dir.create(dir)
  oldwd <- setwd(dir)
  on.exit(setwd(oldwd), add = TRUE)

  topicguide_docx_skeleton(dir)
  rmarkdown::render("index.Rmd", quiet = TRUE)
  expect_true(file.exists("index.docx"))
})

test_that("topicguide-pdf renders", {
  testthat::skip_on_cran()
  testthat::skip_on_travis()
  testthat::skip_on_appveyor()

  # work in a temp directory
  dir <- tempfile()
  dir.create(dir)
  oldwd <- setwd(dir)
  on.exit(setwd(oldwd), add = TRUE)

  topicguide_pdf_skeleton(dir)
  rmarkdown::render("index.Rmd")
  expect_true(file.exists("index.pdf"))
})

test_that("techreport-pdf renders", {
  testthat::skip_on_cran()
  testthat::skip_on_travis()
  testthat::skip_on_appveyor()

  # work in a temp directory
  dir <- tempfile()
  dir.create(dir)
  oldwd <- setwd(dir)
  on.exit(setwd(oldwd), add = TRUE)

  techreport_skeleton(dir)
  suppressWarnings(rmarkdown::render("index.Rmd", quiet = TRUE))
  expect_true(file.exists("index.pdf"))
})

test_that("slides-html renders", {
  testthat::skip_on_cran()
  testthat::skip_on_travis()
  testthat::skip_on_appveyor()

  resources <- here::here("inst", "rmarkdown", "templates",
                          "atlas-presentation", "skeleton")

  sub_dirs <- list.dirs(resources, recursive = TRUE, full.names = FALSE)
  sub_dirs <- sub_dirs[-which(sub_dirs == "")]
  files <- list.files(resources, recursive = TRUE, include.dirs = FALSE)

  # work in a temp directory
  dir <- tempdir()
  new_dir <- c(dir, file.path(dir, sub_dirs))
  fs::dir_create(new_dir)
  oldwd <- setwd(dir)
  on.exit(setwd(oldwd), add = TRUE)

  source <- file.path(resources, files)
  target <- file.path(dir, files)
  file.copy(source, target)
  suppressWarnings(rmarkdown::render("skeleton.Rmd", quiet = TRUE))
  expect_true(file.exists("skeleton.html"))
})
