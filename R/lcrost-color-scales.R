#' @rdname scale_lcrost
#' @export
#' @usage NULL
scale_colour_lcrost <- function(aesthetics = "colour", ...) {
  scale_lcrost(aesthetics, ...)
}

#' @rdname scale_lcrost
#' @export
#' @usage NULL
scale_color_lcrost <- scale_colour_lcrost

#' @rdname scale_lcrost
#' @export
#' @usage NULL
scale_fill_lcrost <- function(aesthetics = "fill", ...) {
  scale_lcrost(aesthetics, ...)
}

#' Lisa Charlotte Rost color scale
#'
#' This is a color-blind friendly, qualitative scale with eight different
#' colors. See [palette_lcrost] for details. The palette was first described in
#' [this blog post](https://www.datawrapper.de/blog/colorblindness-part2).
#'
#' @param use_black If `TRUE`, scale includes black, otherwise includes gray.
#' @param order Numeric vector listing the order in which the colors should be
#'   used. Default is 1:8.
#' @param darken Relative amount by which the scale should be darkened (for
#'   positive values) or lightened (for negative values).
#' @param alpha Alpha transparency level of the color. Default is no
#'   transparency.
#' @param ... common discrete scale parameters: `name`, `breaks`, `labels`,
#'   `na.value`, `limits`, `guide`, and `aesthetics`. See [ggplot2::discrete_scale] for
#'   more details.
#' @return A color scale for use in plots created with [ggplot2::ggplot()].
#' @examples
#' library(ggplot2)
#' ggplot(iris, aes(Sepal.Length, Sepal.Width, color = Species)) +
#'   geom_point() + scale_color_lcrost()
#' ggplot(iris, aes(Sepal.Length, fill = Species)) +
#'   geom_density(alpha = 0.7) + scale_fill_lcrost(order = c(1, 3, 5))
#' @export
#' @usage NULL
scale_lcrost <- function(aesthetics, use_black = FALSE, order = 1:8,
                         darken = 0, alpha = NA, ...) {
  if (use_black) {
    values <- palette_lcrost_black[order]
  }
  else {
    values <- palette_lcrost[order]
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
