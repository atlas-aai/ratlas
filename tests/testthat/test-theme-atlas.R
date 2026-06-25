test_that("theme_atlas() fonts and axes", {
  p <- ggplot(penguins, aes(x = bill_len, y = flipper_len)) +
    geom_point(na.rm = TRUE) +
    labs(
      x = "**Bill length** (mm)",
      y = "*Flipper length* (mm)",
      title = "**Example plot**",
      subtitle = "Plot subtitle"
    ) +
    theme_atlas(base_family = "Roboto Condensed")
  vdiffr::expect_doppelganger("default-scatter", p)

  p <- ggplot(penguins, aes(x = bill_len)) +
    geom_histogram(na.rm = TRUE, bins = 30) +
    labs(
      x = "**Bill length** (mm)",
      y = "*n*",
      title = "**Example plot**",
      subtitle = "Plot subtitle"
    ) +
    theme_atlas(transparent = TRUE)
  vdiffr::expect_doppelganger("default-histogram", p)
})

test_that("theme_atlas() palettes", {
  p <- ggplot(penguins, aes(x = bill_len, y = flipper_len)) +
    geom_point(aes(color = species), na.rm = TRUE) +
    labs(
      x = "**Bill length** (mm)",
      y = "*Flipper length* (mm)",
      title = "**Example plot**",
      subtitle = "Plot subtitle"
    ) +
    theme_atlas(transparent = TRUE)
  vdiffr::expect_doppelganger("discrete-color", p)

  p <- ggplot(penguins, aes(x = bill_len, y = flipper_len)) +
    geom_bin_2d(na.rm = TRUE, bins = 30) +
    labs(
      x = "**Bill length** (mm)",
      y = "*Flipper length* (mm)",
      title = "**Example plot**",
      subtitle = "Plot subtitle"
    ) +
    theme_atlas()
  vdiffr::expect_doppelganger("continuous-color", p)
})
