#' Save a ggplot2 graphic
#'
#' This is a wrapper around [ggplot2::ggsave()] with some ATLAS-specific
#' defaults. The aspect ratio is fixed to 0.618 ([the golden
#' ratio](https://en.wikipedia.org/wiki/Golden_ratio)) unless the height is
#' manually defined. Plots are automatically spell checked and warnings are
#' returned if there are possible mistakes. Finally, plots saved as a pdf have
#' the fonts embedded using [extrafont::embed_fonts()].
#'
#' @inheritParams ggplot2::ggsave
#' @param width Plot size in `units` ("in", "cm", or "mm").
#' @param height Plot size in `units` ("in", "cm", or "mm"). If not supplied,
#'   uses `0.618 * width` when `dir = "h"` and `1.618 * width` when `dir = "v"`.
#' @param dir Orientation of the plot. One of `h` (default) for horizontal or
#'   `v` for vertical.
#' @param embed_fonts Logical. Use Ghostscript to embed fonts in a PDF graphic?
#' @param ... Additional arguments passed to [ggplot2::ggsave()]
#'
#' @export
ggsave2 <- function(plot = ggplot2::last_plot(), filename, device = NULL,
                    path = NULL, width = 8, height = NULL, units = "in",
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
  # nocov start
  if ((grepl("\\.pdf", filename) || (!is.null(device) && device == "pdf")) &
      embed_fonts) {
    if (!is.null(path)) {
      filename <- file.path(path, filename)
    }
    extrafont::embed_fonts(filename)
  }
  # nocov end

  # return plot invisibly
  invisible(plot)
}
