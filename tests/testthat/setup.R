local_theme <- function(font = "sans", discrete = "okabeito",
                        continuous = "mako", ..., env = parent.frame()) {
  og <- set_theme_ratlas(font = font, discrete = discrete,
                         continuous = continuous, ...)
  withr::defer(ggplot2::reset_theme_settings(), env)
}
