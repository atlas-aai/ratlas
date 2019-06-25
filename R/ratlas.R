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
#' @import ggplot2 scales
#' @importFrom rlang .data :=
#' @importFrom xfun read_utf8 write_utf8
NULL

## Make R CMD Check go away
if (getRversion() >= "2.15.1") utils::globalVariables(c("."))
