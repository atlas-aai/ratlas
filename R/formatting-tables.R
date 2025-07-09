#' Set default kable output type
#'
#' Called from [.onLoad()] unless the user has set a global option of
#' `options(ratlas.auto_format = FALSE)`.
#'
#' @returns None. Called for side effects.
#' @noRd
auto_set_format <- function() {
  if (knitr::is_latex_output()) {
    options(knitr.table.format = "latex")
  } else {
    options(knitr.table.format = "html")
  }
}

#' Wrapper function of kableExtra::kbl
#'
#' Wrapper functions around {kableExtra} to apply some reasonable defaults to a
#' kable table. [fmt_kbl_header()] should be called after any call to
#' [kableExtra::column_spec()].
#'
#' @inheritParams kableExtra::kbl
#' @inheritParams kableExtra::kable_styling
#' @inheritParams kableExtra::row_spec
#' @param ...
#'   * For [fmt_kbl()], additional parameters passed to [kableExtra::kbl()].
#'   * For [fmt_kbl_header()], additional arguments passed to
#'     [kableExtra::row_spec()].
#'
#' @return A kable object.
#' @rdname kbl-format
#' @export
#'
#' @examples
#' fmt_kbl(mtcars[, 1:3], align = c("r", "c", "r"),
#'         col.names = c("Column 1", "Column 2", "Column 3"),
#'         caption = "Example Table Title")
#'
#' fmt_kbl(mtcars[, 1:3], align = c("r", "c", "r"),
#'         col.names = c("Column 1", "Column 2", "Column 3"),
#'         caption = "Example Table Title") |>
#'   fmt_kbl_header()
fmt_kbl <- function(x, booktabs = TRUE, linesep = "", centering = FALSE,
                    escape = FALSE, position = "left",
                    latex_options = "HOLD_position", ...) {
  x |>
    dplyr::mutate(dplyr::across(dplyr::everything(),
                                \(x) stringr::str_replace_all(x, "<", "<")),
                  dplyr::across(dplyr::everything(),
                                \(x) stringr::str_replace_all(x, ">", ">"))) |>
    kableExtra::kbl(booktabs = booktabs, linesep = linesep,
                    centering = centering, escape = escape, ...) |>
    kableExtra::kable_styling(position = position,
                              latex_options = latex_options) |>
    kableExtra::kable_classic(position = position)
}

#' @rdname kbl-format
#' @export
fmt_kbl_header <- function(kable_input, row = 0, align = "c",
                           extra_css = "border-bottom: 0.16em solid #111111",
                           ...) {
  kableExtra::row_spec(kable_input = kable_input, row = row, align = align,
                       extra_css = extra_css, ...)
}
