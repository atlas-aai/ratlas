#' Number ordering function
#'
#' This function allows you to convert an integer from 1 to 10 to its corresponding ordinal number. For example, this function will convert the number 4 to its ordinal number "fourth".
#' @param x Ideally an integer from 1 to 10. If x is already a written ordinal number or any integer not in [1, 10], then this function will return x.
#' @keywords convert integer text ordinal number
#' @export
#' @examples
#' order_num(4)
#' order_num("fifth")
#' order_num(-99)

order_num <- function(x) {
  num_lookup <- data_frame(
    number = 1:10,
    word = c("first", "second", "third", "fourth", "fifth", "sixth", "seventh",
             "eighth", "ninth", "tenth")
  )
  if (x %in% num_lookup$number) {
    num_lookup %>%
      filter(number == x) %>%
      pull(word)
  } else {
    x
  }
}
