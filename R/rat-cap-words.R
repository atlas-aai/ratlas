#' Capitalization of words
#'
#' Capitalize the first letters of words in a string. Can either use sentence
#' case (i.e., only the first word capitalized; `all = FALSE`) or title case
#' (i.e., all words capitalized; `all = TRUE`).
#'
#' @param x A character string
#' @param all Logical. If `TRUE`, the first letter of every word is capitalized.
#'   If `FALSE` (the default), only the first word is capitalized.
#'
#' @return A character string with the specified capitalization.
#' @export
#'
#' @examples
#' name <- c("zip code", "state", "final count")
#' vapply(name, rat_cap_words, character(1))
#' vapply(name, rat_cap_words, character(1), all = TRUE)
rat_cap_words <- function(x, all = FALSE) {
  x <- check_cap_words(x)
  all <- check_all(all)

  if (all) {
    s <- strsplit(x, " ")[[1]]
    paste(toupper(substring(s, 1, 1)), substring(s, 2),
          sep = "", collapse = " ")
  } else {
    s <- strsplit(x, " ")[[1]] %>% tolower()
    s <- paste0(toupper(substring(s, 1, 1)), substring(s, 2))
    if (length(s) > 1) {
      s[2:length(s)] <- tolower(s[2:length(s)])
    }
    paste(s, sep = "", collapse = " ")
  }
}


check_cap_words <- function(x) {
  if (length(x) != 1 || !is.character(x)) {
    stop("`x` must be a length one character vector.", call. = FALSE)
  }

  if (is.na(x)) {
    stop("`x` must be non-missing.", call. = FALSE)
  } else {
    x
  }
}

check_all <- function(x) {
  if (length(x) != 1 || !is.logical(x)) {
    stop("`all` must be a length one logical vector.", call. = FALSE)
  }
  x <- as.integer(x)

  if (is.na(x)) {
    stop("`all` must be non-missing.", call. = FALSE)
  } else {
    x
  }
}
