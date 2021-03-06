library(ggplot2)

test_that("orientation works correctly", {
  df <- data.frame(x = 1:3, y = 1:3, z = c("a", "b", "a"), a = 1)

  plot <- ggplot(df, aes(x, y, colour = z)) +
    geom_point() +
    facet_wrap(~ a) +
    scale_color_atlas() +
    theme_atlas()

  # work in a temp directory
  dir <- create_local_rmd_dir(dir = fs::file_temp(pattern = "plotorient"))

  ggsave2(plot, filename = "horz.png", dir = "h")
  ggsave2(plot, filename = "vert.png", dir = "v")
  ggsave2(plot, filename = "equl.png", width = 6, height = 6)

  expect_true(file.exists("horz.png"))
  expect_true(file.exists("vert.png"))
  expect_true(file.exists("equl.png"))

  horz <- magick::image_info(magick::image_read("horz.png"))
  vert <- magick::image_info(magick::image_read("vert.png"))
  equl <- magick::image_info(magick::image_read("equl.png"))

  expect_equal(horz$width / horz$height, 1.618, tolerance = 0.001)
  expect_equal(vert$width / vert$height, 0.618, tolerance = 0.001)
  expect_equal(equl$width / equl$height, 1.000, tolerance = 0.001)
})
