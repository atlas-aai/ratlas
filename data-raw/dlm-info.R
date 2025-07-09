dlm_ll <- c("Initial Precursor", "Initial", "Distal Precursor", "Precursor",
            "Proximal Precursor", "Target", "Successor")

dlm_grades <- c(3:5, "3-5", 6:8, "6-8", 9:12, "9-10", "11-12", "9-12",
                "Biology")

dlm_complexity <- c("Foundational", "Band 1", "Band 2", "Band 3")

dlm_performance <- c("Emerging", "Approaching", "Target", "Advanced")

dlm_performance_full <- c("Emerging", "Approaching the Target", "At Target",
                          "Advanced")

dlm_labels <- list(
  linkage_levels = dlm_ll,
  grades = dlm_grades,
  complexity_bands = dlm_complexity,
  performance_levels = dlm_performance,
  performance_levels_full = dlm_performance_full
)

dlm_ll_info <- tibble::tribble(
  ~subject,    ~linkage_level,                ~name, ~value,
  "ELA",  "Initial Precursor",  "Initial Precursor",     1L,
  "ELA",   "Distal Precursor",   "Distal Precursor",     2L,
  "ELA", "Proximal Precursor", "Proximal Precursor",     3L,
  "ELA",             "Target",             "Target",     4L,
  "ELA",          "Successor",          "Successor",     5L,
    "M",  "Initial Precursor",  "Initial Precursor",     1L,
    "M",   "Distal Precursor",   "Distal Precursor",     2L,
    "M", "Proximal Precursor", "Proximal Precursor",     3L,
    "M",             "Target",             "Target",     4L,
    "M",          "Successor",          "Successor",     5L,
  "Sci",  "Initial Precursor",            "Initial",     1L,
  "Sci", "Proximal Precursor",          "Precursor",     2L,
  "Sci",             "Target",             "Target",     3L
)

usethis::use_data(dlm_labels, dlm_ll_info, overwrite = TRUE)
