#' Conditionally include steps in a tidyverse pipeline
#'
#' Adverb for conditionally skipping steps in a piped workflow.
#'
#' @param condition Logical condition to be evaluated
#'
#' @export
#' @return None. Called for side effects.
#'
#' @author David Robinson, https://twitter.com/drob/status/785880369073500161
#'
#' @examples
#' tibble::as_tibble(mtcars) |>
#'   only_if(TRUE)(dplyr::filter)(mpg > 25)
#'
#' tibble::as_tibble(mtcars) |>
#'   only_if(FALSE)(dplyr::filter)(mpg > 25)
only_if <- function(condition) {
  function(func) {
    if (condition) {
      func
    } else {
      function(., ...) .
    }
  }
}
