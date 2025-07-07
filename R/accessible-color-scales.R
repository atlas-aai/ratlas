#' Accessible color palettes
#'
#' Accessible color palettes are designed to be friendly to colorblind and
#' colorweak readers. Additionally, these palettes should be friendly to
#' grayscale printing.
#'
#' @format `palette_okabeito` is a character vector of 7 hex code colors.
#' @references Okabe M., & Ito, K. (2008). *Color universal design (CUD): How to
#'   make figures and presentations that are friendly to Colorblind people*.
#'   Jfly. \url{https://jfly.uni-koeln.de/color/}
#'
#' @name accessible-palettes
#' @export
#'
#' @examples
#' scales::show_col(palette_okabeito)
palette_okabeito <- c("#E69F00", "#56B4E9", "#009E73", "#F0E442", "#0072B2",
                      "#D55E00", "#CC79A7")

#' @format `palette_datawrapper` is a character vector of 7 hex code colors.
#' @references Muth, L. C. (2020, June 23). *What to consider when visualizing
#'   data for colorblind readers*. Datawrapper.
#'   \url{https://www.datawrapper.de/blog/colorblindness-part2}
#'
#' @name accessible-palettes
#' @export
#'
#' @examples
#' scales::show_col(palette_datawrapper)
palette_datawrapper <- c("#193CBC", "#1473AF", "#589ACF", "#89C3EF", "#EA594E",
                         "#E5B039", "#EDE65A")

# ggplot2 scales ---------------------------------------------------------------
#' @rdname scale_accessible
#' @export
scale_colour_accessible <- function(aesthetics = "colour", ...) {
  scale_accessible(aesthetics, ...)
}

#' @rdname scale_accessible
#' @export
scale_color_accessible <- scale_colour_accessible

#' @rdname scale_accessible
#' @export
scale_fill_accessible <- function(aesthetics = "fill", ...) {
  scale_accessible(aesthetics, ...)
}

#' Accessible color scales
#'
#' These functions provide {ggplot2} wrappers around the
#' [accessible color palettes][accessible-palettes] provided by {ratlas}.
#'
#' @inheritParams ggplot2::discrete_scale
#' @param option The color palette to use. One of "okabeito" or "datawrapper".
#' @param use_black If `TRUE`, scale includes black, otherwise includes gray.
#' @param order Numeric vector listing the order in which the colors should be
#'   used. Default is 1:8.
#' @param darken Relative amount by which the scale should be darkened (for
#'   positive values) or lightened (for negative values).
#' @param alpha Alpha transparency level of the color. Default is no
#'   transparency.
#' @param ... Additional arguments passed to [ggplot2::discrete_scale].
#'
#' @references Muth, L. C. (2020, June 23). *What to consider when visualizing
#'   data for colorblind readers*. Datawrapper.
#'   \url{https://www.datawrapper.de/blog/colorblindness-part2}
#' @references Okabe M., & Ito, K. (2008). *Color universal design (CUD): How to
#'   make figures and presentations that are friendly to Colorblind people*.
#'   Jfly. \url{https://jfly.uni-koeln.de/color/}
#'
#' @return A color scale for use in plots created with {ggplot2}.
#' @export
#'
#' @seealso [ggplot2::scale_colour_viridis_d()]
#' @examples
#' library(ggplot2)
#'
#' ggplot(iris, aes(Sepal.Length, Sepal.Width, color = Species)) +
#'   geom_point() +
#'   scale_color_accessible(type = "datawrapper")
#'
#' ggplot(iris, aes(Sepal.Length, fill = Species)) +
#'   geom_density(alpha = 0.7) +
#'   scale_fill_accessible(type = "okabeito", order = c(1, 3, 5))
scale_accessible <- function(aesthetics, option = c("okabeito", "datawrapper"),
                             use_black = FALSE, order = 1:8, darken = 0,
                             alpha = NA, ...) {
  option <- rlang::arg_match(option)
  palette <- switch(option,
                    okabeito = palette_okabeito,
                    datawrapper = palette_datawrapper)
  values <- if (use_black) {
    c(palette, "#000000")[order]
  } else {
    c(palette, "#999999")[order]
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
