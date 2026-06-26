#' Dynamic Learning Maps naming shortcuts
#'
#' Commonly used names and labels for the Dynamic Learning
#' Maps\ifelse{html}{\out{<sup>&reg;</sup>}}{\eqn{^\circledR}}
#' (DLM\ifelse{html}{\out{<sup>&reg;</sup>}}{\eqn{^\circledR}}) assessments.
#'
#' @rdname dlmalias
#' @format `dlm_ll_info` is a data frame with 13 rows and 4 variables:
#' * `subject`: The subject area for the linkage level
#' * `linkage_level`: The linkage level name as it is stored in the database
#' * `name`: The official linkage level name (public facing)
#' * `value`: The value used for scoring (i.e., the linkage level order, within
#'   subject)
"dlm_ll_info"

#' @rdname dlmalias
#' @format `dlm_labels` is a list with the following elements:
#' * `linkage_levels`: The linkage level names for ELA, mathematics, and
#'   science, in increasing complexity.
#' * `grades`: The possible grade levels, grade bands, and end-of-year courses,
#'   in increasing order.
#' * `complexity bands`: The four complexity band names for ELA, mathematics,
#'   science, writing, and expressive communication, in increasing order.
#' * `performance_levels`: The common performance level names (e.g.,
#'   "Approaching"), in increasing order.
#' * `performance_levels_full`: The official performance level names (e.g.,
#'   "Approaching the Target"), in increasing order.
"dlm_labels"
