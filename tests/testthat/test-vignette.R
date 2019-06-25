context("vignette renders")

test_that("vignette renders", {
  testthat::skip_on_cran()

  # work in a temp directory
  dir <- tempfile()
  dir.create(dir)
  oldwd <- setwd(dir)
  on.exit(setwd(oldwd), add = TRUE)

  resources <- ratlas_file("vignettes")
  
  files <- list.files(resources, recursive = TRUE, include.dirs = FALSE)
  
  # ensure directories exists
  new_path <- c(dir, file.path(dir))
  fs::dir_create(new_path)
  
  source <- file.path(resources, files)
  target <- file.path(dir, files)
  file.copy(source, target)
  
  rmarkdown::render("report-writing-vignette.Rmd")
  expect_true(file.exists("report-writing-vignette.html"))
})
