#' ATLAS ggplot2 theme for consistent graphics
#'
#' Based on \code{hrbrthemes::\link[hrbrthemes]{theme_ipsum}}.
#'
#' @param base_family,base_size base font family and size
#' @param axis_text_size font size of axis text
#' @param axis_title_size axis title font family, face and size
#' @param axis_title_just axis title font justification, one of `[blmcrt]`
#' @param ... Additional arguments passed to [hrbrthemes::theme_ipsum()].
#'
#' @return A theme for use in plots created with [ggplot2::ggplot()].
#' @export
#' @examples
#' \dontrun{
#' library(ggplot2)
#' library(dplyr)
#'
#' # seminal scatterplot
#' ggplot(mtcars, aes(mpg, wt)) +
#'   geom_point() +
#'   labs(x = "Fuel effiiency (mpg)", y = "Weight (tons)",
#'        title = "Seminal ggplot2 scatterplot example",
#'        subtitle = "A plot that is only useful for demonstration purposes",
#'        caption = "Brought to you by the letter 'g'") +
#'   theme_atlas()
#'
#' # seminal bar chart
#'
#' update_geom_font_defaults()
#'
#' count(mpg, class) %>%
#'   ggplot(aes(class, n)) +
#'   geom_col() +
#'   geom_text(aes(label=n), nudge_y=3) +
#'   labs(x = "Fuel efficiency (mpg)", y = "Weight (tons)",
#'        title =  "Seminal ggplot2 bar chart example",
#'        subtitle = "A plot that is only useful for demonstration purposes",
#'        caption = "Brought to you by the letter 'g'") +
#'   theme_atlas(grid = "Y") +
#'   theme(axis.text.y = element_blank())
#'   }
theme_atlas <- function(base_family = "Arial Narrow", base_size = 11.5,
                        axis_text_size = 9,
                        axis_title_size = base_size, axis_title_just = "cm",
                        ...) {
  ret <- hrbrthemes::theme_ipsum(base_family = base_family,
                                 base_size = base_size,
                                 axis_text_size = axis_text_size,
                                 axis_title_size = axis_title_size,
                                 axis_title_just = axis_title_just,
                                 ...)

  ret <- ret +
    ggplot2::theme(legend.background = ggplot2::element_blank(),
                   legend.key = ggplot2::element_blank(),
                   legend.position = "bottom")

  ret
}

#' Update matching font defaults for text geoms
#'
#' Updates [ggplot2::geom_label] and [ggplot2::geom_text] font defaults
#'
#' @param family,face,size,color font family name, face, size and color
#' @return None. Called for side effects.
#' @examples
#' # updates font to Arial Narrow, size to 3.5, and color to #2b2b2b by default
#' update_geom_font_defaults()
#'
#' @export
update_geom_font_defaults <- function(family = "Arial Narrow", face = "plain",
                                      size = 3.5, color = "#2b2b2b") {
  ggplot2::update_geom_defaults("text", list(family = family, fontface = face,
                                             size = size, color = color))
  ggplot2::update_geom_defaults("label", list(family = family, fontface = face,
                                              size = size, color = color))
}

#' @rdname ArialNarrow
#' @title Arial Narrow font name R variable aliases
#' @description `font_an` == "`Arial Narrow`"
#' @format length 1 character vector
#' @export
font_an <- "Arial Narrow"
