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
set_theme <- function(font = "Arial Narrow", discrete = "okabeito",
                      continuous = "viridis") {
  cont_option <- switch(continuous,
                        magma = "A",
                        inferno = "B",
                        plasma = "C",
                        viridis = "D",
                        cividis = "E")
  disc_option <- switch(discrete,
                        okabeito = palette_OkabeIto,
                        atlas = palette_atlas)

  if (font == "Arial Narrow") {
    ggplot2::theme_set(theme_atlas())
    update_geom_font_defaults()
  } else if (font == "Montserrat") {
    ggplot2::theme_set(theme_atlas_ms())
    update_geom_font_ms_defaults()
  }

  if (!is.null(disc_option)) {
    assign("scale_colour_discrete", function(..., values = disc_option)
      scale_colour_manual(..., values = values), pos = ".GlobalEnv")
    assign("scale_fill_discrete", function(..., values = disc_option)
      scale_fill_manual(..., values = values), pos = ".GlobalEnv")
  }
  if (!is.null(cont_option)) {
    assign("scale_fill_continuous", function(..., option = cont_option)
      scale_fill_continuous(..., option = option, type = "viridis"),
      pos = ".GlobalEnv")
  }
}
