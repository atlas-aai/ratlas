create_local_rmd_dir <- function(dir = fs::file_temp(pattern = "testproj"),
                                 env = parent.frame(),
                                 rstudio = FALSE,
                                 copy = FALSE) {
  if (fs::dir_exists(dir)) {
    usethis::ui_stop({
      "Target {usethis::ui_code('dir')} {usethis::ui_path(dir)} already exists."
    })
  }

  old_project <- proj_get_()
  old_wd <- getwd()

  withr::defer({
    usethis::ui_done("Deleting temporary project: {usethis::ui_path(dir)}")
    fs::dir_delete(dir)
  },
  envir = env
  )
  usethis::ui_silence(
    usethis::create_project(dir, rstudio = rstudio, open = FALSE)
  )

  withr::defer(usethis::proj_set(old_project, force = TRUE), envir = env)
  usethis::proj_set(dir)

  withr::defer({
    usethis::ui_done(glue::glue("Restoring original working directory: ",
                                "{usethis::ui_path(old_wd)}"))
    setwd(old_wd)
  },
  envir = env
  )
  setwd(usethis::proj_get())

  invisible(usethis::proj_get())
}

local_theme <- function(font, discrete, continuous, ..., env = parent.frame()) {
  # set defaults
  options(ggplot2.continuous.colour = NULL,
          ggplot2.continuous.fill = NULL,
          ggplot2.discrete.colour = NULL,
          ggplot2.discrete.fill = NULL)

  # save defaults
  op <- options(ggplot2.continuous.colour = NULL,
                ggplot2.continuous.fill = NULL,
                ggplot2.discrete.colour = NULL,
                ggplot2.discrete.fill = NULL)
  set_theme(font = font, discrete = discrete, continuous = continuous, ...)
  withr::defer(options(op), envir = env)
}

local_knitr_output <- function(output = NULL, env = parent.frame()) {
  op <- options(ratlas.auto_format = FALSE,
                kableExtra.auto_format = FALSE,
                knitr.table.format = output)
  withr::defer(options(op), envir = env)
}
