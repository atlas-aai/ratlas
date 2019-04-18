topicguide_skeleton <- function(path) {
  # copy 'topicguide_resources' folder to path
  resources <- ratlas_file("rstudio", "templates", "project",
                           "topicguide_resources")

  sub_dirs <- list.dirs(resources, recursive = TRUE, full.names = FALSE)
  sub_dirs <- sub_dirs[-which(sub_dirs == "")]
  files <- list.files(resources, recursive = TRUE, include.dirs = FALSE)

  # ensure directories exists
  new_path <- c(path, file.path(path, sub_dirs))
  fs::dir_create(new_path)

  source <- file.path(resources, files)
  target <- file.path(path, files)
  file.copy(source, target)

  # add book_filename to _bookdown.yml and to the base path name
  f <- file.path(path, "_bookdown.yml")
  x <- read_utf8(f)
  write_utf8(c(sprintf('book_filename: "%s"', basename(path)), x), f)

  TRUE
}
