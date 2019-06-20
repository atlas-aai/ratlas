context("theme_atlas_ms")
thm <- theme_atlas_ms()

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
  invisible(theme_atlas_ms(grid = FALSE))
  invisible(theme_atlas_ms(grid = "XY"))
  invisible(theme_atlas_ms(grid = "xy"))

  invisible(theme_atlas_ms(axis = TRUE))

  invisible(theme_atlas_ms(axis = FALSE))
  invisible(theme_atlas_ms(axis = "xy"))
  invisible(theme_atlas_ms(axis = ""))
  invisible(theme_atlas_ms(ticks = TRUE))
})

test_that("import_montserrat() works", {
  expect_message(import_montserrat())
})

test_that("update_geom_font_ms_defaults() works", {
  expect_equal(update_geom_font_ms_defaults(),
               update_geom_defaults("text", list(
                 family = "Montserrat", face = "plain", size = 3.5,
                 color = "#2b2b2b"
  )))
})
