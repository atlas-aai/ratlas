#' Format a string with italics for HTML or LaTeX output
#'
#' @param string The character vector to add italics to.
#' @param indicator The indicator for which words should be italicized.
#' @param html Logical for whether the output should be HTML. If `FALSE`, LaTeX
#'   output is provided.
#'
#' @concept HTML
#' @concept LaTeX
#'
#' @return A character vector.
#' @export
#'
#' @examples
#' fmt_italic("Make *this* italic.", html = TRUE)
#' fmt_italic("Make *this* italic.", html = FALSE)
fmt_italic <- function(string, indicator = "*", html = TRUE) {
  check_character(string)
  check_string(indicator)
  check_bool(html, name = "html")

  while (
    any(stringr::str_detect(
      string,
      glue::glue("\\{indicator}(.*)", "\\{indicator}")
    ))
  ) {
    string <- string |>
      stringr::str_replace(
        glue::glue("\\{indicator}(.+?)\\{indicator}"),
        glue::glue(
          "{ifelse(html, '<em>', '\\\\\\\\textit{')}",
          "\\1",
          "{ifelse(html, '</em>', '}')}"
        )
      )
  }

  string
}
