context("test-stat-bin")
library(ggplot2)

test_that("bin_breaks_width errors", {
  expect_error(bin_breaks_width(x_range = 1), "two elements")
  expect_error(bin_breaks_width(x_range = c(1, 2), width = "a"),
               "numeric scalar")
  expect_error(bin_breaks_width(x_range = c(1, 2), width = -2),
               "be positive")
  expect_error(bin_breaks_width(x_range = c(1, 2), width = 3,
                                boundary = 0, center = 1.5),
               "Only one of")
})

test_that("bin_breaks_bins errors", {
  expect_error(bin_breaks_bins(x_range = 1), "two elements")
  expect_error(bin_breaks_bins(x_range = c(1, 2), bins = 0), "at least one")
})

test_that("trimmed histrogram works", {
  testthat::skip_on_cran()

  local_theme(font = "Arial Narrow", discrete = "ggplot2",
              continuous = "ggplot2")
  thm <- theme_get()

  set.seed(9416)
  data <- data.frame(key = rep(c("a", "b", "c"), each = 1000),
                     value = c(rchisq(1000, df = 3),
                               b = rchisq(1000, df = 1),
                               c = rchisq(1000, df = 20)))

  plot1 <- ggplot(data, aes(x = value)) +
    geom_histogram(binwidth = 1, stat = StatBin2) +
    facet_wrap(~ key, ncol = 1) +
    thm

  plot2 <- ggplot(data, aes(x = value)) +
    geom_histogram(binwidth = 1, color = "red", stat = StatBin2,
                   boundary = 0) +
    facet_wrap(~ key, ncol = 1) +
    thm

  plot3 <- ggplot(data, aes(x = value)) +
    geom_histogram(binwidth = 1, color = "red", stat = StatBin2,
                   center = 0) +
    facet_wrap(~ key, ncol = 1) +
    thm

  plot4 <- ggplot(data, aes(x = value)) +
    geom_histogram(binwidth = 1e-6, color = "red", stat = StatBin2) +
    facet_wrap(~ key, ncol = 1) +
    thm

  plot5 <- ggplot(data, aes(x = value)) +
    geom_histogram(bins = 30, color = "red", stat = StatBin2,
                   boundary = 0) +
    facet_wrap(~ key, ncol = 1) +
    thm

  plot6 <- ggplot(data, aes(x = value)) +
    geom_histogram(bins = 1, color = "red", stat = StatBin2,
                   boundary = 0) +
    facet_wrap(~ key, ncol = 1) +
    thm

  vdiffr::expect_doppelganger("no_color_hist", plot1)
  vdiffr::expect_doppelganger("trimmed_hist_bound0", plot2)
  vdiffr::expect_doppelganger("trimmed_hist_center0", plot3)
  expect_warning(
    expect_warning(
      expect_warning(ggplot_build(plot4), "bins must be less than 1,000,000"),
      "bins must be less than 1,000,000"),
    "bins must be less than 1,000,000")
  vdiffr::expect_doppelganger("bins30_bound0", plot5)
  vdiffr::expect_doppelganger("one_bin", plot6)
})
