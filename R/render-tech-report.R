#' Create an R Markdown PDF Document Tech Report
#'
#' This is a function called in the output of the YAML of the Rmd file to
#' specify using the standard DLM tech report pdf document formatting.
#'
#' @param ... Arguments to be passed to `[bookdown::pdf_document2]`
#'
#' @return A modified `pdf_document2` with the standard tech report formatting.
#' @export
#'
#' @examples
#' \dontrun{
#'   output: ratlas::techreport_pdf
#' }
techreport_pdf <- function(...) {
  template <- find_resource("techreport", "template.pdf")
  base <- bookdown::pdf_document2(template = tech-report-template, ...)
  
  base$knitr$opts_chunk$comment <- "#>"
  base$knitr$opts_chunk$message <- FALSE
  base$knitr$opts_chunk$warning <- FALSE
  base$knitr$opts_chunk$error <- FALSE
  base$knitr$opts_chunk$echo <- FALSE
  base$knitr$opts_chunk$cache <- FALSE
  base$knitr$opts_chunk$fig.ext <- "png"
  base$knitr$opts_chunk$fig.retina <- 3
  base$knitr$opts_chunk$fig.path <- "figures/"
  
  base
}
