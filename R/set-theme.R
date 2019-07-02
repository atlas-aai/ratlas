#' Set default ggplot2 theme
#'
#' Sets the default color schemes, fonts, and theme for ggplot2 plots.
#' The default color scheme for continuous variables is the
#' \href{https://cran.r-project.org/web/packages/viridis/vignettes/intro-to-viridis.html}{viridis} color palette,
#' and the default color scheme for discrete variables is the
#' \href{http://jfly.iam.u-tokyo.ac.jp/color/}{Okabe Ito} palette.
#'
#' @param theme defaults to `theme_atlas`. Can be changed to `theme_atlas_ms`
#'
#' @examples
#' set_theme()
#' set_theme("theme_atlas_ms")
#'
#' @export

set_theme <- function(theme = "theme_atlas"){
  pos <- 1
  envir <- as.environment(pos)
  assign("scale_colour_discrete", function(..., values = palette_OkabeIto)
    scale_colour_manual(..., values = values), envir = envir)
  assign("scale_fill_discrete", function(..., values = palette_OkabeIto)
    scale_fill_manual(..., values = values), envir = envir)
  options(ggplot2.continuous.colour = "viridis")
  options(ggplot2.continuous.fill = "viridis")

  if (theme == "theme_atlas") {
    theme_set(theme_atlas())
  } else if (theme == "theme_atlas_ms") {
    theme_set(theme_atlas_ms())
    import_montserrat()
  }
}
