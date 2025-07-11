test_that("x/y scales work", {
  dat <- data.frame(count = seq(0, 3000, length.out = 10),
                    percent = seq(0, 1, length.out = 10))

  p1 <- ggplot(dat, aes(x = count, y = percent)) +
    geom_point() +
    scale_x_comma(breaks = seq(0, 3000, 500)) +
    scale_y_percent()

  p2 <- ggplot(dat, aes(x = percent, y = count)) +
    geom_point() +
    scale_x_percent() +
    scale_y_comma()

  vdiffr::expect_doppelganger("comma_percent", p1)
  vdiffr::expect_doppelganger("percent_comma", p2)
})
