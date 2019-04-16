topicguide_skeleton <- function(path) {
  # ensure directory exists
  dir.create(path, recursive = TRUE, showWarnings = FALSE)

  # copy 'resources' folder to path
  resources <- ratlas_file("rstudio", "templates", "project", "topicguide",
                           "resources")

  files <- list.files(resources, recursive = TRUE, include.dirs = FALSE)

  source <- file.path(resources, files)
  target <- file.path(path, files)
  file.copy(source, target)

  # add book_filename to _bookdown.yml and to the base path name
  f <- file.path(path, "_bookdown.yml")
  x <- read_utf8(f)
  write_utf8(c(sprintf('book_filename: "%s"', basename(path)), x), f)

  TRUE
}
