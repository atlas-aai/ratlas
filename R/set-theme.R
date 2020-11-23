#' Set default ggplot2 theme
#'
#' Sets the default color schemes, fonts, and theme for ggplot2 plots. The
#' default color scheme for continuous variables is the
#' [viridis](https://cran.r-project.org/web/packages/viridis/index.html)
#' color palette, and the default color scheme for discrete variables is the
#' [Okabe Ito](http://jfly.iam.u-tokyo.ac.jp/color/) palette.
#'
#' @param font One of "Arial Narrow" (default) or "Montserrat".
#' @param discrete Color palette for discrete colors. One of "okabeito"
#'   (default), "atlas", or "ggplot2".
#' @param continuous Color palette for continuous scales. One of "magma",
#'   "inferno", "plasma", "viridis" (default), or "cividis", or "ggplot2".
#' @param ... Additional arguments to pass to theme functions.
#'
#' @examples
#' set_theme("Arial Narrow")
#' set_theme("Montserrat")
#'
#' @export
set_theme <- function(font = c("Arial Narrow", "Montserrat", "default"),
                      discrete = c("okabeito", "atlas", "ggplot2"),
                      continuous = c("viridis", "magma", "inferno", "plasma",
                                     "cividis", "ggplot2"),
                      ...) {
  font <- match.arg(font)
  discrete <- match.arg(discrete)
  continuous <- match.arg(continuous)
  cont_option <- switch(continuous,
                        magma = "A",
                        inferno = "B",
                        plasma = "C",
                        viridis = "D",
                        cividis = "E")
  disc_option <- switch(discrete,
                        okabeito = palette_okabeito,
                        atlas = palette_atlas)

  if (font == "Arial Narrow") {
    ggplot2::theme_set(theme_atlas(...))
    update_geom_font_defaults()
  } else if (font == "Montserrat") {
    ggplot2::theme_set(theme_atlas_ms(...))
    update_geom_font_ms_defaults()
  } else if (font == "default") {
    ggplot2::theme_set(ggplot2::theme_grey())
    ggplot2::update_geom_defaults("text", list(family = "", fontface = "plain",
                                               size = 3.88, color = "black"))
    ggplot2::update_geom_defaults("label", list(family = "", fontface = "plain",
                                                size = 3.88, color = "black"))
  }

  if (!is.null(disc_option)) {
    disc_fill <- switch(discrete,
                       okabeito = scale_fill_okabeito,
                       atlas = scale_fill_atlas)
    disc_colr <- switch(discrete,
                        okabeito = scale_colour_okabeito,
                        atlas = scale_colour_atlas)
    options(ggplot2.discrete.fill = disc_fill)
    options(ggplot2.discrete.colour = disc_colr)
  } else {
    options(ggplot2.discrete.fill = NULL)
    options(ggplot2.discrete.colour = NULL)
  }
  if (!is.null(cont_option)) {
    cont_fill <- function(..., option = cont_option) {
      ggplot2::scale_fill_continuous(..., option = option, type = "viridis")
    }
    cont_colr <- function(..., option = cont_option) {
      ggplot2::scale_colour_continuous(..., option = option, type = "viridis")
    }
    options(ggplot2.continuous.fill = cont_fill)
    options(ggplot2.continuous.colour = cont_colr)
  } else {
    options(ggplot2.continuous.fill = NULL)
    options(ggplot2.continuous.colour = NULL)
  }
}
