#' Generate a section for the yaml input
#'
#' @param input a file containing markdown text
#' @param sep a separator for each line.
#'
#' @return a string
#'
#' @export
inc <- function(input, sep = "\n\n  "){
  paste(readLines(input), collapse = sep)
}


# Helper functions from bookdown and rticles -----------------------------------
find_file <- function(template, file) {
  template <- system.file("rmarkdown", "templates", template, file,
                          package = "ratlas")
  if (template == "") {
    stop("Couldn't find template file ", template, "/", file, call. = FALSE)
  }

  template
}

find_resource <- function(template, file) {
  find_file(template, file.path("resources", file))
}

ratlas_file <- function(...) {
  system.file(..., package = "ratlas", mustWork = TRUE)
}
