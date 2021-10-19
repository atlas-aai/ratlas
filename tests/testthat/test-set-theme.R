library(ggplot2)

# Arial Narrow -----------------------------------------------------------------
test_that("theme_atlas is a theme", {
  local_theme(font = "Arial Narrow", discrete = "okabeito",
              continuous = "viridis")
  thm <- theme_get()

  expect_s3_class(thm, "theme")
})

test_that("theme_atlas uses Arial Narrow font", {
  local_theme(font = "Arial Narrow", discrete = "okabeito",
              continuous = "viridis")
  thm <- theme_get()

  expect_equal(thm$text$family, "Arial Narrow")
  expect_equal(thm$plot.title$family, "Arial Narrow")
  expect_equal(thm$plot.subtitle$family, "Arial Narrow")
  expect_equal(thm$plot.caption$family, "Arial Narrow")
  expect_equal(thm$strip.text$family, "Arial Narrow")
  expect_equal(thm$axis.title$family, "Arial Narrow")
  expect_null(thm$axis.text$family)
  expect_null(thm$legend.text$family)
})

test_that("theme_atlas font sizes are correct", {
  local_theme(font = "Arial Narrow", discrete = "okabeito",
              continuous = "viridis")
  thm <- theme_get()

  expect_equal(thm$text$size, 11.5)
  expect_equal(thm$plot.title$size, 18)
  expect_equal(thm$plot.subtitle$size, 12)
  expect_equal(thm$strip.text$size, 12)
  expect_equal(thm$plot.caption$size, 9)
  expect_equal(thm$axis.title$size, 11.5)
})

test_that("theme_atlas font colors are correct", {
  local_theme(font = "Arial Narrow", discrete = "okabeito",
              continuous = "viridis")
  thm <- theme_get()

  expect_equal(thm$text$colour, "black")
  expect_equal(thm$axis.text$colour, "grey30")
})

test_that("theme_atlas grids, axis, and ticks are correct", {
  local_theme(font = "Arial Narrow", discrete = "okabeito",
              continuous = "viridis")
  thm <- theme_get()

  expect_equal(invisible(theme_atlas(grid = FALSE)),
               theme_atlas(grid = FALSE))
  expect_equal(invisible(theme_atlas(grid = "XY")),
               theme_atlas(grid = "XY"))
  expect_equal(invisible(theme_atlas(grid = "xy")),
               theme_atlas(grid = "xy"))

  expect_equal(invisible(theme_atlas(axis = TRUE)),
               theme_atlas(axis = TRUE))

  expect_equal(invisible(theme_atlas(axis = FALSE)),
               theme_atlas(axis = FALSE))
  expect_equal(invisible(theme_atlas(axis = "xy")),
               theme_atlas(axis = "xy"))
  expect_equal(invisible(theme_atlas(axis = "")),
               theme_atlas(axis = ""))
  expect_equal(invisible(theme_atlas(ticks = TRUE)),
               theme_atlas(ticks = TRUE))
})


# Discrete colors --------------------------------------------------------------
df_d <- data.frame(x = 1:5, y = 1:5, z = letters[1:5])

test_that("okabeito works", {
  local_theme(font = "Arial Narrow", discrete = "okabeito",
              continuous = "viridis")
  thm <- theme_get()

  plot <- ggplot(df_d, aes(x, y, color = z)) +
    geom_label(aes(label = z), size = 3) +
    thm

  vdiffr::expect_doppelganger("an_okabeito", plot)
})

test_that("atlas works", {
  local_theme(font = "Arial Narrow", discrete = "atlas",
              continuous = "viridis")
  thm <- theme_get()

  plot <- ggplot(df_d, aes(x, y, color = z)) +
    geom_label(aes(label = z), size = 3) +
    thm

  vdiffr::expect_doppelganger("an_atlas", plot)
})

test_that("ggplot2 works", {
  local_theme(font = "Arial Narrow", discrete = "ggplot2",
              continuous = "viridis")
  thm <- theme_get()

  plot <- ggplot(df_d, aes(x, y, color = z)) +
    geom_label(aes(label = z), size = 3) +
    thm

  vdiffr::expect_doppelganger("an_ggplot2", plot)
})


# Continuous colors ------------------------------------------------------------
df_c <- data.frame(x = rep(1:3, times = 3), y = rep(1:3, each = 3), z = 1:9)

test_that("magma works", {
  local_theme(font = "Arial Narrow", discrete = "okabeito",
              continuous = "magma")
  thm <- theme_get()

  plot <- ggplot(df_c, aes(x, y, fill = z)) +
    geom_tile() +
    thm

  vdiffr::expect_doppelganger("an_magma", plot)
})

test_that("inferno works", {
  local_theme(font = "Arial Narrow", discrete = "okabeito",
              continuous = "inferno")
  thm <- theme_get()

  plot <- ggplot(df_c, aes(x, y, fill = z)) +
    geom_tile() +
    thm

  vdiffr::expect_doppelganger("an_inferno", plot)
})

test_that("plasma works", {
  local_theme(font = "Arial Narrow", discrete = "okabeito",
              continuous = "plasma")
  thm <- theme_get()

  plot <- ggplot(df_c, aes(x, y, fill = z)) +
    geom_tile() +
    thm

  vdiffr::expect_doppelganger("an_plasma", plot)
})

test_that("viridis works", {
  local_theme(font = "Arial Narrow", discrete = "okabeito",
              continuous = "viridis")
  thm <- theme_get()

  plot <- ggplot(df_c, aes(x, y, fill = z)) +
    geom_tile() +
    thm

  vdiffr::expect_doppelganger("an_viridis", plot)
})

test_that("cividis works", {
  local_theme(font = "Arial Narrow", discrete = "okabeito",
              continuous = "cividis")
  thm <- theme_get()

  plot <- ggplot(df_c, aes(x, y, fill = z)) +
    geom_tile() +
    thm

  vdiffr::expect_doppelganger("an_cividis", plot)
})

test_that("ggplot2 works", {
  local_theme(font = "Arial Narrow", discrete = "okabeito",
              continuous = "ggplot2")
  thm <- theme_get()

  plot <- ggplot(df_c, aes(x, y, fill = z)) +
    geom_tile() +
    thm

  vdiffr::expect_doppelganger("an_ggplot2_c", plot)
})
