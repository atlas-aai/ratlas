context("test-set-theme")

# Arial Narrow -----------------------------------------------------------------
set_theme(font = "Arial Narrow", discrete = "okabeito", continuous = "viridis")
thm <- theme_get()

test_that("theme_atlas is a theme", {
  expect_s3_class(thm, "theme")
})

test_that("theme_atlas uses Arial Narrow font", {
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
  expect_equal(thm$text$size, 11.5)
  expect_equal(thm$plot.title$size, 18)
  expect_equal(thm$plot.subtitle$size, 12)
  expect_equal(thm$strip.text$size, 12)
  expect_equal(thm$plot.caption$size, 9)
  expect_equal(thm$axis.title$size, 11.5)
})

test_that("theme_atlas font colors are correct", {
  expect_equal(thm$text$colour, "black")
  expect_equal(thm$axis.text$colour, "grey30")
})

test_that("theme_atlas grids, axis, and ticks are correct", {
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


# Montserrat -------------------------------------------------------------------
set_theme(font = "Montserrat", discrete = "okabeito", continuous = "viridis")
thm <- theme_get()

test_that("theme_atlas_ms is a theme", {
  expect_s3_class(thm, "theme")
})

test_that("theme_atlas_ms uses Montserrat font", {
  expect_equal(thm$text$family, "Montserrat")
  expect_equal(thm$plot.title$family, "Montserrat")
  expect_equal(thm$plot.subtitle$family, "Montserrat")
  expect_equal(thm$plot.caption$family, "Montserrat")
  expect_equal(thm$strip.text$family, "Montserrat")
  expect_equal(thm$axis.title$family, "Montserrat")
  expect_null(thm$axis.text$family)
  expect_null(thm$legend.text$family)
})

test_that("theme_atlas_ms font sizes are correct", {
  expect_equal(thm$text$size, 11.5)
  expect_equal(thm$plot.title$size, 18)
  expect_equal(thm$plot.subtitle$size, 12)
  expect_equal(thm$strip.text$size, 12)
  expect_equal(thm$plot.caption$size, 9)
  expect_equal(thm$axis.title$size, 11.5)
})

test_that("theme_atlas_ms font colors are correct", {
  expect_equal(thm$text$colour, "black")
  expect_equal(thm$axis.text$colour, "grey30")
})

test_that("theme_atlas_ms grids, axis, and ticks are correct", {
  expect_equal(invisible(theme_atlas_ms(grid = FALSE)),
               theme_atlas_ms(grid = FALSE))
  expect_equal(invisible(theme_atlas_ms(grid = "XY")),
               theme_atlas_ms(grid = "XY"))
  expect_equal(invisible(theme_atlas_ms(grid = "xy")),
               theme_atlas_ms(grid = "xy"))

  expect_equal(invisible(theme_atlas_ms(axis = TRUE)),
               theme_atlas_ms(axis = TRUE))

  expect_equal(invisible(theme_atlas_ms(axis = FALSE)),
               theme_atlas_ms(axis = FALSE))
  expect_equal(invisible(theme_atlas_ms(axis = "xy")),
               theme_atlas_ms(axis = "xy"))
  expect_equal(invisible(theme_atlas_ms(axis = "")),
               theme_atlas_ms(axis = ""))
  expect_equal(invisible(theme_atlas_ms(ticks = TRUE)),
               theme_atlas_ms(ticks = TRUE))
})
