context("test-set-theme")

test_that("set_theme correctly sets theme to theme_atlas_ms", {
  invisible(set_theme("theme_atlas_ms"))
  df <- data.frame(x = 1:3, y = 1:3, z = c("a", "b", "a"), a = 1)

  plot <- ggplot(df, aes(x, y, colour = z)) +
    geom_point() +
    facet_wrap(~ a)

  vdiffr::expect_doppelganger("set_theme_atlas_ms", plot + theme_atlas_ms())
})

test_that("set_theme correctly sets theme to theme_atlas", {
  invisible(set_theme())
  df <- data.frame(x = 1:3, y = 1:3, z = c("a", "b", "a"), a = 1)

  plot <- ggplot(df, aes(x, y, colour = z)) +
    geom_point() +
    facet_wrap(~ a)

  vdiffr::expect_doppelganger("set_theme_atlas", plot + theme_atlas())
})
