context("test-data_frame_manipulation")

test_that("only_if works", {
  d <- tibble::as_tibble(mtcars)

  d_true <- d %>% dplyr::filter(.data$mpg > 25)

  expect_equal(d %>% only_if(TRUE)(dplyr::filter)(.data$mpg > 25), d_true)
  expect_equal(d %>% only_if(FALSE)(dplyr::filter)(.data$mpg > 25), d)
})

test_that("append_summary works", {
  set.seed(9416)
  df <- tibble::tibble(group = letters[1:5],
               x = sample(1:10, 5, TRUE),
               y = sample(1:10, 5, TRUE),
               z = sample(1:10, 5, TRUE))

  row_sums <- df %>%
    dplyr::select(-.data$group) %>%
    dplyr::summarize_all(sum)
  row_medians <- df %>%
    dplyr::select(-.data$group) %>%
    dplyr::summarize_all(median)
  col_sums <- df %>%
    dplyr::select(-.data$group) %>%
    tibble::rowid_to_column(var = "rowid") %>%
    tidyr::pivot_longer(-.data$rowid, names_to = "col",  values_to = "val") %>%
    dplyr::group_by(.data$rowid) %>%
    dplyr::summarize(sum = sum(val)) %>%
    dplyr::select(.data$sum)
  col_medians <- df %>%
    dplyr::select(-.data$group) %>%
    tibble::rowid_to_column(var = "rowid") %>%
    tidyr::pivot_longer(-.data$rowid, names_to = "col",  values_to = "val") %>%
    dplyr::group_by(.data$rowid) %>%
    dplyr::summarize(median = stats::median(val)) %>%
    dplyr::select(.data$median)

  expect_equal(append_summary(df, row = FALSE, col = FALSE), df)
  expect_equal(append_summary(df, row = TRUE, col = FALSE),
               dplyr::bind_rows(df, row_sums))
  expect_equal(append_summary(df, row = FALSE),
               dplyr::bind_cols(df, col_sums))
  expect_equal(append_summary(df, col = FALSE, .f = stats::median),
               dplyr::bind_rows(df, row_medians))
  expect_equal(append_summary(df),
               dplyr::bind_cols(df, col_sums) %>%
                 dplyr::bind_rows(
                   dplyr::mutate(row_sums, sum = sum(col_sums$sum))
                 ))
})
