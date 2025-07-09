#' Save a ggplot2 graphic
#'
#' This is a wrapper around [ggplot2::ggsave()] with some ATLAS-specific
#' defaults. The aspect ratio is fixed to 0.618 ([the golden
#' ratio](https://en.wikipedia.org/wiki/Golden_ratio)) unless the height is
#' manually defined.
#'
#' @inheritParams ggplot2::ggsave
#' @param width Plot size in `units` ("in", "cm", or "mm").
#' @param height Plot size in `units` expressed by the `unit` argument. If
#'   `NULL` (the default), the height is set to `0.618 * width` when `dir = "h"`
#'   and `1.618 * width` when `dir = "v"`.
#' @param dir Orientation of the plot. One of `h` (default) for horizontal or
#'   `v` for vertical.
#' @param embed_fonts Logical. Use Ghostscript to embed fonts in a PDF graphic?
#' @param ... Additional arguments passed to [ggplot2::ggsave()]
#'
#' @return None. Called for side effects.
#' @export
#'
#' @examples
#' \donttest{
#' library(ggplot2)
#' p <- ggplot(mtcars, aes(mpg, wt)) +
#'  geom_point()
#'
#' ggsave2(p, "/mtcars.pdf", path = tempdir())
#' ggsave2(p, "/mtcars.png", path = tempdir())
#' }
ggsave2 <- function(plot = ggplot2::last_plot(), filename, device = NULL,
                    path = NULL, width = 7, height = NULL, units = "in",
                    dir = c("h", "v"), dpi = "retina", embed_fonts = FALSE,
                    ...) {
  dir <- match.arg(dir)

  # Calculate aspect ratio if not fixed
  if (is.null(height)) {
    asp <- ifelse(dir == "h", 0.618, 1.618)
    height <- width * asp
  }

  # Save plot
  ggplot2::ggsave(filename = filename, plot = plot, device = device,
                  path = path, width = width, height = height, units = units,
                  dpi = dpi, ...)

  # Embed fonts if pdf
  if ((grepl("\\.pdf", filename) || (!is.null(device) && device == "pdf")) &
      embed_fonts) {
    if (!is.null(path)) {
      filename <- file.path(path, filename)
    }
    extrafont::embed_fonts(filename)
  }

  # return plot invisibly
  invisible(plot)
}
