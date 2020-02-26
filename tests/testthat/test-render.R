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

  topicguide_skeleton(dir)
  rmarkdown::render("index.Rmd")
  expect_true(file.exists("index.docx"))
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
  suppressWarnings(rmarkdown::render("index.Rmd"))
  expect_true(file.exists("index.pdf"))
})

test_that("slides-html renders", {
  testthat::skip_on_cran()
  testthat::skip_on_travis()
  testthat::skip_on_appveyor()

  # work in a temp directory
  dir <- tempdir()
  dir.create(dir)
  oldwd <- setwd(dir)
  on.exit(setwd(oldwd), add = TRUE)

  fs::dir_copy(file.path(oldwd, "inst", "rmarkdown", "templates",
                          "atlas-presentation", "skeleton"),
               new_path = dir)
  fs::dir_copy(file.path(oldwd, "inst", "rmarkdown", "templates",
                         "atlas-presentation", "skeleton", "assets"),
               new_path = dir)
  suppressWarnings(rmarkdown::render("index.Rmd"))
  expect_true(file.exists("index.pdf"))
})
