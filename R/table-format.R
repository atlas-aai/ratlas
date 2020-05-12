#' Title
#'
#' @param df
#' @param dec_dig
#' @param prop_dig
#' @param corr_dig
#' @param output
#'
#' @return
#' @family formatters
#'
#' @examples
#'
#' @export
fmt_table <- function(df, dec_dig = 1, prop_dig = 3, corr_dig = 3,
                      output = NULL) {
  dec_dig <- check_pos_int(dec_dig, name = "dec_dig")
  prop_dig <- check_pos_int(prop_dig, name = "prop_dig")
  corr_dig <- check_pos_int(corr_dig, name = "corr_dig")

  df %>%
    dplyr::mutate_if(is.integer, pad_counts) %>%
    dplyr::mutate_if(~ is.numeric(.x) && all(dplyr::between(.x, 0, 1)),
                     pad_prop, digits = prop_dig, output = output) %>%
    dplyr::mutate_if(~ is.numeric(.x) && all(dplyr::between(.x, -1, 1)),
                     pad_corr, digits = corr_dig, output = output) %>%
    dplyr::mutate_if(is.numeric, pad_decimal, digits = dec_dig)
}



#' Table Padding
#'
#' A family of functions for formatting numbers and then padding with spaces so
#' that table columns can be both centered and decimal aligned.
#'
#' @param x Number or number string to be formatted
#' @param digits Number of decimal places to retain
#' @param fmt_small Indicator for replacing zero with `<` (e.g., `.000` becomes
#'   `< .001`). Default is `TRUE`.
#' @param output The output type for the rendered document. One of `"latex"` or
#'   `"html"`.
#'
#' @return A character vector of the same length as `x`.
#'
#' @details
#' `pad_counts` should be used to pad integer numbers. This wraps
#' [base::format()] to add a comma separator.
#'
#' `pad_prop` should be used to pad decimal numbers between \[0,1\]. This wraps
#' [fmt_prop()] to round to a specified number of `digits` and optionally
#' remove the leading zero.
#'
#' `pad_corr` should be used to pad decimal numbers between \[-1,1\]. This wraps
#' [fmt_corr()], and is similar to `pad_prop`, but accounts for negative numbers
#' when adding padding.
#'
#' `pad_decimal` should be used to pad decimal number that are not bounded. This
#' wraps [fmt_digits()] to round to a specified number of decimal places.
#'
#' @name padding
#' @family formatters
#'
#' @examples
#' pad_counts(sample(1:1000, size = 20))
#'
#' pad_prop(c(0.001, runif(5)), digits = 2)
#'
#' pad_corr(runif(10, -1, 1), digits = 2)
#'
#' pad_decimal(runif(10, 1, 100), digits = 1)


#' @export
#' @rdname padding
pad_counts <- function(x) {
  max_dig <- max(nchar(abs(x)), na.rm = TRUE)

  new_x <- format(x[!is.na(x)], big.mark = ",")

  if (max_dig == 6) {
    new_x <- new_x %>%
      stringr::str_replace_all("      ", paste(rep("\\\\ ", 11), collapse  = "")) %>%
      stringr::str_replace_all("     ", paste(rep("\\\\ ", 9), collapse = "")) %>%
      stringr::str_replace_all("    ", paste(rep("\\\\ ", 7), collapse = "")) %>%
      stringr::str_replace_all("  ", paste(rep("\\\\ ", 4), collapse = "")) %>%
      stringr::str_replace_all("^ ", paste(rep("\\\\ ", 2), collapse = ""))
  } else if (max_dig == 5) {
    new_x <- new_x %>%
      stringr::str_replace_all("     ", paste(rep("\\\\ ", 9), collapse = "")) %>%
      stringr::str_replace_all("    ", paste(rep("\\\\ ", 7), collapse = "")) %>%
      stringr::str_replace_all("   ", paste(rep("\\\\ ", 5), collapse = "")) %>%
      stringr::str_replace_all("^ ", paste(rep("\\\\ ", 2), collapse = ""))
  } else if (max_dig == 4) {
    new_x <- new_x %>%
      stringr::str_replace_all("    ", paste(rep("\\\\ ", 7), collapse = "")) %>%
      stringr::str_replace_all("   ", paste(rep("\\\\ ", 5), collapse = "")) %>%
      stringr::str_replace_all("  ", paste(rep("\\\\ ", 3), collapse = ""))
  } else if (max_dig == 3) {
    new_x <- new_x %>%
      stringr::str_replace_all("  ", paste(rep("\\\\ ", 4), collapse = "")) %>%
      stringr::str_replace_all("^ ", paste(rep("\\\\ ", 2), collapse = ""))
  } else if (max_dig == 2) {
    new_x <- new_x %>%
      stringr::str_replace_all(" ", paste(rep("\\\\ ", 2), collapse = ""))
  }

  new_x[is.na(x)] <- NA_character_
  return(new_x)
}

#' @export
#' @rdname padding
pad_prop <- function(x, digits, fmt_small = TRUE, output = NULL) {
  digits <- check_pos_int(digits)
  output <- check_output(output)
  new_x <- fmt_prop(x, digits = digits, fmt_small = fmt_small)


  if (any(stringr::str_detect(new_x, "^<"))) {
    pad <- ifelse(output == "latex", 5, 3)
    new_x <- dplyr::case_when(stringr::str_detect(new_x, "^<") ~
                                paste0(new_x, paste(rep("\\ ", pad),
                                                    collapse = "")),
                              TRUE ~ new_x)
  }

  if (any(x == 1)) {
    new_x <- dplyr::case_when(stringr::str_detect(new_x, "^1\\.") ~ new_x,
                              TRUE ~ paste0(paste(rep("\\ ", 2), collapse = ""),
                                            new_x))
  }

  new_x[is.na(x)] <- NA_character_
  return(new_x)
}

#' @export
#' @rdname padding
pad_corr <- function(x, digits, output = NULL) {
  digits <- check_pos_int(digits)
  output <- check_output(output)
  new_x <- fmt_corr(x, digits = digits, output = output)

  if (any(x < 0)) {
    search <- ifelse(output == "latex", "^-", "&minus;")
    pad <- ifelse(output == "latex", 5, 2)
    new_x <- dplyr::case_when(stringr::str_detect(new_x, search) ~
                                paste0(new_x,
                                       paste(rep("\\ ", pad), collapse = "")),
                              TRUE ~ new_x)
  }

  bound <- stringr::str_detect(new_x, glue::glue(".+\\.{paste(rep(0, digits),
                                                 collapse = '')}"))
  if (any(bound)) {
    new_x <- dplyr::case_when(bound ~ new_x,
                              TRUE ~ paste0(paste(rep("\\ ", 2), collapse = ""),
                                            new_x))
  }

  new_x[is.na(x)] <- NA_character_
  return(new_x)
}

#' @export
#' @rdname padding
pad_decimal <- function(x, digits) {
  new_x <- fmt_digits(x, digits = digits)

  new_x <- stringr::str_pad(new_x, width = max(nchar(new_x)), side = "left")

  new_x <- new_x %>%
    stringr::str_replace_all("  ", paste(rep("\\\\ ", 4), collapse = "")) %>%
    stringr::str_replace_all("^ ", paste(rep("\\\\ ", 2), collapse = ""))

  new_x[is.na(x)] <- NA_character_
  return(new_x)
}
