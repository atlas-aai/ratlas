#' Capitalization function
#'
#' This function allows you to capitalize the first letter of every word in a character string.
#' @param x a character string
#' @keywords capitalization
#' @export
#' @examples
#' rat_cap_words("how are you?")

rat_cap_words <- function(x) {
  x <- check_char(x)
  x <- check_xlength(x)

  s <- strsplit(x, " ")[[1]]
  paste(toupper(substring(s, 1, 1)),
        substring(s, 2),
        sep = "",
        collapse = " ")
}

check_char <- function(x) {
  if (!is.character(x)){
    stop("`x` must be character.", call. = FALSE)
  } else {
    x
  }
}
