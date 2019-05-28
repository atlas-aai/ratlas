.onAttach <- function(pkgname, libname) {
  okabeito_palette <-
    c(
      "#E69F00",
      "#56B4E9",
      "#009E73",
      "#F0E442",
      "#0072B2",
      "#D55E00",
      "#CC79A7",
      "#999999"
    )

  assign("scale_colour_discrete", function(..., values = okabeito_palette)
    scale_colour_manual(..., values = values), globalenv())
  assign("scale_fill_discrete", function(..., values = okabeito_palette)
    scale_fill_manual(..., values = values), globalenv())
  options(ggplot2.continuous.colour = "viridis")
  options(ggplot2.continuous.fill = "viridis")

  # taken from hrbrthemes/R/zzz.R
  if (.Platform$OS.type == "windows")  {
    # nocov start
    if (interactive())
      packageStartupMessage("Registering Windows fonts with R")
    extrafont::loadfonts("win", quiet = TRUE)
  }

  if (getOption("hrbrthemes.loadfonts", default = FALSE)) {
    if (interactive())
      packageStartupMessage("Registering PDF & PostScript fonts with R")
    extrafont::loadfonts("pdf", quiet = TRUE)
    extrafont::loadfonts("postscript", quiet = TRUE)
  }

  fnt <- extrafont::fonttable()
  if (!any(grepl("Arial[ ]Narrow|Roboto[ ]Condensed", fnt$FamilyName))) {
    packageStartupMessage("NOTE: Either Arial Narrow or Roboto Condensed fonts
                          are required to use these themes.")
    packageStartupMessage("      Please use
                          hrbrthemes::import_roboto_condensed()
                          to install Roboto Condensed and")
    packageStartupMessage("      if Arial Narrow is not on your system,
                          please see https://bit.ly/arialnarrow")
  } # nocov end
}
