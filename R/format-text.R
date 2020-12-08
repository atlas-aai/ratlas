#' Format a String with Italics for HTML or Latex Output
#'
#' @param string The character vector to add italics to.
#' @param indicator The indicator for which words should be italicized
#' @param html Logical for whether the output should be HTML. If `FALSE`, Latex
#'   output is provided.
#'
#' @return A character vector
#' @export
#'
#' @examples
#' fmt_italic("Make *this* italic.", html = TRUE)
#' fmt_italic("Make *this* italic.", html = FALSE)
fmt_italic <- function(string, indicator = "*", html = TRUE) {
  string <- check_character(string, name = "string")
  indicator <- check_character(indicator, name = "indicator")
  html <- check_logical(html, name = "html")

  string %>%
    stringr::str_replace_all(glue::glue("\\{indicator}(.*)\\{indicator}"),
                             glue::glue("{ifelse(html, '<em>',
                                                 '\\\\\\\\textit{')}",
                                        "\\1",
                                        "{ifelse(html, '</em>', '}')}"))
}

#' Write APA Words
#'
#' Confused about whether a number should be written out ("five") or use
#' numerals ("5")? Use this function! Most useful for R Markdown in-text
#' writing.
#'
#' @param x The number to be printed
#' @param ordinal Do you want the ordinal numbering (e.g., 1st, 6th, etc.)
#'
#' @return A character string
#' @export
#'
#' @examples
#' apa_words(5)
#' apa_words(16)
#' apa_words(6, ordinal = TRUE)
apa_words <- function(x, ordinal = FALSE) {
  x <- check_0_int(x, name = "x")

  if (ordinal) {
    return(scales::ordinal(x, big.mark = ","))
  } else {
    if (x < 10) {
      return(english::words(x))
    } else {
      return(fmt_count(x))
    }
  }
}
