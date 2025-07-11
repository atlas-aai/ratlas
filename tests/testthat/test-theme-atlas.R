test_that("theme_atlas is a theme", {
  expect_s3_class(theme_atlas(), "theme")
})

test_that("theme_atlas default font settings are correct", {
  expect_equal(theme_atlas()$text$family, "Archivo Narrow")
  expect_equal(theme_atlas()$text$colour, "black")
  expect_equal(theme_atlas()$text$size, 11.5)
  expect_equal(theme_atlas()$plot.title$size, 18)
  expect_equal(theme_atlas()$plot.subtitle$size, 13)
  expect_equal(theme_atlas()$axis.text$size, 10)
  expect_equal(theme_atlas()$plot.margin, margin(3, 10, 0, 10))
})

test_that("setting theme works", {
  # errors for unknown color scales --------------------------------------------
  err <- rlang::catch_cnd(set_theme_ratlas(discrete = "taylorswift"))
  expect_s3_class(err, "rlang_error")
  expect_match(err$message, "one of \"okabeito\" or \"ggplot2\"")

  err <- rlang::catch_cnd(set_theme_ratlas(continuous = "taylorswift"))
  expect_s3_class(err, "rlang_error")
  expect_match(err$message, "must be one of")

  # default plots --------------------------------------------------------------
  d_plot <- ggplot(penguins, aes(x = bill_len, y = flipper_len)) +
    geom_point(aes(color = species), na.rm = TRUE)
  vdiffr::expect_doppelganger("discrete-default", d_plot)

  c_plot <- ggplot(ggplot2::faithfuld, aes(waiting, eruptions)) +
    geom_tile(aes(fill = density))
  vdiffr::expect_doppelganger("continuous-default", c_plot)

  # discrete plot --------------------------------------------------------------
  local_theme()
  vdiffr::expect_doppelganger("discrete-atlas-default", d_plot)

  local_theme(font = "sans", discrete = "ggplot2")
  vdiffr::expect_doppelganger("discrete-atlas-sans-ggplot2", d_plot)

  local_theme(font = "serif", discrete = "okabeito")
  vdiffr::expect_doppelganger("discrete-atlas-serif-okabito", d_plot)

  # continuous plot ------------------------------------------------------------
  local_theme()
  vdiffr::expect_doppelganger("continuous-atlas-default", c_plot)

  local_theme(continuous = "ggplot2")
  vdiffr::expect_doppelganger("continuous-atlas-sans-ggplot2", c_plot)

  local_theme(font = "mono", continuous = "viridis")
  vdiffr::expect_doppelganger("continuous-atlas-mono-viridis", c_plot)

  local_theme(font = "serif", continuous = "plasma")
  vdiffr::expect_doppelganger("continuous-atlas-serif-plasma", c_plot)
})
