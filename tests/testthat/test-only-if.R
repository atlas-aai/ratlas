test_that("only_if works", {
  d <- tibble::as_tibble(mtcars)

  d_true <- d |> dplyr::filter(mpg > 25)

  expect_equal(d |> only_if(TRUE)(dplyr::filter)(mpg > 25), d_true)
  expect_equal(d |> only_if(FALSE)(dplyr::filter)(mpg > 25), d)
})

