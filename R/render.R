#' Create an R Markdown Word Document Topic Guide
#'
#' This is a function called in the output of the yaml of the Rmd file to
#' specify using the standard DLM topic guide word document formatting.
#'
#' @param ... Arguments to be passed to `[bookdown::word_document2]`
#'
#' @return A modified `word_document2` with the standard topic guide formatting.
#' @export
#'
#' @examples
#' \dontrun{
#'   output: ratlas::topicguide_docx
#' }
topicguide_docx <- function(...) {
  template <- find_resource("topicguide_docx", "template.docx")
  base <- bookdown::word_document2(reference_docx = template, ...)

  # nolint start
  base$knitr$opts_chunk$comment <- "#>"
  base$knitr$opts_chunk$message <- FALSE
  base$knitr$opts_chunk$warning <- FALSE
  base$knitr$opts_chunk$error <- FALSE
  base$knitr$opts_chunk$echo <- FALSE
  base$knitr$opts_chunk$cache <- FALSE
  base$knitr$opts_chunk$fig.width <- 8
  base$knitr$opts_chunk$fig.asp <- 0.618
  base$knitr$opts_chunk$fig.ext <- "png"
  base$knitr$opts_chunk$fig.retina <- 3
  base$knitr$opts_chunk$fig.path <- "figures/"
  base$knitr$opts_chunk$fig.pos <- "H"
  # nolint end

  base
}


#' Create an R Markdown PDF Topic Guide
#'
#' This is a function called in the output of the yaml of the Rmd file to
#' specify using the standard DLM topic guide document formatting.
#'
#' @param ... Arguments to be passed to `[bookdown::pdf_document2]`
#'
#' @return A modified `pdf_document2` with the standard tech report formatting.
#' @export
#'
#' @examples
#' \dontrun{
#'   output: ratlas::topicguide_pdf
#' }
topicguide_pdf <- function(...) {
  topic_guide_template <- find_resource("topicguide_pdf", "template.tex")
  base <- bookdown::pdf_document2(template = topic_guide_template,
                                  latex_engine = "xelatex",
                                  citation_package = "biblatex",
                                  keep_tex = TRUE, number_sections = FALSE, ...)

  # nolint start
  base$knitr$opts_chunk$comment <- "#>"
  base$knitr$opts_chunk$message <- FALSE
  base$knitr$opts_chunk$warning <- FALSE
  base$knitr$opts_chunk$error <- FALSE
  base$knitr$opts_chunk$echo <- FALSE
  base$knitr$opts_chunk$cache <- FALSE
  base$knitr$opts_chunk$fig.width <- 8
  base$knitr$opts_chunk$fig.asp <- 0.618
  base$knitr$opts_chunk$fig.ext <- "pdf"
  base$knitr$opts_chunk$fig.align <- "center"
  base$knitr$opts_chunk$fig.retina <- 3
  base$knitr$opts_chunk$fig.path <- "figures/"
  base$knitr$opts_chunk$fig.pos <- "H"
  base$knitr$opts_chunk$out.extra <- ""
  base$knitr$opts_chunk$out.width <- "100%"
  base$knitr$opts_chunk$fig.show <- "hold"
  # nolint end

  base$knitr$knit_hooks$plot <- hook_tex_plot_rat

  base
}


#' Create an R Markdown PDF Document Tech Report
#'
#' This is a function called in the output of the yaml of the Rmd file to
#' specify using the standard DLM tech report pdf document formatting.
#'
#' @param apa6 Should the old
#' @param ... Arguments to be passed to `[bookdown::pdf_document2]`
#'
#' @return A modified `pdf_document2` with the standard tech report formatting.
#' @export
#'
#' @examples
#' \dontrun{
#'   output: ratlas::techreport_pdf
#' }
techreport_pdf <- function(apa6 = FALSE, ...) {
  template_name <- ifelse(apa6, "apa6-template.tex", "template.tex")
  tech_report_template <- find_resource("techreport", template_name)
  base <- bookdown::pdf_document2(template = tech_report_template,
                                  latex_engine = "xelatex",
                                  citation_package = "biblatex",
                                  keep_tex = TRUE, ...)

  # nolint start
  base$knitr$opts_chunk$comment <- "#>"
  base$knitr$opts_chunk$message <- FALSE
  base$knitr$opts_chunk$warning <- FALSE
  base$knitr$opts_chunk$error <- FALSE
  base$knitr$opts_chunk$echo <- FALSE
  base$knitr$opts_chunk$cache <- FALSE
  base$knitr$opts_chunk$fig.width <- 8
  base$knitr$opts_chunk$fig.asp <- 0.618
  base$knitr$opts_chunk$fig.ext <- "pdf"
  base$knitr$opts_chunk$fig.align <- "center"
  base$knitr$opts_chunk$fig.retina <- 3
  base$knitr$opts_chunk$fig.path <- "figures/"
  base$knitr$opts_chunk$fig.pos <- "H"
  base$knitr$opts_chunk$out.extra <- ""
  base$knitr$opts_chunk$out.width <- "100%"
  base$knitr$opts_chunk$fig.show <- "hold"
  # nolint end

  if (tolower(apa6) %in% c("true", "yes")) {
    base$knitr$knit_hooks$plot <- knitr::hook_plot_tex
  } else {
    base$knitr$knit_hooks$plot <- hook_tex_plot_rat
  }

  base
}


