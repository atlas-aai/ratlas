#' Copy files to create a project skeleton for reports
#'
#' @param path The directory path where files should be saved.
#' @param type The type of report. Options vary by output type and are defined
#'   by the corresponding functions.
#'
#' @noRd
project_skeleton <- function(path, type) {
  type <- rlang::arg_match(
    type,
    c("techreport_html", "techreport_pdf", "topicguide_docx", "topicguide_pdf",
      "measr_pdf")
  )

  # copy 'techreport_html_resources' folder to path
  resources <- ratlas_file("rstudio", "templates", "project",
                           paste0(type, "_resources"))

  sub_dirs <- list.dirs(resources, recursive = TRUE, full.names = FALSE)
  sub_dirs <- sub_dirs[-which(sub_dirs == "")]
  files <- list.files(resources, recursive = TRUE, include.dirs = FALSE)

  # ensure directories exists
  new_path <- c(path, file.path(path, sub_dirs))
  fs::dir_create(new_path)

  source <- file.path(resources, files)
  target <- file.path(path, files)
  file.copy(source, target)

  # add book_filename to _bookdown.yml and default to the base path name
  if (file.exists(file.path(path, "_bookdown.yml"))) {
    f <- file.path(path, "_bookdown.yml")
    x <- xfun::read_utf8(f)
    xfun::write_utf8(c(sprintf('book_filename: "%s"',
                               stringr::str_to_title(basename(path))),
                       x,
                       "",
                       "rmd_files: [",
                       sprintf('  "%s.Rmd"', tolower(basename(path))),
                       "]"),
                     f)
  }

  # rename index.Rmd
  fs::file_move(file.path(path, "index.Rmd"),
                file.path(path, paste0(tolower(basename(path)), ".Rmd")))

  TRUE
}

bib_skeleton <- function(path) {
  bib <- ratlas_file("rstudio", "templates", "project", "_common-files", "bib")

  # identify sub-directories
  sub_dirs <- list.dirs(bib, recursive = TRUE, full.names = FALSE)
  sub_dirs <- sub_dirs[-which(sub_dirs == "")]
  files <- list.files(bib, recursive = TRUE, include.dirs = FALSE)

  # make sure directories exist
  new_path <- file.path(path, "bib", sub_dirs)
  fs::dir_create(new_path)

  # copy files
  source <- file.path(bib, files)
  target <- file.path(path, "bib", files)
  file.copy(source, target)

  TRUE
}

fig_skeleton <- function(path, logo = NULL, letterhead = NULL) {
  fig <- ratlas_file("rstudio", "templates", "project", "_common-files",
                     "figures", "pre-generated")

  # make sure directories exist
  new_path <- file.path(path, "figures", "pre-generated")
  fs::dir_create(new_path)

  if (!is.null(logo)) {
    file.copy(
      file.path(fig, logo),
      file.path(path, "figures", "pre-generated", logo)
    )
  }

  if (!is.null(letterhead)) {
    file.copy(
      file.path(fig, letterhead),
      file.path(path, "figures", "pregenerated", letterhead)
    )
  }

  TRUE
}

techreport_html_skeleton <- function(path) {
  project_skeleton(path, type = "techreport_html")
  bib_skeleton(path)
  fig_skeleton(path, logo = "DLM.png")
}

techreport_pdf_skeleton <- function(path) {
  project_skeleton(path, type = "techreport_pdf")
  bib_skeleton(path)
  fig_skeleton(path, logo = "DLM.png", letterhead = "atlas-letterhead.png")
}

topicguide_docx_skeleton <- function(path) {
  project_skeleton(path, type = "topicguide_docx")
  bib_skeleton(path)
}

topicguide_pdf_skeleton <- function(path) {
  project_skeleton(path, type = "topicguide_pdf")
  bib_skeleton(path)
}

measr_pdf_skeleton <- function(path) {
  project_skeleton(path, type = "measr_pdf")
  bib_skeleton(path)
  fig_skeleton(path, letterhead = "measr-letterhead.png")
}
