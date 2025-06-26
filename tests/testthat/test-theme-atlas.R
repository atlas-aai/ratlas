thm <- theme_atlas()

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
  expect_in(thm$axis.text$colour, c("grey30", "#4D4D4DFF"))
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

test_that("update_geom_font_defaults() works", {
  expect_equal(update_geom_font_defaults(),
               ggplot2::update_geom_defaults("text",
                                             list(family = "Arial Narrow",
                                                  face = "plain", size = 3.5,
                                                  color = "#2b2b2b")))
})
