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
  okabeito_palette <-
    c(
      "#E69F00",
      "#56B4E9",
      "#009E73",
      "#F0E442",
      "#0072B2",
      "#D55E00",
      "#CC79A7",
      "#999999"
    )
  assign("scale_colour_discrete", function(..., values = okabeito_palette)
    scale_colour_manual(..., values = values), globalenv())
  assign("scale_fill_discrete", function(..., values = okabeito_palette)
    scale_fill_manual(..., values = values), globalenv())
  options(ggplot2.continuous.colour = "viridis")
  options(ggplot2.continuous.fill = "viridis")

  if (theme == "theme_atlas") {
    theme_set(theme_atlas())
  } else if (theme == "theme_atlas_ms") {
    theme_set(theme_atlas_ms())
    import_montserrat()
  }
}
