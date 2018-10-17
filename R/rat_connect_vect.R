#' Vector concatenating function
#'
#' This function allows you to turn a vector of numeric, character or logical values into a character string.
#' The last object in the vector will be connected to the rest of the objects with an "and" by default.
#' @param vec a vector or list containing character values.
#' @param final A character object that connects the last object in vec to the rest of the objects in vec. Defaults to "and".
#' @keywords paste concatenate integer text number
#' @export
#' @examples
#' rat_connect_vect(c(4, 5, 6, 7))
#' rat_connect_vect(c("apples", "oranges", "pears"), final = "or")
#' rat_connect_vect(c("chicken", 2))

rat_connect_vect <- function(vec, final = "and") {
  vec <- check_vec(vec)
  final <- check_vec(final)

  if (length(vec) == 1) {
    return(vec)
  } else if (length(vec) == 2) {
    return(paste(vec[1], final, vec[2]))
  } else {
    vec <- c(vec[1:(length(vec) - 1)], final, vec[length(vec)])
    sub(",\\s+([^,]+)$", " \\1", toString(vec))
  }
}

check_vec <- function(x) {
  if (!is.character(x)){
    stop("`x` must be a character vector.", call. = FALSE)
  } else {
    x
  }
}

