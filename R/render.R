#' Create an R Markdown Word Document Topic Guide
#'
#' This is a function called in the output of the yaml of the Rmd file to
#' specify using the standard DLM topic guide word document formatting.
#'
#' @param type The type of report. Should be one of "topicguide", "techreport",
#'   or "measr". The following outputs are supported for each type:
#'   * topicguide: docx, rdocx, pdf
#'   * techreport: pdf, gitbook
#'   * measr: pdf
#' @param ... Arguments to be passed to relevant {bookdown} or {officedown}
#'   output functions:
#'   * [report_docx()] passes to [bookdown::word_document2()]
#'   * [report_rdocx()] passes to [officedown::rdocx_document()]
#'   * [report_pdf()] passes to [bookdown::pdf_document2()]
#'   * [report_gitbook()] passes to [bookdown::gitbook()]
#'
#' @return A modified output format with the appropriate template and default
#'   options defined.
#' @rdname output-formats
#' @export
#'
#' @examples
#' \dontrun{
#' output: ratlas::report_docx
#' }
report_docx <- function(type = "topicguide", ...) {
  type <- rlang::arg_match(type, c("topicguide"))

  template <- find_resource(paste0(type, "_docx"), "template.docx")
  base <- bookdown::word_document2(reference_docx = template, ...)

  base$knitr$opts_chunk$comment <- "#>"
  base$knitr$opts_chunk$message <- FALSE
  base$knitr$opts_chunk$warning <- FALSE
  base$knitr$opts_chunk$error <- FALSE
  base$knitr$opts_chunk$echo <- FALSE
  base$knitr$opts_chunk$cache <- FALSE
  base$knitr$opts_chunk$fig.width <- 7
  base$knitr$opts_chunk$fig.asp <- 0.618
  base$knitr$opts_chunk$fig.ext <- "png"
  base$knitr$opts_chunk$dev <- "ragg_png"
  base$knitr$opts_chunk$fig.retina <- 3
  base$knitr$opts_chunk$fig.path <- "figures/"
  base$knitr$opts_chunk$fig.pos <- "H"

  base
}

#' @rdname output-formats
#' @export
report_rdocx <- function(type = "topicguide", ...) {
  type <- rlang::arg_match(type, c("topicguide"))

  template <- find_resource(paste0(type, "_rdocx"), "template.docx")
  base <- officedown::rdocx_document(base_format = "bookdown::word_document2",
                                     reference_docx = template,
                                     number_sections = FALSE,
                                     page_size = list(
                                       width = 8.5, height = 11,
                                       orient = "portrait"
                                     ),
                                     page_margins = list(
                                       top = 1, right = 1, bottom = 1, left = .5
                                     ),
                                     plots = list(
                                       align = "left", topcaption = TRUE,
                                       caption = list(
                                         style = "Image Caption",
                                         pre = "Figure ",
                                         sep = ": "
                                       )
                                     ),
                                     tables = list(
                                       align = "center",
                                       caption = list(
                                         style = "Table Caption",
                                         pre = "Table ",
                                         sep = ": "
                                       )
                                     ),
                                     ...)

  base$knitr$opts_chunk$comment <- "#>"
  base$knitr$opts_chunk$message <- FALSE
  base$knitr$opts_chunk$warning <- FALSE
  base$knitr$opts_chunk$error <- FALSE
  base$knitr$opts_chunk$echo <- FALSE
  base$knitr$opts_chunk$cache <- FALSE
  base$knitr$opts_chunk$fig.width <- 6.4
  base$knitr$opts_chunk$fig.asp <- 0.618
  base$knitr$opts_chunk$fig.ext <- "png"
  base$knitr$opts_chunk$dev <- "ragg_png"
  base$knitr$opts_chunk$fig.retina <- 3
  base$knitr$opts_chunk$fig.path <- "figures/"
  base$knitr$opts_chunk$fig.pos <- "H"
  base$knitr$opts_chunk$ft.align <- "left"
  base$knitr$opts_chunk$ft.split <- FALSE

  base
}

#' @rdname output-formats
#' @export
report_pdf <- function(type = "topicguide", ...) {
  type <- rlang::arg_match(type, c("topicguide", "techreport", "measr"))

  template <- find_resource(paste0(type, "_pdf"), "template.tex")
  base <- bookdown::pdf_document2(
    template = topic_guide_template,
    latex_engine = "xelatex",
    citation_package = "biblatex",
    keep_tex = TRUE,
    number_sections = ifelse(type == "techreport", TRUE, FALSE),
    highlight = NULL, ...
  )

  base$knitr$opts_chunk$comment <- "#>"
  base$knitr$opts_chunk$message <- FALSE
  base$knitr$opts_chunk$warning <- FALSE
  base$knitr$opts_chunk$error <- FALSE
  base$knitr$opts_chunk$echo <- ifelse(type == "measr", TRUE, FALSE)
  base$knitr$opts_chunk$cache <- FALSE
  base$knitr$opts_chunk$fig.width <- 7
  base$knitr$opts_chunk$fig.asp <- 0.618
  base$knitr$opts_chunk$fig.ext <- "pdf"
  base$knitr$opts_chunk$fig.align <- "center"
  base$knitr$opts_chunk$fig.retina <- 3
  base$knitr$opts_chunk$fig.path <- "figures/"
  base$knitr$opts_chunk$fig.pos <- "H"
  base$knitr$opts_chunk$out.extra <- ""
  base$knitr$opts_chunk$out.width <- "100%"
  base$knitr$opts_chunk$fig.show <- "hold"

  base$knitr$knit_hooks$plot <- hook_tex_plot_rat

  base
}

#' @rdname output-formats
#' @export
report_gitbook <- function(type = "techreport", ...) {
  type <- rlang::arg_match(type, c("techreport"))

  base <-
    bookdown::gitbook(css = "assets/style.css",
                      split_by = "chapter+number",
                      split_bib = FALSE,
                      pandoc_args = "--lua-filter=assets/footnote.lua",
                      includes = list(in_header = "assets/style.html"),
                      config = list(
                        toc = list(
                          collapse = "section",
                          scroll_highlight = TRUE,
                          before = glue::glue("<li>",
                                              "<strong>",
                                              "<a href=\"./\">",
                                              "Dynamic Learning Maps",
                                              "</a>",
                                              "</strong>",
                                              "</li>")
                        ),
                        download = "pdf",
                        sharing = "no"
                      ), ...)

  # nolint start
  base$knitr$opts_chunk$comment <- "#>"
  base$knitr$opts_chunk$message <- FALSE
  base$knitr$opts_chunk$warning <- FALSE
  base$knitr$opts_chunk$error <- FALSE
  base$knitr$opts_chunk$echo <- FALSE
  base$knitr$opts_chunk$cache <- FALSE
  base$knitr$opts_chunk$fig.width <- 7
  base$knitr$opts_chunk$fig.asp <- 0.618
  base$knitr$opts_chunk$fig.ext <- "png"
  base$knitr$opts_chunk$dev <- "ragg_png"
  base$knitr$opts_chunk$fig.align <- "center"
  base$knitr$opts_chunk$fig.retina <- 3
  base$knitr$opts_chunk$fig.path <- "figures/"
  base$knitr$opts_chunk$fig.pos <- "H"
  base$knitr$opts_chunk$out.extra <- ""
  base$knitr$opts_chunk$out.width <- "100%"
  base$knitr$opts_chunk$fig.show <- "hold"
  base$knitr$opts_chunk$fig.topcaption <- TRUE
  # nolint end

  base$knitr$knit_hooks$plot <- hook_html_plot_rat

  base
}
