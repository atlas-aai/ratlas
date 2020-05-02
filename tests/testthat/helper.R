create_local_rmd_dir <- function(dir = fs::file_temp(), env = parent.frame()) {
  old_project <- usethis::proj_get()

  withr::defer({
    usethis::proj_set(old_project, force = TRUE)
    setwd(old_project)
    fs::dir_delete(dir)
    set_theme(font = "default", continuous = NULL, discrete = NULL)
  }, envir = env)

  usethis::create_project(dir, open = FALSE)
  setwd(dir)
  usethis::proj_set(dir)
  invisible(dir)
}
