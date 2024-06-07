#' ratlas:
#'
#' The ratlas package serves three main purposes:
#'
#' - Project templates for topic guides and technical reports
#' - Functions for formatting
#' - Consistent ggplot2 themes
#'
#' @name ratlas-package
"_PACKAGE"
#' @aliases ratlas
#' @import grDevices
#' @importFrom rlang .data :=
NULL

## Make R CMD Check go away
if (getRversion() >= "2.15.1") utils::globalVariables(c("."))
utils::globalVariables("where")
