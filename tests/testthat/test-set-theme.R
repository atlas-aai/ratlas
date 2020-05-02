# context("test-set-theme")
# library(ggplot2)
# library(stringr)
#
# # Arial Narrow -----------------------------------------------------------------
# set_theme(font = "Arial Narrow", discrete = "okabeito", continuous = "viridis")
# thm <- ggplot2::theme_get()
#
# test_that("theme_atlas is a theme", {
#   expect_s3_class(thm, "theme")
# })
#
# test_that("theme_atlas uses Arial Narrow font", {
#   expect_equal(thm$text$family, "Arial Narrow")
#   expect_equal(thm$plot.title$family, "Arial Narrow")
#   expect_equal(thm$plot.subtitle$family, "Arial Narrow")
#   expect_equal(thm$plot.caption$family, "Arial Narrow")
#   expect_equal(thm$strip.text$family, "Arial Narrow")
#   expect_equal(thm$axis.title$family, "Arial Narrow")
#   expect_null(thm$axis.text$family)
#   expect_null(thm$legend.text$family)
# })
#
# test_that("theme_atlas font sizes are correct", {
#   expect_equal(thm$text$size, 11.5)
#   expect_equal(thm$plot.title$size, 18)
#   expect_equal(thm$plot.subtitle$size, 12)
#   expect_equal(thm$strip.text$size, 12)
#   expect_equal(thm$plot.caption$size, 9)
#   expect_equal(thm$axis.title$size, 11.5)
# })
#
# test_that("theme_atlas font colors are correct", {
#   expect_equal(thm$text$colour, "black")
#   expect_equal(thm$axis.text$colour, "grey30")
# })
#
# test_that("theme_atlas grids, axis, and ticks are correct", {
#   expect_equal(invisible(theme_atlas(grid = FALSE)),
#                theme_atlas(grid = FALSE))
#   expect_equal(invisible(theme_atlas(grid = "XY")),
#                theme_atlas(grid = "XY"))
#   expect_equal(invisible(theme_atlas(grid = "xy")),
#                theme_atlas(grid = "xy"))
#
#   expect_equal(invisible(theme_atlas(axis = TRUE)),
#                theme_atlas(axis = TRUE))
#
#   expect_equal(invisible(theme_atlas(axis = FALSE)),
#                theme_atlas(axis = FALSE))
#   expect_equal(invisible(theme_atlas(axis = "xy")),
#                theme_atlas(axis = "xy"))
#   expect_equal(invisible(theme_atlas(axis = "")),
#                theme_atlas(axis = ""))
#   expect_equal(invisible(theme_atlas(ticks = TRUE)),
#                theme_atlas(ticks = TRUE))
# })
#
#
# # Montserrat -------------------------------------------------------------------
# set_theme(font = "Montserrat", discrete = "okabeito", continuous = "viridis")
# thm <- ggplot2::theme_get()
#
# test_that("theme_atlas_ms is a theme", {
#   expect_s3_class(thm, "theme")
# })
#
# test_that("theme_atlas_ms uses Montserrat font", {
#   expect_equal(thm$text$family, "Montserrat")
#   expect_equal(thm$plot.title$family, "Montserrat")
#   expect_equal(thm$plot.subtitle$family, "Montserrat")
#   expect_equal(thm$plot.caption$family, "Montserrat")
#   expect_equal(thm$strip.text$family, "Montserrat")
#   expect_equal(thm$axis.title$family, "Montserrat")
#   expect_null(thm$axis.text$family)
#   expect_null(thm$legend.text$family)
# })
#
# test_that("theme_atlas_ms font sizes are correct", {
#   expect_equal(thm$text$size, 11.5)
#   expect_equal(thm$plot.title$size, 18)
#   expect_equal(thm$plot.subtitle$size, 12)
#   expect_equal(thm$strip.text$size, 12)
#   expect_equal(thm$plot.caption$size, 9)
#   expect_equal(thm$axis.title$size, 11.5)
# })
#
# test_that("theme_atlas_ms font colors are correct", {
#   expect_equal(thm$text$colour, "black")
#   expect_equal(thm$axis.text$colour, "grey30")
# })
#
# test_that("theme_atlas_ms grids, axis, and ticks are correct", {
#   expect_equal(invisible(theme_atlas_ms(grid = FALSE)),
#                theme_atlas_ms(grid = FALSE))
#   expect_equal(invisible(theme_atlas_ms(grid = "XY")),
#                theme_atlas_ms(grid = "XY"))
#   expect_equal(invisible(theme_atlas_ms(grid = "xy")),
#                theme_atlas_ms(grid = "xy"))
#
#   expect_equal(invisible(theme_atlas_ms(axis = TRUE)),
#                theme_atlas_ms(axis = TRUE))
#
#   expect_equal(invisible(theme_atlas_ms(axis = FALSE)),
#                theme_atlas_ms(axis = FALSE))
#   expect_equal(invisible(theme_atlas_ms(axis = "xy")),
#                theme_atlas_ms(axis = "xy"))
#   expect_equal(invisible(theme_atlas_ms(axis = "")),
#                theme_atlas_ms(axis = ""))
#   expect_equal(invisible(theme_atlas_ms(ticks = TRUE)),
#                theme_atlas_ms(ticks = TRUE))
# })
#
# # Discrete colors --------------------------------------------------------------
# df_d <- data.frame(x = 1:5, y = 1:5, z = letters[1:5])
#
# set_theme(font = "Montserrat", discrete = "okabeito")
# thm <- ggplot2::theme_get()
# test_that("okabeito works", {
#   plot <- ggplot(df_d, aes(x, y, color = z)) +
#     geom_label(aes(label = z), size = 3) +
#     thm
#
#   vdiffr::expect_doppelganger("ms_okabeito", plot)
# })
#
# set_theme(font = "Montserrat", discrete = "atlas")
# thm <- ggplot2::theme_get()
# test_that("atlas works", {
#   plot <- ggplot(df_d, aes(x, y, color = z)) +
#     geom_label(aes(label = z), size = 3) +
#     thm
#
#   vdiffr::expect_doppelganger("ms_atlas", plot)
# })
#
# set_theme(font = "Montserrat", discrete = "ggplot2")
# thm <- ggplot2::theme_get()
# test_that("ggplot2 works", {
#   plot <- ggplot(df_d, aes(x, y, color = z)) +
#     geom_label(aes(label = z), size = 3) +
#     thm
#
#   vdiffr::expect_doppelganger("ms_ggplot2", plot)
# })
#
#
# # Continuous colors ------------------------------------------------------------
# df_c <- data.frame(x = rep(1:3, times = 3), y = rep(1:3, each = 3), z = 1:9)
#
# set_theme(font = "Montserrat", continuous =  "magma")
# thm <- ggplot2::theme_get()
# test_that("magma works", {
#   plot <- ggplot(df_c, aes(x, y, fill = z)) +
#     geom_tile() +
#     thm
#
#   vdiffr::expect_doppelganger("ms_magma", plot)
# })
#
# set_theme(font = "Montserrat", continuous =  "inferno")
# thm <- ggplot2::theme_get()
# test_that("inferno works", {
#   plot <- ggplot(df_c, aes(x, y, fill = z)) +
#     geom_tile() +
#     thm
#
#   vdiffr::expect_doppelganger("ms_inferno", plot)
# })
#
# set_theme(font = "Montserrat", continuous =  "plasma")
# thm <- ggplot2::theme_get()
# test_that("plasma works", {
#   plot <- ggplot(df_c, aes(x, y, fill = z)) +
#     geom_tile() +
#     thm
#
#   vdiffr::expect_doppelganger("ms_plasma", plot)
# })
#
# set_theme(font = "Montserrat", continuous =  "viridis")
# thm <- ggplot2::theme_get()
# test_that("viridis works", {
#   plot <- ggplot(df_c, aes(x, y, fill = z)) +
#     geom_tile() +
#     thm
#
#   vdiffr::expect_doppelganger("ms_viridis", plot)
# })
#
# set_theme(font = "Montserrat", continuous =  "cividis")
# thm <- ggplot2::theme_get()
# test_that("cividis works", {
#   plot <- ggplot(df_c, aes(x, y, fill = z)) +
#     geom_tile() +
#     thm
#
#   vdiffr::expect_doppelganger("ms_cividis", plot)
# })
#
# set_theme(font = "Montserrat", continuous = "ggplot2")
# thm <- ggplot2::theme_get()
# test_that("ggplot2 works", {
#   plot <- ggplot(df_c, aes(x, y, fill = z)) +
#     geom_tile() +
#     thm
#
#   vdiffr::expect_doppelganger("ms_ggplot2_c", plot)
# })
