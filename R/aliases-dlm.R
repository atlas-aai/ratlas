#' DLM Aliases
#'
#' R variable aliases for commonly used vector and values.
#'
#' @details
#' `dlm_ll` contains all linkage level names for ELA, mathematics, and science.
#'
#' `dlm_grades` contains all DLM grade levels.
#'
#' `dlm_complexity` contains all complexity band names for ELA, mathematics,
#' science, writing, and communication.
#'
#' `dlm_performance` and `dlm_performance_full` contain the performance level
#' names for ELA, mathematics and science. `dlm_performance` uses the common
#' names (e.g., "Approaching"), whereas `dlm_performance_full` uses the official
#' names (e.g., "Approaching the Target").
#'
#' @name dlmalias

#' @rdname dlmalias
#' @export
dlm_ll <- c("Initial Precursor", "Initial", "Distal Precursor", "Precursor",
            "Proximal Precursor", "Target", "Successor")

#' @rdname dlmalias
#' @export
dlm_grades <- c(3:5, "3-5", 6:8, "6-8", 9:12, "9-10", "11-12", "9-12",
                "Biology")

#' @rdname dlmalias
#' @export
dlm_complexity <- c("Foundational", "Band 1", "Band 2", "Band 3")

#' @rdname dlmalias
#' @export
dlm_performance <- c("Emerging", "Approaching", "Target", "Advanced")

#' @rdname dlmalias
#' @export
dlm_performance_full <- c("Emerging", "Approaching the Target", "At Target",
                          "Advanced")
