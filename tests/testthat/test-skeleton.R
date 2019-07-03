context("project-skeletons")

test_that("copying topicguide docx files works", {
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

test_that("copying techreport pdf files works", {
  testthat::skip_on_cran()

  print("Check ratlas_file")
  resources <- ratlas_file("rstudio", "templates", "project",
                           "techreport_resources")
  print(resources)

  files <- list.files(resources, recursive = TRUE, include.dirs = FALSE)
  print(files)

  # work in a temp directory
  dir <- tempfile()
  dir.create(dir)
  oldwd <- setwd(dir)
  on.exit(setwd(oldwd), add = TRUE)

  techreport_skeleton(dir)
  check_files <- list.files(dir, recursive = TRUE)
  print(check_files)

  expect_equal(sort(check_files),
               sort(c("bib/refs.bib", "csl/apa.csl", "index.Rmd",
                      "figures/pre-generated/atlas.png",
                      "figures/pre-generated/dlm.png")))
})
