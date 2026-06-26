test_that("auto_set_format() respects LaTeX vs HTML rendering state", {
  withr::local_options(knitr.table.format = NULL)

  # LaTeX context
  local_mocked_bindings(
    is_latex_output = function(...) TRUE,
    .package = "knitr"
  )
  auto_set_format()
  expect_equal(getOption("knitr.table.format"), "latex")

  # HTML / non-LaTeX context
  local_mocked_bindings(
    is_latex_output = function(...) FALSE,
    .package = "knitr"
  )
  auto_set_format()
  expect_equal(getOption("knitr.table.format"), "html")
})

test_that("table formatting works", {
  withr::local_options(list(knitr.table.format = "html"))
  html_tab <- fmt_kbl(
    mtcars[1:3, 1:3],
    align = c("r", "c", "r"),
    col.names = c("Column 1", "Column 2", "Column 3"),
    caption = "Example Table Title"
  )
  expect_snapshot(cat(html_tab))

  html_head <- fmt_kbl(
    mtcars[1:3, 1:3],
    align = c("r", "c", "r"),
    col.names = c("Column 1", "Column 2", "Column 3"),
    caption = "Example Table Title"
  ) |>
    fmt_kbl_header()
  expect_snapshot(cat(html_head))

  withr::local_options(list(knitr.table.format = "latex"))
  latex_tab <- fmt_kbl(
    mtcars[1:3, 1:3],
    align = c("r", "c", "r"),
    col.names = c("Column 1", "Column 2", "Column 3"),
    caption = "Example Table Title"
  )
  expect_snapshot(cat(latex_tab))

  latex_head <- fmt_kbl(
    mtcars[1:3, 1:3],
    align = c("r", "c", "r"),
    col.names = c("Column 1", "Column 2", "Column 3"),
    caption = "Example Table Title"
  ) |>
    fmt_kbl_header()
  expect_snapshot(cat(latex_head))
})
