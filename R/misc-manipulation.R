#' Only If
#'
#' Adverb for conditionally skipping steps in a piped workflow.
#'
#' @param condition Logical condition to be evaluated
#' @examples
#' d <- tibble::as_tibble(mtcars)
#' d %>% only_if(TRUE)(dplyr::filter)(mpg > 25)
#'
#' d %>% only_if(FALSE)(dplyr::filter)(mpg > 25)
#' @author David Robinson, https://twitter.com/drob/status/785880369073500161
#' @export
#' @return None. Called for side effects.
only_if <- function(condition) {
  function(func) {
    if (condition) {
      func
    } else {
      function(., ...) .
    }
  }
}


#' Append row and/or column summaries
#'
#' Add row and/or column summaries (e.g., total counts) to a data frame.
#'
#' @param df A data frame to append summaries to.
#' @param ... Unquoted names of columns to be included in the summary
#' @param row logical indicating whether a summary row should be added (i.e.,
#'   summarizing each column)
#' @param col logical indicating whether a summary column should be added (i.e.,
#'   summarizing each row)
#' @param .f Function to use for calculating summaries
#' @param args A named list of arguments to pass to `.f`
#'
#' @return A data frame with the summary row and/or column appended
#' @export
#'
#' @examples
#' set.seed(9416)
#' df <- tibble::tibble(char = letters[1:5], x = rnorm(5), y = rnorm(5))
#' append_summary(df, x, y, row = TRUE, col = TRUE, .f = sum)
#' append_summary(df, x, y, row = FALSE, .f = mean)
append_summary <- function(df, ..., row = TRUE, col = TRUE, .f = sum,
                           args = NULL) {
  func_name <- as.character(substitute(.f))
  new_df <- df

  if (row) {
    new_df <- new_df %>%
      dplyr::bind_rows(dplyr::summarize_at(., dplyr::vars(...),
                                           ~do.call(.f, c(list(.x), args))))
  }

  if (col) {
    new_df <- new_df %>%
      dplyr::bind_cols(tibble::rowid_to_column(., var = "rowid") %>%
                         dplyr::select("rowid", ...) %>%
                         tidyr::pivot_longer(cols = -"rowid",
                                             names_to = "col_name",
                                             values_to = "value") %>%
                         dplyr::rename(!!func_name := "value") %>%
                         dplyr::group_by(.data$rowid) %>%
                         dplyr::select(-"col_name") %>%
                         dplyr::summarize_all(~do.call(.f, c(list(.x),
                                                             args))) %>%
                         dplyr::arrange(.data$rowid) %>%
                         dplyr::select(-"rowid"))
  }

  return(new_df)
}
