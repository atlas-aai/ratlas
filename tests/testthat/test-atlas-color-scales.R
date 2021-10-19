library(ggplot2)

test_that("atlas colors work", {
  testthat::skip_on_cran()

  df <- data.frame(x = 1:3, y = 1:3, z = c("a", "b", "a"), a = 1)
  df2 <- data.frame(x = 1:10, y = 1:10, z = letters[1:10], a = 1)

  plot <- ggplot(df, aes(x, y, colour = z)) +
    geom_point() +
    facet_wrap(~ a) +
    scale_color_atlas() +
    theme_atlas()

  plot2 <- ggplot(df, aes(x, y, fill = z)) +
    geom_col() +
    facet_wrap(~ a) +
    theme_atlas()

  plot3 <- ggplot(df2, aes(x, y, colour = z)) +
    geom_point() +
    facet_wrap(~ a) +
    scale_color_atlas() +
    theme_atlas()

  expect_warning(ggplot2::ggplot_build(plot3), "Insufficient values")
  expect_warning(ggplot2::ggplot_build(plot3), "only 6 provided")
  vdiffr::expect_doppelganger("atlas_color", plot)
  vdiffr::expect_doppelganger("atlas_fill",
                              plot2 + scale_fill_atlas(use_black = TRUE))
  vdiffr::expect_doppelganger("atlas_darken",
                              plot2 + scale_fill_atlas(darken = 0.2))
  vdiffr::expect_doppelganger("atlas_lighten",
                              plot2 + scale_fill_atlas(darken = -0.2))
  vdiffr::expect_doppelganger("atlas_alpha",
                              plot2 + scale_fill_atlas(alpha = 0.2))
})
