context("okabeito-colors")

test_that("Okabe Ito colors work", {
  testthat::skip_on_cran()

  df <- data.frame(x = 1:3, y = 1:3, z = c("a", "b", "a"), a = 1)

  plot <- ggplot(df, aes(x, y, colour = z)) +
    geom_point() +
    facet_wrap(~a) +
    scale_color_OkabeIto() +
    theme_atlas()

  plot2 <- ggplot(df, aes(x, y, fill = z)) +
    geom_col() +
    facet_wrap(~a) +
    scale_fill_OkabeIto(use_black = TRUE) +
    theme_atlas()

  vdiffr::expect_doppelganger("okabeito_color", plot)
  vdiffr::expect_doppelganger("okabeito_fill", plot2)
  vdiffr::expect_doppelganger(
    "okabeito_darken",
    plot2 + scale_fill_OkabeIto(darken = 0.2)
  )
  vdiffr::expect_doppelganger(
    "okabeito_lighten",
    plot2 + scale_fill_OkabeIto(darken = -0.2)
  )
  vdiffr::expect_doppelganger(
    "okabeito_alpha",
    plot2 + scale_fill_OkabeIto(alpha = 0.2)
  )
})
