#' Formatting and rounding numbers function
#'
#' This function allows you to format or round a number to a specified number of decimal places.
#' @param x A numeric value
#' @param digits Number of decimal places. Defaults to 3.
#' @keywords round format numbers
#' @export
#' @examples
#' num_format(2)
#' num_format(340.5892)
#' num_format(340.5892, digits = 2)

num_format <- function(x, digits = 3) {
  str_replace_all(sprintf(glue("%.{digits}f"), x), "^(-?)0.", "\\1.")
}
