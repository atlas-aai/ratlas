.onAttach <- function(pkgname, libname) {
  okabeito_palette <- c("#E69F00", "#56B4E9", "#009E73", "#F0E442", "#0072B2", "#D55E00", "#CC79A7", "#999999")

  assign("scale_colour_discrete", function(..., values = okabeito_palette) scale_colour_manual(..., values = values), globalenv())
  assign("scale_fill_discrete", function(..., values = okabeito_palette) scale_fill_manual(..., values = values), globalenv())
  options(ggplot2.continuous.colour="viridis")
  options(ggplot2.continuous.fill="viridis")
}
