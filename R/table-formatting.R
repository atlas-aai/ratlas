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
#' Create a kable table with some reasonable ATLAS defaults.
#'
#' @inheritParams kableExtra::kbl
#' @inheritParams kableExtra::kable_styling
#' @param ... Additional parameters passed to [kableExtra::kbl()].
#'
#' @return A kable object.
#' @examples
#' fmt_kbl(mtcars[, 1:3], align = c("r", "c", "r"),
#'   col.names = c("Column 1", "Column 2", "Column 3"),
#'   caption = "Example Table Title")
#'
#' @export
fmt_kbl <- function(x, booktabs = TRUE, linesep = "", centering = FALSE,
                    escape = FALSE, position = "left",
                    latex_options = "HOLD_position", ...) {
  kableExtra::kbl(x, booktabs = booktabs, linesep = linesep,
                  centering = centering, escape = escape, ...) %>%
    kableExtra::kable_styling(position = position,
                              latex_options = latex_options) %>%
    kableExtra::kable_classic(position = position)
}

#' Wrapper function of kableExtra::row_spec
#'
#' Apply some default formatting to the header row of a kable table. Should be
#' called after any calls to [kableExtra::column_spec()].
#'
#' @inheritParams kableExtra::row_spec
#' @param ... Additional arguments passed to [kableExtra::row_spec()]
#'
#' @return A kable object.
#' @examples
#' fmt_kbl(mtcars[, 1:3], align = c("r", "c", "r"),
#'     col.names = c("Column 1", "Column 2", "Column 3"),
#'     caption = "Example Table Title") %>%
#'   kableExtra::column_spec(1, width = "20em") %>%
#'   fmt_kbl_header()
#' @export
fmt_kbl_header <- function(kable_input, row = 0, align = "c",
                           extra_css = "border-bottom: 0.16em solid #111111",
                           ...) {
  kableExtra::row_spec(kable_input = kable_input, row = row, align = align,
                       extra_css = extra_css, ...)
}
