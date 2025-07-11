test_that("Okabe Ito colors work", {
  df <- data.frame(x = 1:3, y = 1:3, z = c("a", "b", "a"), a = 1)
  df2 <- data.frame(x = 1:10, y = 1:10, z = letters[1:10], a = 1)

  plot1 <- ggplot(df, aes(x, y, colour = z)) +
    geom_point(size = 4) +
    facet_wrap(~ a) +
    scale_color_okabeito()

  plot2 <- ggplot(df, aes(x, y, fill = z)) +
    geom_col() +
    facet_wrap(~ a)

  plot3 <- ggplot(df2, aes(x, y, colour = z)) +
    geom_point() +
    facet_wrap(~ a) +
    scale_colour_okabeito() +
    theme_atlas()

  vdiffr::expect_doppelganger("okabeito_color", plot1)
  vdiffr::expect_doppelganger("okabeito_fill",
                              plot2 + scale_fill_okabeito(order = 7:8,
                                                          use_black = TRUE))
  vdiffr::expect_doppelganger("okabeito_darken",
                              plot2 + scale_fill_okabeito(order = 5:6,
                                                          darken = 0.2))
  vdiffr::expect_doppelganger("okabeito_lighten",
                              plot2 + scale_fill_okabeito(order = 3:4,
                                                          darken = -0.2))
  vdiffr::expect_doppelganger("okabeito_alpha",
                              plot2 + scale_fill_okabeito(order = c(3, 6),
                                                          alpha = 0.2))
  expect_snapshot_warning(ggplot2::ggplot_build(plot3))
})
