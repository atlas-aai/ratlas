#' Number ordering function
#'
#' This function allows you to convert an integer from 1 to 10 to its corresponding ordinal number. For example, this function will convert the number 4 to its ordinal number "fourth".
#' @param x An integer from 1 to 10. If x is already a written ordinal number or any integer not in 1-10, then this function will return x.
#' @keywords convert integer text ordinal number
#' @export
#' @examples
#' rat_order_num(4)

rat_order_num <- function(x) {
  x <- check_numeric(x)
  x <- check_range(x)
  x <- check_xlength(x)

  num_lookup <- tibble::data_frame(
    number = 1:10,
    word = c("first", "second", "third", "fourth", "fifth", "sixth", "seventh",
             "eighth", "ninth", "tenth")
  )
  if (x %in% num_lookup$number) {
    num_lookup %>%
      dplyr::filter(.data$number == x) %>%
      dplyr::pull(.data$word)
  } else {
    x
  }
}

check_numeric <- function(x) {
  if (!is.numeric(x)) {
    stop("`x` must be numeric.", call. = FALSE)
  } else {
    x
  }
}

check_range <- function(x) {
  if (!x %in% 1:10) {
    stop("`x` must be an integer from 1 through 10.", call. = FALSE)
  } else {
    x
  }
}

check_xlength <- function(x) {
  if (length(x) != 1) {
    stop("`x` must be length one.", call. = FALSE)
  } else {
    x
  }
}
