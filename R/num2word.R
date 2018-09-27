#' Number converting function
#'
#' This function allows you to convert an integer from 0 to 9 to a text representation of the integer. For example, this function will convert the number 4, to the word "four".
#' @param x Ideally an integer from 0 to 9. If x is already a written number or any integer not in [0, 9], then this function will return x.
#' @keywords convert integer text number
#' @export
#' @examples
#' num2word(4)
#' num2word("five")
#' num2word(-99)

num2word <- function(x) {
  num_lookup <- data_frame(
    number = 0:9,
    word = c("zero", "one", "two", "three", "four", "five", "six", "seven",
             "eight", "nine")
  )
  if (x %in% num_lookup$number) {
    num_lookup %>%
      filter(number == x) %>%
      pull(word)
  } else {
    x
  }
}
