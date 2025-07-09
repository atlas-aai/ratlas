#' Append row and/or column summaries
#'
#' Add row and/or column summaries (e.g., total counts) to a data frame.
#'
#' @param df A data frame to append summaries to.
#' @param ... Unquoted names of columns to be included in the summary.
#' @param row logical indicating whether a summary row should be added (i.e.,
#'   summarizing each column).
#' @param col logical indicating whether a summary column should be added (i.e.,
#'   summarizing each row).
#' @param .f Function to use for calculating summaries.
#' @param args A named list of additional arguments to pass to `.f`.
#'
#' @return A data frame with the summary row and/or column appended
#' @export
#'
#' @examples
#' df <- head(penguins[, c("species", "bill_len", "flipper_len")])
#' append_summary(df, bill_len, flipper_len, row = TRUE, col = TRUE, .f = sum)
#'
#' append_summary(df, where(is.numeric), .f = sum, args = list(na.rm = TRUE))
#'
#' append_summary(df, bill_len, flipper_len, row = FALSE, .f = mean)
append_summary <- function(df, ..., row = TRUE, col = TRUE, .f = sum,
                           args = NULL) {
  func_name <- as.character(substitute(.f))
  new_df <- df

  if (row) {
    col_summary <- new_df |>
      dplyr::select(...) |>
      dplyr::summarize(
        dplyr::across(dplyr::everything(),
                      \(x) do.call(.f, c(list(x), args)))
      )

    new_df <- dplyr::bind_rows(new_df, col_summary)
  }

  if (col) {
    row_summary <- new_df |>
      dplyr::select(...) |>
      dplyr::rowwise() |>
      dplyr::mutate(
        # !!func_name := .f(dplyr::c_across(dplyr::everything()))
        !!func_name := do.call(.f, c(list(dplyr::c_across(dplyr::everything())), args))
      ) |>
      dplyr::ungroup()

    new_df <- new_df |>
      dplyr::mutate(!!func_name := row_summary[[func_name]])
  }

  new_df
}


