#' @format `palette_okabeito` is a character vector of 7 hex code colors.
#' @rdname scale_okabeito
#' @export
palette_okabeito <- c("#E69F00", "#56B4E9", "#009E73", "#F0E442", "#0072B2",
                      "#D55E00", "#CC79A7")


# ggplot2 scales ---------------------------------------------------------------
#' @rdname scale_okabeito
#' @export
scale_colour_okabeito <- function(aesthetics = "colour", ...) {
  scale_okabeito(aesthetics, ...)
}

#' @rdname scale_okabeito
#' @export
scale_color_okabeito <- scale_colour_okabeito

#' @rdname scale_okabeito
#' @export
scale_fill_okabeito <- function(aesthetics = "fill", ...) {
  scale_okabeito(aesthetics, ...)
}

#' Okabe-Ito color scale
#'
#' The Okabe-Ito color palette is designed to be friendly to colorblind and
#' colorweak readers. Additionally, this palette should be friendly to
#' grayscale printing. For details on the palette, see Okabe and Ito (2008).
#'
#' @inheritParams ggplot2::discrete_scale
#' @param use_black If `TRUE`, scale includes black, otherwise includes gray.
#' @param order Numeric vector listing the order in which the colors should be
#'   used. Default is 1:8.
#' @param darken Relative amount by which the scale should be darkened (for
#'   positive values) or lightened (for negative values).
#' @param alpha Alpha transparency level of the color. Default is no
#'   transparency.
#' @param ... Additional arguments passed to [ggplot2::discrete_scale].
#'
#' @return A color scale for use in plots created with [ggplot2::ggplot()].
#' @export
#'
#' @references Okabe M., & Ito, K. (2008). *Color universal design (CUD): How to
#'   make figures and presentations that are friendly to Colorblind people*.
#'   Jfly. \url{https://jfly.uni-koeln.de/color/}
#'
#' @examples
#' scales::show_col(palette_okabeito)
#'
#' ggplot(penguins, aes(flipper_len, bill_len, color = species)) +
#'   geom_point(na.rm = TRUE) +
#'   scale_color_okabeito()
#'
#' ggplot(penguins, aes(flipper_len, fill = species)) +
#'   geom_density(na.rm = TRUE, alpha = 0.7) +
#'   scale_fill_okabeito(order = c(1, 3, 5))
scale_okabeito <- function(aesthetics, use_black = FALSE, order = 1:8,
                           darken = 0, alpha = NA, ...) {
  if (use_black) {
    values <- c(palette_okabeito, "#000000")[order]
  }
  else {
    values <- c(palette_okabeito, "#999999")[order]
  }

  n <- length(values)
  darken <- rep_len(darken, n)
  alpha <- rep_len(alpha, n)

  di <- darken > 0
  if (sum(di) > 0) {
    values[di] <- colorspace::darken(values[di], amount = darken[di])
  }

  li <- darken < 0
  if (sum(li) > 0) {
    values[li] <- colorspace::lighten(values[li], amount = -1 * darken[li])
  }

  ai <- !is.na(alpha)
  if (sum(ai) > 0) {
    values[ai] <- scales::alpha(values[ai], alpha[ai])
  }

  pal <- scales::manual_pal(values, "colour")
  ggplot2::discrete_scale(aesthetics, palette = pal, ...)
}
