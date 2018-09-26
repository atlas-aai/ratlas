#' Word capitalization function
#'
#' This function allows you to capitalize first letters of the first word or every word in a string.
#' @param x A character string
#' @param allwords Defaults to FALSE. If TRUE, the first letter of every word in the string will be capitalized.
#' @keywords capitalization upper
#' @export
#' @examples
#' format_cap("hello world!")
#' format_cap("hello world!", allwords = TRUE)

format_cap <- function(x, allwords = FALSE) {
  if (allwords) {
    s <- strsplit(x, " ")[[1]]
    paste(toupper(substring(s, 1,1)), substring(s, 2),
          sep="", collapse=" ")
  } else {
    s <- strsplit(x, " ")[[1]] %>% tolower()
    s <- paste0(toupper(substring(s, 1, 1)), substring(s, 2))
    if (length(s) > 1) {
      s[2:length(s)] <- tolower(s[2:length(s)])
    }
    paste(s, sep = "", collapse = " ")
  }
}
