#' @rdname scale_atlas
#' @export
#' @usage NULL
scale_colour_atlas <- function(aesthetics = "colour", ...) {
  scale_atlas(aesthetics, ...)
}

#' @rdname scale_atlas
#' @export
#' @usage NULL
scale_color_atlas <- scale_colour_atlas

#' @rdname scale_atlas
#' @export
#' @usage NULL
scale_fill_atlas <- function(aesthetics = "fill", ...) {
  scale_atlas(aesthetics, ...)
}

#' ATLAS color scale
#'
#' This is a qualitative scale using the offical ATLAS brand colors. See
#' [palette_atlas] for details.
#'
#' @param use_black If `TRUE`, scale includes black, otherwise includes gray.
#' @param order Numeric vector listing the order in which the colors should be
#'   used. Default is 1:8.
#' @param darken Relative amount by which the scale should be darkened (for
#'   positive values) or lightened (for negatice values).
#' @param alpha Alpha transparency level of the color. Default is no
#'   transparency.
#' @param ... common discrete scale parameters: `name`, `breaks`, `labels`,
#'   `na.value`, `limits`, `guide`, and `aesthetics`. See [discrete_scale] for
#'   more details.
#' @examples
#' library(ggplot2)
#' ggplot(iris, aes(Sepal.Length, Sepal.Width, color = Species)) +
#'   geom_point() + scale_color_atlas()
#' ggplot(iris, aes(Sepal.Length, fill = Species)) +
#'   geom_density(alpha = 0.7) + scale_fill_atlas(order = c(1, 3, 5))
#' @export
#' @usage NULL
scale_atlas <- function(aesthetics, use_black = FALSE, order = 1:6, darken = 0,
                        alpha = NA, ...) {
  if (use_black) {
    values <- palette_atlas_black[order]
  }
  else {
    values <- palette_atlas[order]
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

  pal <- function(n) {
    if (n > length(values)) {
      warning("Insufficient values in manual scale. ", n, " needed but only ",
              length(values), " provided.", call. = FALSE)
    }
    values
  }
  ggplot2::discrete_scale(aesthetics, "manual", pal, ...)
}
