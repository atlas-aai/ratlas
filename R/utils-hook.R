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

is_blank <- function(x) {
  if (length(x)) all(grepl("^\\s*$", x)) else TRUE
}

escape_html <- function(x) {
  x <- gsub("&", "&amp;", x)
  x <- gsub("<", "&lt;", x)
  x <- gsub(">", "&gt;", x)
  x <- gsub("\"", "&quot;", x)
  x
}

pandoc_to <- function(x) {
  fmt <- knitr::opts_knit$get("rmarkdown.pandoc.to")
  if (missing(x)) fmt else !is.null(fmt) && (fmt %in% x)
}
pandoc_from <- function() {
  knitr::opts_knit$get("rmarkdown.pandoc.from") %n% "markdown"
}

img_cap <- function(options, alt = FALSE) {
  cap <- options$fig.cap %n% {
    if (is.null(pandoc_to())) sprintf("plot of chunk %s", options$label) else ""
  }
  if (length(cap) == 0) cap <- ""
  if (is_blank(cap)) return(cap)
  if (alt) return(escape_html(cap))
  paste0("<strong>", create_label(
    options$fig.lp, options$label,
    if (options$fig.num > 1L && options$fig.show == "asis") c("-",
                                                              options$fig.cur)
  ), "</strong><em> ", cap, "</em>")
}
upload_url <- function(x) {
  knitr::opts_knit$get("upload.fun")(x)
}
img_attr <- function(w, h, extra) {
  paste(c(sprintf('width="%s"', w), sprintf('height="%s"', h), extra),
        collapse = " ")
}
img_tag <- function(src, w, h, caption, extra) {
  caption <- if (length(caption) == 1 && caption != "") {
    paste0('title="', caption, '" alt="', caption, '" ')
  }
  tag <- if (grepl("[.]pdf$", src, ignore.case = TRUE)) {
    extra <- c(extra, 'type="application/pdf"')
    "embed"
  } else "img"
  paste0(
    "<", tag, ' src="', knitr::opts_knit$get("base.url"), src, '" ', caption,
    img_attr(w, h, extra), " />"
  )
}

css_text_align <- function(align) {
  if (align == "default") "" else sprintf(' style="text-align: %s"', align)
}
css_align <- function(align) {
  sprintf("display: block; margin: %s;", switch(
    align, left = "auto auto auto 0", center = "auto",
    right = "auto 0 auto auto"
  ))
}
