#' Text and Number Formatting
#'
#' These formatting functions are used to format numerical values in a
#' consistent manner. This is useful for printing numbers inline with text, as
#' well as for formatting tables. Many of the included formatting functions were
#' adapted from TJ Mahr's [printy](https://github.com/tjmahr/printy) package.
#'
#' @param x Number or number string to be formatted
#' @param digits Number of decimal places to retain
#' @param replacement The value to use when replacing missing values
#' @param fmt_small Indicator for replacing zero with `<` (e.g., `.000` becomes
#'   `< .001`). Default is `TRUE`.
#'
#' @details
#' `fmt_digits()` is a wrapper for [base::sprintf()]. Prints a number with
#' `digits` number of decimal places, without losing trailing zeros, as happens
#' with [base::round()].
#'
#' `fmt_leading_zero()` removes the leading zero for decimal values.
#'
#' `fmt_minus()` replaces hyphens with the HTML minus sign (`&minus;`).
#'
#' `fmt_replace_na()` replaces `NA` values with a specified replacement. This is
#' useful for formatting tables, when blanks are not desired. The default
#' behavior is to replace missing values with an em-dash (`&mdash;`).
#'
#' Two additional formatters are provided to format numbers according to the
#' American Psychological Association (APA) style guide. The 7th edition of the
#' APA style guide specifies that numbers bounded between \[-1, 1\] should not
#' include the leading zero (section 6.36; APA, 2020). This is the case for many
#' types of numbers commonly used by ATLAS including correlations, proportions,
#' probabilities, and *p*-values. The `fmt_corr()` function is used to format
#' values bounded between \[-1, 1\]. Digits are first rounded to the specified
#' number of digits using `fmt_digits()`, and then leading zeros are removed
#' using `fmt_leading_zero()` and negative signs are replaced with
#' `fmt_minus()`. The `fmt_prop` is very similar, but is intended for values
#' between \[0, 1\]. This function also wraps `fmt_digits()` and
#' `fmt_leading_zero()`. However, `fmt_prop()` also replaces small values to
#' avoid values of `0` (e.g., `.00` is replaced with `< .01`).
#'
#' @name formatting
#' @family formatters
#'
#' @examples
#' test_cor <- cor(mtcars[, 1:4])
#' as.character(round(test_cor[1:4, 3], 2))
#' fmt_digits(test_cor[1:4, 3], 2)
#'
#' fmt_digits(test_cor[1:4, 3], 2) %>%
#'   fmt_leading_zero()
#'
#' fmt_digits(test_cor[1:4, 3], 2) %>%
#'   fmt_minus()
#'
#' fmt_digits(c(test_cor[1:4, 3], NA_real_), 2) %>%
#'   fmt_replace_na(replacement = "&mdash;")
#'
#' fmt_corr(test_cor[1:4, 3], 2)
#'
#' fmt_prop(c(0.001, 0.035, 0.683), digits = 2)
#'
#' @references American Psychological Association. (2020). *Publication manual
#'   of the American Psychological Association* (7th ed.).
#'   \url{https://doi.org/10.1037/0000165-000}


#' @export
#' @rdname formatting
fmt_digits <- function(x, digits = 3) {
  x <- check_number(x, name = "x")
  digits <- check_pos_int(digits, name = "digits")

  round_x <- round(x, digits)
  to_print <- sprintf("%.*f", digits, round_x)
  to_print[is.na(x)] <- NA_character_

  return(to_print)
}

#' @export
#' @rdname formatting
fmt_leading_zero <- function(x) {
  x <- check_character(x)

  non_zero <- x %>%
    as.numeric() %>%
    abs() %>%
    `>`(1) %>%
    stats::na.omit()

  if (any(non_zero)) {
    rlang::warn("unexpected_data",
                message = "Non-zero leading digit")
  }

  replaced <- stringr::str_replace(x, "^(-?)0", "\\1")

  if (any(as.numeric(x) == 0, na.rm = TRUE)) {
    precision <- max(c(stringr::str_count(replaced, "\\d"), 1), na.rm = TRUE)
    new_zero <- paste0(".", paste0(rep(0, precision), collapse = ""))
    replaced[x == 0] <- new_zero
  }

  return(replaced)
}

#' @export
#' @rdname formatting
fmt_minus <- function(x) {
  x <- check_character(x)

  x %>%
    stringr::str_replace("^-", "&minus;") %>%
    # Remove signed zero
    stringr::str_replace("^(&minus;)(0)$", "\\2") %>%
    stringr::str_replace("^(&minus;)(0[.]0+)$", "\\2")
}

#' @export
#' @rdname formatting
fmt_replace_na <- function(x, replacement = "&mdash;") {
  dplyr::if_else(is.na(x), replacement, x)
}

#' @export
#' @rdname formatting
fmt_corr <- function(x, digits) {
  x <- check_bound_real(x, name = "x", lb = -1, ub = 1)
  digits <- check_pos_int(digits, name = "digits")

  x_chr <- x %>%
    fmt_digits(digits) %>%
    fmt_leading_zero() %>%
    fmt_minus()

  return(x_chr)
}

#' @export
#' @rdname formatting
fmt_prop <- function(x, digits, fmt_small = TRUE) {
  x <- check_bound_real(x, name = "x", lb = 0, ub = 1)
  digits <- check_pos_int(digits, name = "digits")

  x_chr <- x %>%
    fmt_digits(digits) %>%
    fmt_leading_zero()

  if (fmt_small) {
    small <- 1 / (10 ^ digits)
    small_text <- small %>%
      fmt_digits(digits) %>%
      fmt_leading_zero() %>%
      paste0_after(.first = "< ")

    x_chr[x < small] <- small_text
  }

  return(x_chr)
}

paste0_after <- function(..., .first) {
  paste0(.first, ...)
}