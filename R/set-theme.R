#' Set default ggplot2 theme
#'
#' Sets the default color schemes, fonts, and theme for ggplot2 plots. The
#' default color scheme for continuous variables is the
#' [viridis](https://cran.r-project.org/web/packages/viridis/vignettes/intro-to-viridis.html)
#' color palette, and the default color scheme for discrete variables is the
#' [Okabe Ito](http://jfly.iam.u-tokyo.ac.jp/color/) palette.
#'
#' @param font One of "Arial Narrow" (default) or "Montserrat".
#' @param discrete Color palette for discrete colors. One of "okabeito"
#'   (default), "atlas", or "ggplot2".
#' @param continuous Color palette for continuous scales. One of "magma",
#'   "inferno", "plasma", "viridis" (default), or "cividis", or "ggplot2".
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

  pos <- 1
  envir <- as.environment(pos)
  if (!is.null(disc_option)) {
    assign("scale_colour_discrete", function(..., values = disc_option)
      ggplot2::scale_colour_manual(..., values = values), envir = envir)
    assign("scale_fill_discrete", function(..., values = disc_option)
      ggplot2::scale_fill_manual(..., values = values), envir = envir)
  } else {
    assign("scale_colour_discrete", ggplot2::scale_colour_discrete(),
           envir = envir)
    assign("scale_fill_discrete", ggplot2::scale_fill_discrete(),
           envir = envir)
  }
  if (!is.null(cont_option)) {
    assign("scale_fill_continuous", function(..., option = cont_option)
      ggplot2::scale_fill_continuous(..., option = option, type = "viridis"),
      envir = envir)
    assign("scale_colour_continuous", function(..., option = cont_option)
      ggplot2::scale_colour_continuous(..., option = option, type = "viridis"),
      envir = envir)
  } else {
    assign("scale_fill_continuous", ggplot2::scale_fill_continuous(),
           envir = envir)
    assign("scale_colour_continuous", ggplot2::scale_colour_continuous(),
           envir = envir)
  }
}
