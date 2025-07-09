#' X & Y scales for percent and comma label formats
#'
#' The `_comma` scales set a comma format (e.g., "1,000" vs. "1000") for axis
#' labels. The `_percent` scales round numbers and add a percentage sign to the
#' label.
#'
#' @inheritParams scales::label_percent
#' @param ... Arguments passed to
#'   [`ggplot2::scale_(x|y)_continuous`][ggplot2::scale_x_continuous].
#'
#' @returns A scale for {ggplot2}.
#' @rdname preset-scales
#' @export
#'
#' @examples
#' dat <- tibble::tibble(count = seq(0, 10000, by = 1000),
#'                       percent = seq(0, 1, by = 0.1))
#'
#' ggplot(dat, aes(x = count, y = percent)) +
#'   geom_point() +
#'   scale_x_comma() +
#'   scale_y_percent()
scale_x_comma <- function(...) {
  scale_x_continuous(labels = scales::label_comma(), ...)
}

#' @rdname preset-scales
#' @export
scale_y_comma <- function(...) {
  scale_y_continuous(labels = scales::label_comma(), ...)
}

#' @rdname preset-scales
#' @export
scale_x_percent <- function(accuracy = NULL, ...) {
  scale_x_continuous(labels = scales::label_percent(accuracy = accuracy), ...)
}

#' @rdname preset-scales
#' @export
scale_y_percent <- function(accuracy = NULL, ...) {
  scale_y_continuous(labels = scales::label_percent(accuracy = accuracy), ...)
}
