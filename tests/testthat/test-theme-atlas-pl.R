library(stringr)

context("theme_atlas_pl")
thm <- theme_atlas_pl()

test_that("theme_atlas_pl is a theme", {
  expect_s3_class(thm, "theme")
})

test_that("theme_atlas_pl uses Palatino font", {
  expect_true(str_detect(thm$text$family, "Palatino"))
  expect_true(str_detect(thm$text$family, "Palatino"))
  expect_true(str_detect(thm$plot.title$family, "Palatino"))
  expect_true(str_detect(thm$plot.subtitle$family, "Palatino"))
  expect_true(str_detect(thm$plot.caption$family, "Palatino"))
  expect_true(str_detect(thm$strip.text$family, "Palatino"))
  expect_true(str_detect(thm$axis.title$family, "Palatino"))
  expect_null(thm$axis.text$family)
  expect_null(thm$legend.text$family)
})

test_that("theme_atlas_pl font sizes are correct", {
  expect_equal(thm$text$size, 11.5)
  expect_equal(thm$plot.title$size, 18)
  expect_equal(thm$plot.subtitle$size, 12)
  expect_equal(thm$strip.text$size, 12)
  expect_equal(thm$plot.caption$size, 9)
  expect_equal(thm$axis.title$size, 11.5)
})

test_that("theme_atlas_pl font colors are correct", {
  expect_equal(thm$text$colour, "black")
  expect_equal(thm$axis.text$colour, "grey30")
})

test_that("theme_atlas_pl grids, axis, and ticks are correct", {
  expect_equal(invisible(theme_atlas_pl(grid = FALSE)),
               theme_atlas_pl(grid = FALSE))
  expect_equal(invisible(theme_atlas_pl(grid = "XY")),
               theme_atlas_pl(grid = "XY"))
  expect_equal(invisible(theme_atlas_pl(grid = "xy")),
               theme_atlas_pl(grid = "xy"))

  expect_equal(invisible(theme_atlas_pl(axis = TRUE)),
               theme_atlas_pl(axis = TRUE))

  expect_equal(invisible(theme_atlas_pl(axis = FALSE)),
               theme_atlas_pl(axis = FALSE))
  expect_equal(invisible(theme_atlas_pl(axis = "xy")),
               theme_atlas_pl(axis = "xy"))
  expect_equal(invisible(theme_atlas_pl(axis = "")),
               theme_atlas_pl(axis = ""))
  expect_equal(invisible(theme_atlas_pl(ticks = TRUE)),
               theme_atlas_pl(ticks = TRUE))
})

test_that("update_geom_font_pl_defaults() works", {
  expect_equal(update_geom_font_pl_defaults(),
               ggplot2::update_geom_defaults("text",
                                             list(family = font_pl,
                                                  face = "plain", size = 3.5,
                                                  color = "#2b2b2b")))
})
