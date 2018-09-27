#' Vector concatenating function
#'
#' This function allows you to turn a vector of words or numbers into a character string.
#' The last object in the vector will be connected to the rest of the objects with an "and" by default.
#' @param vec a vector containing either words, numbers, or both.
#' @param final A character object that connects the last object in vec to the rest of the objects in vec. Defaults to "and".
#' @keywords paste concatenate integer text number
#' @export
#' @examples
#' connect_vect(c(4, 5, 6, 7))
#' connect_vect(c("apples", "oranges", "pears"), final = "or")
#' connect_vect(c("chicken", 2))

connect_vect <- function(vec, final = "and") {
  if (length(vec) == 1) {
    return(vec)
  } else if (length(vec) == 2) {
    return(paste(vec[1], final, vec[2]))
  } else {
    vec <- c(vec[1:(length(vec) - 1)], final, vec[length(vec)])
    sub(",\\s+([^,]+)$", " \\1", toString(vec))
  }
}
