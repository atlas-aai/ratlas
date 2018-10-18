#' Word capitalization function
#'
#' This function allows you to capitalize first letter of the first word or every word in a character string.
#' @param x Must be a character string
#' @param allwords Defaults to FALSE. If TRUE, the first letter of every word in the string will be capitalized.
#' @keywords capitalization upper
#' @export
#' @examples
#' rat_format_cap("hello world!")
#' rat_format_cap("hello world!", allwords = TRUE)

rat_format_cap <- function(x, allwords = FALSE) {
  x <- check_x(x)
  x <- check_singlestring(x)
  allwords <- check_logical(allwords)

  if (allwords) {
    s <- strsplit(x, " ")[[1]]
    paste(toupper(substring(s, 1, 1)),
          substring(s, 2),
          sep = "",
          collapse = " ")
  } else {
    s <- strsplit(x, " ")[[1]] %>% tolower()
    s <- paste0(toupper(substring(s, 1, 1)), substring(s, 2))
    if (length(s) > 1) {
      s[2:length(s)] <- tolower(s[2:length(s)])
    }
    paste(s, sep = "", collapse = " ")
  }
}

check_x <- function(x) {
  if (!is.character(x)) {
    stop("`x` must be a character string.", call. = FALSE)
  } else {
    x
  }
}

check_singlestring <- function(x) {
  if (length(x) != 1) {
    stop("`x` must be length one.", call. = FALSE)
  } else {
    x
  }
}

check_logical <- function(allwords) {
  if (!isTRUE(allwords) & !isFALSE(allwords)) {
    stop("`allwords` must be either TRUE or FALSE.", call. = FALSE)
  } else {
    allwords
  }
}
