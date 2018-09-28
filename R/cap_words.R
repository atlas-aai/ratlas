#' Capitalization function
#'
#' This function allows you to capitalize the first letter of every word in a character string.
#' @param x a character string
#' @keywords capitalization
#' @export
#' @examples
#' cap_words("how are you?")

cap_words <- function(x) {
  s <- strsplit(x, " ")[[1]]
  paste(toupper(substring(s, 1,1)), substring(s, 2),
        sep="", collapse=" ")
}