#' Create an R Markdown GitBook Tech Report
#'
#' This is a function called in the output of the yaml of the Rmd file to
#' specify using the standard DLM tech report pdf document formatting.
#'
#' @param ... Arguments to be passed to `[bookdown::gitbook]`
#'
#' @return A modified `gitbook` with the standard tech report formatting.
#' @export
#'
#' @examples
#' \dontrun{
#'   output: ratlas::techreport_gitbook
#' }
techreport_gitbook <- function(...) {
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
                        download = "pdf"
                      ), ...)

  # nolint start
  base$knitr$opts_chunk$comment <- "#>"
  base$knitr$opts_chunk$message <- FALSE
  base$knitr$opts_chunk$warning <- FALSE
  base$knitr$opts_chunk$error <- FALSE
  base$knitr$opts_chunk$echo <- FALSE
  base$knitr$opts_chunk$cache <- FALSE
  base$knitr$opts_chunk$fig.width <- 8
  base$knitr$opts_chunk$fig.asp <- 0.618
  base$knitr$opts_chunk$fig.ext <- "png"
  base$knitr$opts_chunk$fig.align <- "center"
  base$knitr$opts_chunk$fig.retina <- 3
  base$knitr$opts_chunk$fig.path <- "figures/"
  base$knitr$opts_chunk$fig.pos <- "H"
  base$knitr$opts_chunk$out.extra <- ""
  base$knitr$opts_chunk$out.width <- "100%"
  base$knitr$opts_chunk$fig.show <- "hold"
  base$knitr$opts_chunk$fig.topcaption <- TRUE
  # nolint end

  # base$knitr$knit_hooks$plot <- hook_html_plot_rat

  base
}


#' Create an HTML Slide Deck with R Markdown
#'
#' This is a function called in the output of the YAML of the Rmd file to
#' specify using the standard DLM tech report pdf document formatting.
#'
#' @param ... Arguments to be passed to `[xaringan::moon_reader]`
#'
#' @return A modified `mood_reader` with ATLAS branding applied.
#' @export
#'
#' @examples
#' \dontrun{
#'   output: ratlas::slides_html
#' }
slides_html <- function(...) {
  default_nature <- list(ratio = "16:9",
                         highlightStyle = "github",
                         highlightLines = TRUE,
                         countIncrementalSlides = FALSE,
                         slideNumberFormat = "%current%")

  dots_args <- list(...)
  dots_name <- names(dots_args)
  if ("nature" %in% dots_name) {
    final_nature <- utils::modifyList(default_nature, dots_args[["nature"]])
  } else {
    final_nature <- default_nature
  }

  base <- xaringan::moon_reader(
    css = c("default", "assets/css/atlas.css", "assets/css/atlas-fonts.css"),
    lib_dir = "libs", nature = final_nature,
    includes = list(in_header = "assets/header.html")
  )

  # nolint start
  base$knitr$opts_chunk$comment <- "#>"
  base$knitr$opts_chunk$message <- FALSE
  base$knitr$opts_chunk$warning <- FALSE
  base$knitr$opts_chunk$error <- FALSE
  base$knitr$opts_chunk$echo <- FALSE
  base$knitr$opts_chunk$cache <- FALSE
  base$knitr$opts_chunk$fig.retina <- 3
  base$knitr$opts_chunk$fig.path <- "figures/"
  # nolint end

  base
}
