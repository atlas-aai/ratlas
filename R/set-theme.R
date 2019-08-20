#' Set default ggplot2 theme
#'
#' Sets the default color schemes, fonts, and theme for ggplot2 plots. The
#' default color scheme for continuous variables is the
#' [viridis](https://cran.r-project.org/web/packages/viridis/vignettes/intro-to-viridis.html)
#' color palette, and the default color scheme for discrete variables is the
#' [Okabe Ito](http://jfly.iam.u-tokyo.ac.jp/color/) palette.
#'
#' @param font One of "Arial Narrow" (default) or "Montserrat".
#'
#' @examples
#' set_theme("Arial Narrow")
#' set_theme("Montserrat")
#'
#' @export
set_theme <- function(font = "Arial Narrow"){
  pos <- 1
  envir <- as.environment(pos)
  assign("scale_colour_discrete", function(..., values = palette_OkabeIto)
    scale_colour_manual(..., values = values), envir = envir)
  assign("scale_fill_discrete", function(..., values = palette_OkabeIto)
    scale_fill_manual(..., values = values), envir = envir)
  options(ggplot2.continuous.colour = "viridis")
  options(ggplot2.continuous.fill = "viridis")

  if (font == "Arial Narrow") {
    theme_set(theme_atlas())
    update_geom_font_defaults()
  } else if (font == "Montserrat") {
    theme_set(theme_atlas_ms())
    update_geom_font_ms_defaults()
  }
}
