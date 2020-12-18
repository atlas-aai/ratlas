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

usethis::use_data(dlm_ll_info, overwrite = TRUE)
