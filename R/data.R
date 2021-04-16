#' DLM Linkage Level Information
#'
#' A dataset contain information for how linkage levels are stored in the
#' database, their official names, and their values for scoring.
#'
#' @format A data frame with 13 rows and 4 variables:
#' * `subject`: The subject area for the linkage level
#' * `linkage_level`: The linkage level name as it is stored in the database
#' * `name`: The official linkage level name (public facing)
#' * `value`: The value used for scoring (i.e., the linkage level order, within
#'   subject)
"dlm_ll_info"
