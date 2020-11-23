test_that("apa7 fig hook works", {
  # nolint start
  opt <- techreport_pdf()$knitr$opts_chunk
  opt$fig.num <- 3
  opt$fig.cap <- "A Caption"
  opt$fig.scap <- "A Short Caption"
  opt$fig.env <- "figure"
  opt$fig.note <- "A note"
  opt$fig.subcap <- ""
  opt$fig.ncol <- 2

  x <- c("figures/fig-1.png", "figures/fig-2.png", "figures/fig-3.png")

  opt$fig.cur <- 1
  chunk1 <- hook_tex_plot_rat(x[1], opt)

  opt$fig.cur <- 2
  chunk2 <- hook_tex_plot_rat(x[2], opt)

  opt$fig.cur <- 3
  chunk3 <- hook_tex_plot_rat(x[3], opt)

  expect_equal(chunk1, "\\begin{figure}[H]\n\\caption[A Short Caption]{A Caption}\\label{}\n\n\n{\\centering \\subfloat[\\label{1}]{\\includegraphics[width=100%,]{figures/fig-1} }")
  expect_equal(chunk2, "\\subfloat[\\label{2}]{\\includegraphics[width=100%,]{figures/fig-2} }\\newline")
  expect_equal(chunk3, "\\subfloat[\\label{3}]{\\includegraphics[width=100%,]{figures/fig-3} }\n\n}\n\nA note\n\\end{figure}\n")
  # nolint end
})

test_that("null check works", {
  expect_equal(NULL %n% 2, 2)
  expect_equal(NULL %n% 3L, 3L)
  expect_equal(NULL %n% "a", "a")
  expect_equal(NULL %n% TRUE, TRUE)
  expect_equal(NULL %n% NA, NA)

  expect_equal(2 %n% NULL, 2)
  expect_equal(3L %n% NULL, 3L)
  expect_equal("a" %n% NULL, "a")
  expect_equal(TRUE %n% NULL, TRUE)
  expect_equal(NA %n% NULL, NA)

  expect_equal(2 %n% "a", 2)
  expect_equal(3L %n% TRUE, 3L)
  expect_equal("a" %n% 3L, "a")
  expect_equal(TRUE %n% FALSE, TRUE)
  expect_equal(NA %n% "b", NA)
})
