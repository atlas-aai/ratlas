test_that("append_summary works", {
  set.seed(9416)
  df <- tibble::tibble(group = letters[1:5],
                       x = sample(1:10, 5, TRUE),
                       y = sample(1:10, 5, TRUE),
                       z = sample(1:10, 5, TRUE))

  row_sums <- df |>
    dplyr::select(-group) |>
    dplyr::summarize_all(sum)
  row_medians <- df |>
    dplyr::select(-group) |>
    dplyr::summarize_all(median)
  col_sums <- df |>
    dplyr::select(-group) |>
    tibble::rowid_to_column(var = "rowid") |>
    tidyr::gather(key = "col", value = "val", -rowid) |>
    dplyr::group_by(rowid) |>
    dplyr::summarize(sum = sum(val)) |>
    dplyr::select(sum)
  col_medians <- df |>
    dplyr::select(-group) |>
    tibble::rowid_to_column(var = "rowid") |>
    tidyr::gather(key = "col", value = "val", -rowid) |>
    dplyr::group_by(rowid) |>
    dplyr::summarize(median = stats::median(val)) |>
    dplyr::select(median)

  expect_equal(append_summary(df, x, y, z, row = FALSE, col = FALSE), df)
  expect_equal(append_summary(df, x, y, z, row = TRUE, col = FALSE),
               dplyr::bind_rows(df, row_sums))
  expect_equal(append_summary(df, x, y, z, row = FALSE, col = TRUE),
               dplyr::bind_cols(df, col_sums))
  expect_equal(append_summary(df, x, y, z, col = FALSE, .f = stats::median),
               dplyr::bind_rows(df, row_medians))
  expect_equal(append_summary(df, x, y, z),
               dplyr::bind_cols(df, col_sums) |>
                 dplyr::bind_rows(
                   dplyr::mutate(row_sums, sum = sum(col_sums$sum))
                 ))
})

test_that("table formatting works", {
  dat2 <- data.frame(state = state.name[1:11],
                     n = as.integer(seq(1L, 10L, length.out = 11)),
                     corr = seq(-.9, 0.9, length.out = 11),
                     prop = seq(0, 1, length.out = 11),
                     value = seq(10.4, 50.7, length.out = 11))

  dat3 <- data.frame(state = state.name[1:11],
                     n = as.integer(seq(1L, 600L, length.out = 11)),
                     corr = seq(-.9, 0.9, length.out = 11),
                     prop = seq(0, 1, length.out = 11),
                     value = seq(10.4, 50.7, length.out = 11))

  dat4 <- data.frame(state = state.name[1:11],
                     n = as.integer(seq(10L, 2000L, length.out = 11)),
                     corr = seq(-1, 1, length.out = 11),
                     prop = seq(0, 1, length.out = 11),
                     value = seq(10.4, 50.7, length.out = 11))

  dat5 <- data.frame(state = state.name[1:11],
                     n = as.integer(seq(10L, 20000L, length.out = 11)),
                     corr = seq(-.9, 0.9, length.out = 11),
                     prop = seq(0, 1, length.out = 11),
                     value = seq(10.4, 50.7, length.out = 11))

  dat6 <- data.frame(state = state.name[1:11],
                     n = as.integer(seq(1L, 200000L, length.out = 11)),
                     corr = seq(-.9, 0.9, length.out = 11),
                     prop = seq(0, 1, length.out = 11),
                     value = seq(10.4, 50.7, length.out = 11))

  dat7 <- data.frame(state = state.name[1:11],
                     n = as.integer(seq(1L, 2000000L, length.out = 11)),
                     corr = seq(-.9, 0.9, length.out = 11),
                     prop = seq(0, 1, length.out = 11),
                     value = seq(-30.5, 50.7, length.out = 11))

  expect_snapshot(fmt_table(dat2))
  expect_snapshot(fmt_table(dat3))
  expect_snapshot(fmt_table(dat4))
  expect_snapshot(fmt_table(dat5))
  expect_snapshot(fmt_table(dat6))
  expect_snapshot(fmt_table(dat7))

  expect_snapshot(fmt_table(dat4, fmt_small = FALSE))
  expect_snapshot(fmt_table(dat4, output = "latex", keep_zero = TRUE,
                            max_value = 50))
})

test_that("combine n and percent", {
  pcts <- data.frame(Program = LETTERS[1:10],
                     n = 1:10,
                     p = seq(0, 100, length.out = 10))

  expect_snapshot(
    pcts |>
      fmt_table(max_value = 100) |>
      combine_n_pct(n = n, pct = p, name = "States")
  )
})
