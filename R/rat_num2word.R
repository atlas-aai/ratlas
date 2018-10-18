#' Number converting function
#'
#' This function allows you to convert an integer from 0 to 9 to a text representation of the integer. For example, this function will convert the number 4, to the word "four".
#' @param x Ideally an integer from 0 to 9. If x is already a written number or any integer not in 0-9, then this function will return x.
#' @keywords convert integer text number
#' @export
#' @examples
#' rat_num2word(4)
#' rat_num2word("five")
#' rat_num2word(-99)

rat_num2word <- function(x) {
  x <- check_numeric(x)
  x <- check_range09(x)
  x <- check_xlength(x)
  num_lookup <- tibble::data_frame(
    number = 0:9,
    word = c("zero", "one", "two", "three", "four", "five", "six", "seven",
             "eight", "nine")
  )
  if (x %in% num_lookup$number) {
    num_lookup %>%
      dplyr::filter(.data$number == x) %>%
      dplyr::pull(.data$word)
  } else {
    x
  }
}

check_range09 <- function(x) {
  if (!x %in% 0:9) {
    stop("`x` must be an integer from 0 through 9.", call. = FALSE)
  } else {
    x
  }
}
