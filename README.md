
<!-- README.md is generated from README.Rmd. Please edit that file -->

# ratlas

[![Travis build
status](https://travis-ci.org/atlas-aai/ratlas.svg?branch=master)](https://travis-ci.org/atlas-aai/ratlas)

The goal of ratlas is to provide uniform [R
Markdown](https://bookdown.org/yihui/rmarkdown/) templates for creating
topic guides and technical reports, helper functions formating text in
documents, and providing consistent themes for
[**ggplot2**](https://ggplot2.tidyverse.org) graphics.

## Installation

You can install the latest version with:

``` r
remotes::install_github("atlas-aai/ratlas")
```

## Test Coverage

``` r
devtools::test()
#> Loading ratlas
#> Testing ratlas
#> ✔ | OK F W S | Context
#> 
⠏ |  0       | lints
⠋ |  0 1     | lints
✖ |  0 1     | lints [1.6 s]
#> ─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
#> test-lintr.R:5: failure: Package style
#> Not lint free
#> R/cap_words.R:12:32: style: Commas should always have a space after.
#>   paste(toupper(substring(s, 1,1)), substring(s, 2),
#>                                ^
#> R/cap_words.R:13:12: style: Put spaces around all infix operators.
#>         sep="", collapse=" ")
#>           ~^~
#> R/cap_words.R:13:25: style: Put spaces around all infix operators.
#>         sep="", collapse=" ")
#>                        ~^~
#> R/format_cap.R:14:34: style: Commas should always have a space after.
#>     paste(toupper(substring(s, 1,1)), substring(s, 2),
#>                                  ^
#> R/format_cap.R:15:14: style: Put spaces around all infix operators.
#>           sep="", collapse=" ")
#>             ~^~
#> R/format_cap.R:15:27: style: Put spaces around all infix operators.
#>           sep="", collapse=" ")
#>                          ~^~
#> R/topic_guide.R:14:1: style: lines should not be more than 80 characters.
#>   base <- bookdown::word_document2(reference_docx = "style-reference1.docx", ...)
#> ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#> ─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
#> 
⠏ |  0       | test-rat_apa_decimal
⠋ |  1       | test-rat_apa_decimal
⠙ |  2       | test-rat_apa_decimal
⠹ |  3       | test-rat_apa_decimal
⠸ |  4       | test-rat_apa_decimal
⠼ |  5       | test-rat_apa_decimal
⠴ |  6       | test-rat_apa_decimal
⠦ |  7       | test-rat_apa_decimal
⠧ |  8       | test-rat_apa_decimal
⠇ |  9       | test-rat_apa_decimal
⠏ | 10       | test-rat_apa_decimal
⠋ | 11       | test-rat_apa_decimal
⠙ | 12       | test-rat_apa_decimal
⠹ | 13       | test-rat_apa_decimal
⠸ | 14       | test-rat_apa_decimal
⠼ | 15       | test-rat_apa_decimal
✔ | 15       | test-rat_apa_decimal
#> 
#> ══ Results ══════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════
#> Duration: 1.6 s
#> 
#> OK:       15
#> Failed:   1
#> Warnings: 0
#> Skipped:  0


covr::package_coverage()
#> ratlas Coverage: 22.73%
#> R/cap_words.R: 0.00%
#> R/connect_vect.R: 0.00%
#> R/format_cap.R: 0.00%
#> R/num2word.R: 0.00%
#> R/order_num.R: 0.00%
#> R/topic_guide.R: 0.00%
#> R/rat_apa_decimal.R: 100.00%
```
