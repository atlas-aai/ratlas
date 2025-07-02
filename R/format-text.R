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
  check_character(string)
  check_string(indicator)
  check_bool(html, name = "html")

  while (any(stringr::str_detect(string,
                                 glue::glue("\\{indicator}(.*)",
                                            "\\{indicator}")))) {
    string <- string %>%
      stringr::str_replace(glue::glue("\\{indicator}(.+?)\\{indicator}"),
                           glue::glue("{ifelse(html, '<em>',
                                                 '\\\\\\\\textit{')}",
                                      "\\1",
                                      "{ifelse(html, '</em>', '}')}"))
  }

  return(string)
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
  check_number_whole(x, min = 0)

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

#' Capitalization of words
#'
#' Capitalize the first letters of words in a string. Can either use sentence
#' case (i.e., only the first word capitalized; `all = FALSE`) or title case
#' (i.e., all words capitalized; `all = TRUE`).
#'
#' @param x A character string
#' @param all Logical. If `TRUE`, the first letter of every word is capitalized.
#'   If `FALSE` (the default), only the first word is capitalized.
#'
#' @return A character string with the specified capitalization.
#' @export
#'
#' @examples
#' name <- c("zip code", "state", "final count")
#' vapply(name, capitalize_words, character(1))
#' vapply(name, capitalize_words, character(1), all = TRUE)
capitalize_words <- function(x, all = FALSE) {
  check_string(x)
  check_bool(all)

  if (all) {
    s <- strsplit(x, " ")[[1]]
    paste(toupper(substring(s, 1, 1)), substring(s, 2),
          sep = "", collapse = " ")
  } else {
    s <- tolower(strsplit(x, " ")[[1]])
    s <- paste0(toupper(substring(s, 1, 1)), substring(s, 2))
    if (length(s) > 1) {
      s[2:length(s)] <- tolower(s[2:length(s)])
    }
    paste(s, sep = "", collapse = " ")
  }
}
