`%n%` <- function(x, y) {
  if (is.null(x)) {
    y
  } else {
    x
  }
}

is_tikz_dev <- function(options) {
  "tikz" %in% options$dev && !options$external
}

create_label <- function(..., latex = FALSE) {
  if (isTRUE(knitr::opts_knit$get("bookdown.internal.label"))) {
    lab1 <- "(\\#"; lab2 <- ")"
  } else if (latex) {
    lab1 <- "\\label{"; lab2 <- "}"
  } else {
    return("")
  }
  paste0(lab1, ..., lab2)
}

pandoc_to <- function(x) {
  fmt <- knitr::opts_knit$get("rmarkdown.pandoc.to")
  if (missing(x)) fmt else !is.null(fmt) && (fmt %in% x)
}
