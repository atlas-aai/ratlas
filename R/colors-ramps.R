#' Custom color ramps
#'
#' These color ramp functions create color scales that can be used for making
#' ggplot2 plots and gt tables.
#'
#' @param output Colors to pull from the color ramp. Numbers range from 0-1,
#'   which is a normalized sliding scale of the color ramp.
#' @param end The end color that the base color should fade into.
#' @param index For [ramp_okabeito()], the element of the palette to use.
#'
#' @details
#' [ramp_dlm()] is a pre-made color ramp based on the DLM blue.
#'
#' [ramp_okabeito()] is a pre-made color ramp based on the Okabe Ito palette.
#'
#' @return A character vector of hex color codes.
#' @name color_ramp

#' @rdname color_ramp
#' @export
#' @examples
#' ramp_dlm(seq(0.1, 1), by = 0.2)
ramp_dlm <- function(output, end = "#FFFFFF") {
  ramp <- wjake::make_color_pal(c(end, "#2B4098"), bias = 1)
  ramp(output)
}

#' @rdname color_ramp
#' @export
#' @examples
#' ramp_okabeito(seq(0.2, 1, length.out = 5), index = 2)
ramp_okabeito <- function(output, end = "#FFFFFF", index = 1) {
  ramp <- wjake::make_color_pal(
    colors = c("#FFFFFF", palette_okabeito[index]),
    bias = 1
  )
  ramp(output)
}
