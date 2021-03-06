% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/format-text.R
\name{fmt_italic}
\alias{fmt_italic}
\title{Format a String with Italics for HTML or Latex Output}
\usage{
fmt_italic(string, indicator = "*", html = TRUE)
}
\arguments{
\item{string}{The character vector to add italics to.}

\item{indicator}{The indicator for which words should be italicized}

\item{html}{Logical for whether the output should be HTML. If \code{FALSE}, Latex
output is provided.}
}
\value{
A character vector
}
\description{
Format a String with Italics for HTML or Latex Output
}
\examples{
fmt_italic("Make *this* italic.", html = TRUE)
fmt_italic("Make *this* italic.", html = FALSE)
}
