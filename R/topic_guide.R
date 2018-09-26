#' Topic Guide Formatting Function
#'
#' This is a function called in output in the YAML of the driver Rmd file
#' to specify using the ATLAS/DLM topic guide template.
#' @param ... arguments to be passed to \code{rmarkdown::\link[rmarkdown]{pdf_document}}
#' @keywords cats
#' @export
#' @examples
#' \dontrun{
#'  output: ratlas::topic_guide
#' }

topic_guide <- function(...){
  base <- bookdown::word_document2(base_format = "style-reference1.docx", ...)

  # Mostly copied from knitr::render_sweave
  base$knitr$opts_chunk$comment <- "#>"
  base$knitr$opts_chunk$fig.align <- "center"
  base$knitr$opts_chunk$out.width <- "80%"
  base$knitr$opts_knit$root.dir <- getwd()
  base$knitr$opts_knit$echo <- FALSE
  base$knitr$opts_knit$warning <- FALSE
  base$knitr$opts_knit$message <- FALSE
  base$knitr$opts_knit$error <- FALSE
  base$knitr$opts_knit$cache <- FALSE
  base$knitr$opts_knit$fig.ext <- "png"
  base$knitr$opts_knit$fig.path <- "figure/"

  base
}
