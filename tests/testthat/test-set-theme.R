context("test-set-theme")

test_that("set_theme correctly sets theme to theme_atlas_ms", {
  set_theme("Montserrat")
  df <- data.frame(x = 1:3, y = 1:3, z = c("a", "b", "a"), a = 1)

  plot <- ggplot(df, aes(x, y, colour = z)) +
    geom_point() +
    geom_label(aes(label = z)) +
    facet_wrap(~ a)

  vdiffr::expect_doppelganger("set_theme_atlas_ms", plot + theme_atlas_ms())
})

test_that("set_theme correctly sets theme to theme_atlas", {
  set_theme("Arial Narrow")
  df <- data.frame(x = 1:3, y = 1:3, z = c("a", "b", "a"), a = 1)

  plot <- ggplot(df, aes(x, y, colour = z)) +
    geom_point() +
    geom_label(aes(label = z)) +
    facet_wrap(~ a)

  vdiffr::expect_doppelganger("set_theme_atlas", plot + theme_atlas())
})
