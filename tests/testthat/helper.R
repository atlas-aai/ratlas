create_local_rmd_dir <- function(dir = fs::file_temp(pattern = "testproj"),
                                 env = parent.frame()) {
  if (fs::dir_exists(dir)) {
    usethis::ui_stop({
      "Target {usethis::ui_code('dir')} {usethis::ui_path(dir)} already exists."
    })
  }

  old_project <- proj_get_()
  old_dir <- getwd()
  withr::defer({
    usethis::ui_silence({
      usethis::proj_set(old_project, force = TRUE)
    })
    setwd(old_project)
    fs::dir_delete(dir)
    set_theme(font = "default", continuous = "ggplot2", discrete = "ggplot2")
  }, envir = env)

  usethis::ui_silence({
    usethis::create_project(dir, rstudio = FALSE, open = FALSE)
    usethis::proj_set(dir)
  })
  setwd(dir)
  invisible(dir)
}

local_theme <- function(font, discrete, continuous, ..., env = parent.frame()) {
  withr::defer({
    set_theme(font = "default", continuous = "ggplot2", discrete = "ggplot2")
  }, envir = env)

  set_theme(font = font, discrete = discrete, continuous = continuous, ...)
}

local_knitr_output <- function(output = NULL, env = parent.frame()) {
  op <- options(ratlas.auto_format = FALSE,
                kableExtra.auto_format = FALSE,
                knitr.table.format = output)
  withr::defer(options(op), envir = env)
}
