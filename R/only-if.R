#' Only If
#'
#' Adverb for conditionally skipping steps in a piped workflow.
#'
#' @param condition Logical condition to be evaluated
#' @examples
#' d <- tibble::as_tibble(mtcars)
#' d %>% only_if(TRUE)(dplyr::filter)(mpg > 25)
#'
#' d %>% only_if(FALSE)(dplyr::filter)(mpg > 25)
#' @author David Robinson, https://twitter.com/drob/status/785880369073500161
#' @export
#' @return None. Called for side effects.
only_if <- function(condition) {
  function(func) {
    if (condition) {
      func
    } else {
      function(., ...) .
    }
  }
}
