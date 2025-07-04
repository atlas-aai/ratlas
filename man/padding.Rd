% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/table-format.R
\name{padding}
\alias{padding}
\alias{pad_counts}
\alias{pad_prop}
\alias{pad_corr}
\alias{pad_decimal}
\title{Table Padding}
\usage{
pad_counts(x, digits = 0L)

pad_prop(x, digits, fmt_small = TRUE, keep_zero = FALSE, output = NULL)

pad_corr(x, digits, output = NULL)

pad_decimal(
  x,
  digits,
  fmt_small = FALSE,
  max_value = NULL,
  keep_zero = FALSE,
  output = NULL
)
}
\arguments{
\item{x}{Number or number string to be formatted}

\item{digits}{Number of decimal places to retain}

\item{fmt_small}{Indicator for replacing zero with \code{<} (e.g., \code{.000} becomes
\verb{< .001}). Default is \code{TRUE}.}

\item{keep_zero}{If \code{fmt_small} is \code{TRUE}, whether to preserve true 0s (e.g.,
\code{0.0000001} becomes \verb{<.001}, but \code{0.0000000} stays \code{.000}).}

\item{output}{The output type for the rendered document. One of \code{"latex"} or
\code{"html"}.}

\item{max_value}{If \code{fmt_small} is \code{TRUE} and a \verb{max_value is supplied},
any value greater than the \code{max_value} is replaced with \code{>}
(e.g., if \code{max_value} = 50, then \code{60} becomes \verb{>49.9}). The number of digits
depends on \code{digits}.}
}
\value{
A character vector of the same length as \code{x}.
}
\description{
A family of functions for formatting numbers and then padding with spaces so
that table columns can be both centered and decimal aligned.
}
\details{
\code{pad_counts} should be used to pad integer numbers. This wraps
\code{\link[base:format]{base::format()}} to add a comma separator.

\code{pad_prop} should be used to pad decimal numbers between [0,1]. This wraps
\code{\link[=fmt_prop]{fmt_prop()}} to round to a specified number of \code{digits} and optionally
remove the leading zero.

\code{pad_corr} should be used to pad decimal numbers between [-1,1]. This wraps
\code{\link[=fmt_corr]{fmt_corr()}}, and is similar to \code{pad_prop}, but accounts for negative numbers
when adding padding.

\code{pad_decimal} should be used to pad decimal number that are not bounded. This
wraps \code{\link[=fmt_digits]{fmt_digits()}} to round to a specified number of decimal places.
}
\examples{
pad_counts(sample(1:1000, size = 20))

pad_prop(c(0.001, runif(5)), digits = 2)

pad_corr(runif(10, -1, 1), digits = 2)

pad_decimal(runif(10, 1, 100), digits = 1)
}
\seealso{
Other formatters: 
\code{\link{fmt_table}()},
\code{\link{formatting}}
}
\concept{formatters}