#' Center and Decimal Align Tables
#'
#' Automatic formatting for tables that should "just work" for most use cases.
#' For more fine-grained control, see [ratlas::formatting] and
#' [ratlas::padding].
#'
#' @param df A data frame or tibble to be formatted for printing in output.
#' @param dec_dig The number of decimal places to include for numbers, e.g.,
#'   `dec_dig = 1` for 16.5.
#' @param prop_dig The number of decimal places to include for numbers bounded
#'   between \[0,1\], e.g., `prop_dig = 2` for .35.
#' @param corr_dig The number of decimal places to include for numbers bounded
#'   between \[-1,1\], e.g., `corr_dig = 3` for .205.
#' @param fmt_small Indicator for replacing zero with `<` (e.g., `.000` becomes
#'   `<.001`). Default is `TRUE`.
#' @param max_value If `fmt_small` is `TRUE` and a `max_value` is supplied,
#'  any value greater than the `max_value` is replaced with `>`
#'  (e.g., if `max_value` = 50, then `60` becomes `>49.9`). The number of digits
#'  depends on either `dec_digits`, `prop_dig`, or `corr_dig`.
#' @param keep_zero If `fmt_small` is `TRUE`, whether to preserve true 0s (e.g.,
#'   `0.0000001` becomes `<.001`, but `0.0000000` stays `.000`).
#' @param output The output format of the table. One of "latex" or "html".
#'   Automatically pulled from document output type if not specified.
#'
#' @return A tibble with the same rows and columns as `df`, with numbers
#'   formatted consistently and padded for alignment when printed.
#' @family formatters
#' @examples
#' pcts <- tibble::tibble(n = 0:5, p = 0.5 * (0:5))
#' fmt_table(pcts)
#' @export
fmt_table <- function(df, dec_dig = 1, prop_dig = 3, corr_dig = 3,
                      output = NULL, fmt_small = TRUE, max_value = NULL,
                      keep_zero = FALSE) {
  check_number_whole(dec_dig, min = 1)
  check_number_whole(prop_dig, min = 1)
  check_number_whole(corr_dig, min = 1)

  df |>
    dplyr::mutate(dplyr::across(where(is.integer),
                                function(x) pad_counts(x))) |>
    dplyr::mutate(
      dplyr::across(
        where(\(x) is.numeric(x) && all(dplyr::between(x, 0, 1), na.rm = TRUE)),
        \(x) pad_prop(x, digits = prop_dig, fmt_small = fmt_small,
                      keep_zero = keep_zero, output = output)
      )
    ) |>
    dplyr::mutate(
      dplyr::across(
        where(\(x) is.numeric(x) && all(dplyr::between(x, -1, 1), na.rm = TRUE)),
        \(x) pad_corr(x, digits = corr_dig, output = output)
      )
    ) |>
    dplyr::mutate(
      dplyr::across(
        where(is.numeric),
        \(x) pad_decimal(x, digits = dec_dig, fmt_small = fmt_small,
                         max_value = max_value, keep_zero = keep_zero)
      )
    )
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
#' @param max_value If `fmt_small` is `TRUE` and a `max_value is supplied`,
#'  any value greater than the `max_value` is replaced with `>`
#'  (e.g., if `max_value` = 50, then `60` becomes `>49.9`). The number of digits
#'  depends on `digits`.
#' @param keep_zero If `fmt_small` is `TRUE`, whether to preserve true 0s (e.g.,
#'   `0.0000001` becomes `<.001`, but `0.0000000` stays `.000`).
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
NULL

#' @export
#' @rdname padding
pad_counts <- function(x, digits = 0L) {
  x <- round(x, digits = digits)
  max_dig <- max(nchar(stringr::str_replace_all(abs(x), "\\.", "")),
                 na.rm = TRUE)

  new_x <- format(x, big.mark = ",", nsmall = digits)

  if (max_dig == 7) {
    new_x <- new_x |>
      stringr::str_replace_all("       ", paste(rep("\\\\ ", 12), collapse = "")) |>
      stringr::str_replace_all("      ", paste(rep("\\\\ ", 11), collapse = "")) |>
      stringr::str_replace_all("     ", paste(rep("\\\\ ", 9), collapse = "")) |>
      stringr::str_replace_all("    ", paste(rep("\\\\ ", 7), collapse = "")) |>
      stringr::str_replace_all("  ", paste(rep("\\\\ ", 4), collapse = "")) |>
      stringr::str_replace_all("^ ", paste(rep("\\\\ ", 2), collapse = ""))
  } else if (max_dig == 6) {
    new_x <- new_x |>
      stringr::str_replace_all("      ", paste(rep("\\\\ ", 11), collapse  = "")) |>
      stringr::str_replace_all("     ", paste(rep("\\\\ ", 8), collapse = "")) |>
      stringr::str_replace_all("    ", paste(rep("\\\\ ", 7), collapse = "")) |>
      stringr::str_replace_all("  ", paste(rep("\\\\ ", 4), collapse = "")) |>
      stringr::str_replace_all("^ ", paste(rep("\\\\ ", 2), collapse = ""))
  } else if (max_dig == 5) {
    new_x <- new_x |>
      stringr::str_replace_all("     ", paste(rep("\\\\ ", 9), collapse = "")) |>
      stringr::str_replace_all("    ", paste(rep("\\\\ ", 6), collapse = "")) |>
      stringr::str_replace_all("   ", paste(rep("\\\\ ", 5), collapse = "")) |>
      stringr::str_replace_all("  ", paste0(rep("\\\\ ", 2), collapse = "")) |>
      stringr::str_replace_all("^ ", paste(rep("\\\\ ", 2), collapse = ""))
  } else if (max_dig == 4) {
    new_x <- new_x |>
      stringr::str_replace_all("    ", paste(rep("\\\\ ", 7), collapse = "")) |>
      stringr::str_replace_all("   ", paste(rep("\\\\ ", 5), collapse = "")) |>
      stringr::str_replace_all("  ", paste(rep("\\\\ ", 3), collapse = "")) |>
      stringr::str_replace_all("^ ", paste0(rep("\\\\ ", 2), collapse = ""))
  } else if (max_dig == 3) {
    new_x <- new_x |>
      stringr::str_replace_all("  ", paste(rep("\\\\ ", 4), collapse = "")) |>
      stringr::str_replace_all("^ ", paste(rep("\\\\ ", 2), collapse = ""))
  } else if (max_dig == 2) {
    new_x <- new_x |>
      stringr::str_replace_all(" ", paste(rep("\\\\ ", 2), collapse = ""))
  }

  if (any(stringr::str_detect(new_x, ",")) & digits > 0L) {
    new_x <- dplyr::case_when(stringr::str_detect(new_x, ",") ~ new_x,
                              TRUE ~ paste0("\\ ", new_x))
  }

  new_x <- stringr::str_replace_all(new_x, "(?<!\\\\) ", "")

  new_x[is.na(x)] <- NA_character_
  return(new_x)
}

#' @export
#' @rdname padding
pad_prop <- function(x, digits, fmt_small = TRUE, keep_zero = FALSE,
                     output = NULL) {
  check_number_whole(digits, min = 1)
  output <- check_output(output)
  new_x <- fmt_prop(x, digits = digits, fmt_small = fmt_small,
                    keep_zero = keep_zero)
  new_x[is.na(new_x)] <- "NA"

  if (any(stringr::str_detect(new_x, "^<|^>")) &
      !all(stringr::str_detect(new_x, "^<|^>"))) {
    pad <- ifelse(output == "latex", 4, 3)
    new_x <- dplyr::case_when(stringr::str_detect(new_x, "^<|^>") ~
                                paste0(new_x, paste(rep("\\ ", pad),
                                                    collapse = "")),
                              TRUE ~ new_x)
  }

  if (any(x == 1, na.rm = TRUE)) {
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
  check_number_whole(digits, min = 1)
  output <- check_output(output)
  new_x <- fmt_corr(x, digits = digits, output = output)
  new_x[is.na(new_x)] <- "NA"

  if (any(x < 0, na.rm = TRUE)) {
    search <- ifelse(output == "latex", "^-", "&minus;")
    pad <- ifelse(output == "latex", 4, 2)
    new_x <- dplyr::case_when(stringr::str_detect(new_x, search) ~
                                paste0(new_x,
                                       paste(rep("\\ ", pad), collapse = "")),
                              TRUE ~ new_x)
  }

  bound <- stringr::str_detect(new_x, glue::glue(".+\\.{paste(rep(0, digits),
                                                 collapse = '')}"))
  if (any(bound, na.rm = TRUE)) {
    new_x <- dplyr::case_when(bound ~ new_x,
                              TRUE ~ paste0(paste(rep("\\ ", 2), collapse = ""),
                                            new_x))
  }

  new_x[is.na(x)] <- NA_character_
  return(new_x)
}

#' @export
#' @rdname padding
pad_decimal <- function(x, digits, fmt_small = FALSE, max_value = NULL,
                        keep_zero = FALSE, output = NULL) {
  check_number_whole(digits, min = 1)
  output <- check_output(output)

  left_spaces <- x |>
    abs() |>
    fmt_digits(digits)
  left_spaces <- left_spaces |>
    stringr::str_pad(width = max(nchar(left_spaces), na.rm = TRUE),
                     side = "left") |>
    stringr::str_count(" ") |>
    tidyr::replace_na(0)

  new_x <- x |>
    fmt_digits(digits = digits, fmt_small = fmt_small, max_value = max_value,
               keep_zero = keep_zero) |>
    fmt_minus(output = output)

  new_x <- purrr::map2_chr(new_x, left_spaces, function(num, space) {
    paste0(paste0(rep(" ", space), collapse = ""), num, collapse = "")
  })

  new_x <- new_x |>
    stringr::str_replace_all("  ", paste(rep("\\\\ ", 4), collapse = "")) |>
    stringr::str_replace_all("^ ", paste(rep("\\\\ ", 2), collapse = ""))

  if (any(x < 0, na.rm = TRUE)) {
    search <- ifelse(output == "latex", "-", "&minus;")
    pad <- ifelse(output == "latex", 2, 2)
    new_x <- dplyr::case_when(stringr::str_detect(new_x, search) ~
                                paste0(new_x,
                                       paste(rep("\\ ", pad), collapse = "")),
                              TRUE ~ new_x)
  }

  if (any(stringr::str_detect(new_x, "<")) &
      !all(stringr::str_detect(new_x, "<"))) {
    pad <- ifelse(output == "latex", 3, 2)
    new_x <- dplyr::case_when(stringr::str_detect(new_x, "<|>") ~
                                paste0(new_x, paste(rep("\\ ", pad),
                                                    collapse = "")),
                              TRUE ~ new_x)
  }

  if (any(stringr::str_detect(new_x, ">")) &
      !all(stringr::str_detect(new_x, ">"))) {
    pad <- ifelse(output == "latex", 1, 2)
    new_x <- dplyr::case_when(stringr::str_detect(new_x, "<|>") ~
                                paste0(new_x, paste(rep("\\ ", pad),
                                                    collapse = "")),
                              TRUE ~ new_x)
  }

  new_x[is.na(x)] <- NA_character_
  return(new_x)
}


#' Combine N and Percent Columns for Accessibility
#'
#' @param df A data frame that has already been sent to [fmt_table()].
#' @param n The unquoted name of the column containing count values.
#' @param pct The unquoted name of the column containing percentage values.
#' @param name The name of the new combined column to be created.
#' @param remove Logical. Should the existing `n` and `pct` columns be removed?
#' @param na_replace Character string representing how missing values should be
#'   represented.
#'
#' @return A data frame.
#' @export
#' @examples
#' pcts <- tibble::tibble(Program = LETTERS[1:10],
#'                        n = 1:10,
#'                        p = seq(0, 100, length.out = 10))
#' pcts |>
#'   fmt_table(max_value = 100) |>
#'   combine_n_pct(n = n, pct = p, name = "States")
combine_n_pct <- function(df, n, pct, name, remove = TRUE, na_replace = NULL) {
  n <- rlang::enquo(n)
  pct <- rlang::enquo(pct)

  df |>
    dplyr::mutate(col1 = !!n,
                  col2 = !!pct,
                  col2 = stringr::str_replace_all(.data$col2,
                                                  "([0-9|\\.]+)",
                                                  "(\\1)"),
                  col2 = stringr::str_replace_all(.data$col2,
                                                  stringr::fixed("<("), "(<"),
                  combined_col = paste0(.data$col1, "\\ ", .data$col2)) |>
    only_if(!is.null(na_replace))(dplyr::mutate)(
      combined_col = dplyr::case_when(is.na(col1) ~ na_replace,
                                      TRUE ~ .data$combined_col)) |>
    dplyr::mutate(!!name := .data$combined_col) |>
    dplyr::select(-.data$col1, -.data$col2, -.data$combined_col) |>
    only_if(remove)(dplyr::select)(-!!n, -!!pct)
}
