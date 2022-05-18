#' Wrapper function of kableExtra::kbl
#'
#' Create a kable table with some reasonable ATLAS defaults.
#'
#' @inheritParams kableExtra::kbl
#' @inheritParams kableExtra::kable_styling
#' @param ... Additional parameters passed to [kableExtra::kbl()].
#'
#' @return A kable object.
#' @export
fmt_kbl <- function(x, booktabs = TRUE, linesep = "", escape = FALSE,
                    position = "left", latex_options = "HOLD_position",
                    ...) {
  kableExtra::kbl(x, booktabs = booktabs, escape = escape, ...) %>%
    kableExtra::kable_styling(position = position,
                              latex_options = latex_options) %>%
    kableExtra::kable_classic()
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
#' @export
fmt_kbl_header <- function(kable_input, row = 0, align = "c",
                           extra_css = "border-bottom: 0.16em solid #111111",
                           ...) {
  kableExtra::row_spec(kable_input = kable_input, row = row, align = align,
                       extra_css = extra_css, ...)
}
