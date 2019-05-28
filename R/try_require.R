try_require <- function(package) {
  package <- ifelse(!is.character(substitute(package)),
                    as.character(substitute(package)), package)
  available <- suppressMessages(
    suppressWarnings(
      sapply(package, require, quietly = TRUE,
             character.only = TRUE, warn.conflicts = FALSE)
    ))
  missing <- package[!available]

  if (length(missing) > 0L)
    stop(paste(package, collapse = ", "), " package not found.")
}
