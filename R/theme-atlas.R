#' ATLAS ggplot2 theme for consistent graphics
#'
#' @param base_size Base font size, given in pts.
#' @param base_family Base font family.
#' @param title_size Title font size, given in pts.
#' @param subtitle_size Subtitle font size, given in pts.
#' @param axis_text_size Axis labels font size, given in pts.
#' @param plot_margin Plot margin (specify with [ggplot2::margin()]).
#' @param ... Additional arguments passed to [ggplot2::theme_minimal()].
#'
#' @return A theme for use in plots created with [ggplot2::ggplot()].
#' @export
#' @examples
#' ggplot(mtcars, aes(mpg, wt)) +
#'   geom_point() +
#'   labs(x = "Fuel efficiency (mpg)", y = "Weight (tons)",
#'        title = "Seminal ggplot2 scatterplot example",
#'        subtitle = "A plot that is only useful for demonstration purposes",
#'        caption = "Brought to you by the letter 'g'") +
#'   theme_atlas()
#'
#' dplyr::count(mtcars, cyl) |>
#'   dplyr::mutate(cyl = factor(cyl)) |>
#'   ggplot(aes(cyl, n)) +
#'   geom_col() +
#'   geom_text(aes(label = n), nudge_y = 1) +
#'   labs(x = "Cylinders", y = "Cars",
#'        title =  "**Seminal *ggplot2* bar chart example**",
#'        subtitle = "A plot that is only useful for demonstration purposes",
#'        caption = "Brought to you by the letter 'g'") +
#'   theme_atlas(base_family = "sans") +
#'   theme(axis.text.y = element_blank())
theme_atlas <- function(base_size = 11.5, base_family = "Archivo Narrow",
                        title_size = 18, subtitle_size = 13,
                        axis_text_size = 10,
                        plot_margin = margin(3, 10, 0, 10), ...) {
  ggplot2::theme_minimal(
    base_size = base_size,
    base_family = base_family,
    ...
  ) %+replace%
  ggplot2::theme(
    plot.margin = plot_margin,
    plot.title = ggtext::element_markdown(size = title_size, hjust = 0),
    plot.subtitle = ggtext::element_markdown(
      size = subtitle_size, hjust = 0,
      padding = unit(c(5, 0, 0, 0), "pt")
    ),
    strip.text = ggtext::element_markdown(),
    axis.title.x = ggtext::element_markdown(
      padding = unit(c(5, 0, 0, 0), "pt")
    ),
    axis.title.y = ggtext::element_markdown(
      angle = 90,
      padding = unit(c(0, 0, 5, 0), "pt")
    ),
    axis.text = ggtext::element_markdown(size = axis_text_size,
                                         color = "black"),
    legend.title = ggtext::element_markdown(),
    legend.background = ggplot2::element_blank(),
    legend.key = ggplot2::element_blank(),
    legend.position = "bottom",
    complete = TRUE
  )
}

#' Set default ggplot2 theme
#'
#' Sets the default color schemes, fonts, and theme for ggplot2 plots. The
#' default color scheme for continuous variables is the
#' [viridis](https://CRAN.R-project.org/package=viridis)
#' color palette, and the default color scheme for discrete variables is the
#' [Okabe Ito](https://jfly.uni-koeln.de/color/) palette.
#'
#' @param font The base font family to be used in plots.
#' @param discrete Color palette for discrete colors. One of "okabeito"
#'   (default), "atlas", or "ggplot2".
#' @param continuous Color palette for continuous scales. One of "magma",
#'   "inferno", "plasma", "viridis" (default), or "cividis", or "ggplot2".
#' @param ... Additional arguments to passed to [theme_atlas()].
#'
#' @return None. Called for side effects.
#' @export
#'
#' @examples
#' p1 <- ggplot(penguins, aes(x = bill_len, y = flipper_len)) +
#'   geom_point(aes(color = species), na.rm = TRUE)
#' p1
#'
#' set_theme_ratlas(font = "mono")
#' p1
#'
#' reset_theme_settings()
#' p1
set_theme_ratlas <- function(font = "Archivo Narrow", discrete = "okabeito",
                             continuous = "mako", ...) {
  discrete <- rlang::arg_match(discrete,
                               values = c("okabeito", "datawrapper", "ggplot2"))
  disc_option <- switch(discrete,
                        okabeito = palette_okabeito,
                        datawrapper = palette_datawrapper,
                        ggplot2 = NULL)


  thm <- theme_atlas(base_family = font, ...) +
    ggplot2::theme(
      geom = ggplot2::element_geom(family = font),
      palette.colour.continuous = scales::pal_viridis(option = continuous),
      palette.fill.continuous = scales::pal_viridis(option = continuous),
      palette.colour.discrete = disc_option,
      palette.fill.discrete = disc_option
    )

  ggplot2::set_theme(thm)
}
