#' Format decimals in APA style
#'
#' A function for printing decimals in APA style. If the number cannot exceed -1
#' to 1, then the leading zero should not be printed. This function takes a
#' decimal between -1 and 1, rounds to the specified number of places, and then
#' formats without the leading 0.
#'
#' @param x A numeric value
#' @param digits Number of decimal places. Defaults to 3.
#' @return A character string of the formatted and rounded number
#' @export
rat_apa_decimal <- function(x, digits = 3) {
  x <- check_apa_decimal(x)
  digits <- check_digits(digits)

  value <- stringr::str_replace_all(sprintf(glue::glue("%.{digits}f"), x),
    "^(-?)0.", "\\1.")

  if (!stringr::str_detect(value, "[1-9]")) {
    value <- glue("<{str_sub(value, start = 1L, end = -2L)}1")
  }

  return(value)
}
rat_apa_decimal <- Vectorize(rat_apa_decimal)


check_apa_decimal <- function(x) {
  if (length(x) != 1 || !is.numeric(x)) {
    stop("`x` must be a length one numeric vector.", call. = FALSE)
  }

  if (!(x > -1 && x < 1) || is.na(x)) {
    stop("`x` must be between -1 and 1 and non-missing.", call. = FALSE)
  } else {
    x
  }
}

check_digits <- function(x) {
  if (length(x) != 1 || !is.numeric(x)) {
    stop("`digits` must be a length one numeric vector.", call. = FALSE)
  }
  x <- as.integer(x)

  if (x < 1 || is.na(x)) {
    stop("`digits` must not be less than one or missing.", call. = FALSE)
  } else {
    x
  }
}
