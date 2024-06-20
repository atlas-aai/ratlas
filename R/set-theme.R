#' Set default ggplot2 theme
#'
#' Sets the default color schemes, fonts, and theme for ggplot2 plots. The
#' default color scheme for continuous variables is the
#' [viridis](https://CRAN.R-project.org/package=viridis)
#' color palette, and the default color scheme for discrete variables is the
#' [Okabe Ito](https://jfly.uni-koeln.de/color/) palette.
#'
#' @param font The base font family to be used in plots.
#' @param discrete Color palette for discrete colors. One of "okabeito"
#'   (default), "atlas", or "ggplot2".
#' @param continuous Color palette for continuous scales. One of "magma",
#'   "inferno", "plasma", "viridis" (default), or "cividis", or "ggplot2".
#' @param ... Additional arguments to pass to theme functions.
#'
#' @examplesIf interactive()
#' set_theme("Arial Narrow")
#' @return None. Called for side effects.
#' @export
set_theme <- function(font = "Arial Narrow",
                      discrete = c("okabeito", "atlas", "ggplot2"),
                      continuous = c("viridis", "magma", "inferno", "plasma",
                                     "cividis", "ggplot2"),
                      ...) {
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

  ggplot2::theme_set(theme_atlas(base_family = font, ...))
  update_geom_font_defaults(family = font)

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
