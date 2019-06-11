context("atlas-colors")

test_that("atlas colors work", {
  testthat::skip_on_cran()

  df <- data.frame(x = 1:3, y = 1:3, z = c("a", "b", "a"), a = 1)

  plot <- ggplot(df, aes(x, y, colour = z)) +
    geom_point() +
    facet_wrap(~a) +
    scale_color_atlas() +
    theme_atlas()

  plot2 <- ggplot(df, aes(x, y, fill = z)) +
    geom_col() +
    facet_wrap(~a) +
    scale_fill_atlas(use_black = TRUE) +
    theme_atlas()

  vdiffr::expect_doppelganger("atlas_color", plot)
  vdiffr::expect_doppelganger("atlas_fill", plot2)
  vdiffr::expect_doppelganger(
    "atlas_darken",
    plot2 + scale_fill_atlas(darken = 0.2)
  )
  vdiffr::expect_doppelganger(
    "atlas_lighten",
    plot2 + scale_fill_atlas(darken = -0.2)
  )
  vdiffr::expect_doppelganger(
    "atlas_alpha",
    plot2 + scale_fill_atlas(alpha = 0.2)
  )
})
