test_that("orientation works correctly", {
  # work in a temp directory
  fig_dir <- withr::local_tempdir()

  # create plot
  plot <- ggplot(penguins, aes(bill_len, flipper_len)) +
    geom_point(na.rm = TRUE)

  # save plot
  ggsave2(plot, filename = "horz.png", path = fig_dir, dir = "h")
  ggsave2(plot, filename = "vert.pdf", path = fig_dir, dir = "v",
          embed_fonts = TRUE)
  ggsave2(plot, filename = "equl.png", path = fig_dir, width = 6, height = 6)

  expect_true(file.exists(file.path(fig_dir, "horz.png")))
  expect_true(file.exists(file.path(fig_dir, "vert.pdf")))
  expect_true(file.exists(file.path(fig_dir, "equl.png")))

  horz <- magick::image_info(magick::image_read(file.path(fig_dir, "horz.png")))
  vert <- magick::image_info(magick::image_read(file.path(fig_dir, "vert.pdf")))
  equl <- magick::image_info(magick::image_read(file.path(fig_dir, "equl.png")))

  expect_equal(horz$width / horz$height, 1.618, tolerance = 0.001)
  expect_equal(vert$width / vert$height, 0.618, tolerance = 0.001)
  expect_equal(equl$width / equl$height, 1.000, tolerance = 0.001)
})
