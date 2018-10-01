#' Format decimals in APA style
#'
#' A function for printing decimals in APA style. If the number cannot exceed -1
#' to 1, then the leading zero should not be printed. This function takes a
#' decimal between -1 and 1, rounds to the specified number of places, and then
#' formats without the leading 0.
#'
#' @param x A numeric value
#' @param digits Number of decimal places. Defaults to 3.
#' @retrun A character string of the formatted and rounded number
#' @export
rat_apa_decimal <- function(x, digits = 3) {
  # Check numeric
  if (!is.numeric(x)) stop("`x` must be a numeric", call. = FALSE)

  # Check acceptable values
  if (!dplyr::between(x, -1, 1)) stop("`x` must be between -1 and 1",
    call. = FALSE)

  stringr::str_replace_all(sprintf(glue::glue("%.{digits}f"), x),
    "^(-?)0.", "\\1.")
}
