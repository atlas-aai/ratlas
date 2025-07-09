#' Check kable output type
#'
#' @param output The type of output. Should be one of "latex" or "html". An
#'   error is return if another `output` is provided, or if `output` is not
#'   specified.
#'
#' @noRd
check_output <- function(output) {
  if (!is.null(output)) {
    output <- rlang::arg_match(output, values = c("latex", "html"))
  } else {
    output <- getOption("knitr.table.format", default = "error")
    if (output == "error") {
      msg <- cli::format_message(
        glue::glue(
          "{{.arg output}} must be specified or defined globally with",
          "{{.run options(knitr.table.format = 'latex')}} or ",
          "{{.run options(knitr.table.format = 'html')}}",
          .sep = " "
        )
      )
      cli::cli_abort(message = msg)
    } else {
      return(output)
    }
  }
}
