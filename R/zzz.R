.onLoad <- function(libname, pkgname) {
  auto_format <- getOption("ratlas.auto_format", default = TRUE)
  if (auto_format) auto_set_format()
}

.onAttach <- function(libname, pkgname) {
  if (getOption("ratlas.loadfonts", default = FALSE)) {
    font_dir <- getOption("ratlas.font_dir", default = "~/fonts")
    suppressMessages(systemfonts::require_font(
      "Roboto Condensed",
      dir = font_dir
    ))
  }
}
