#' ratlas:
#'
#' The ratlas package serves three main purposes:
#'
#' - Project templates for topic guides and technical reports
#' - Functions for formatting
#' - Consistent ggplot2 themes
#'
#' @docType package
#' @name ratlas-package
#' @aliases ratlas
#' @importFrom rlang .data
NULL

## Make R CMD Check go away
if (getRversion() >= "2.15.1") utils::globalVariables(c("."))
