hook_tex_plot_rat <- function(x, options) {
  # nolint start
  # This function produces the image inclusion code for LaTeX.
  # optionally wrapped in code that resizes it, aligns it, handles it
  # as a subfigure, and/or wraps it in a float. Here is a road map of
  # the intermediate variables this function fills in (or leaves empty,
  # as needed), and an impression of their (possible) contents.
  #
  #     fig1,                   # \begin{...}[...]
  #       align1,               #   {\centering
  #         sub1,               #     \subfloat[...]{
  #           resize1,          #       \resizebox{...}{...}{
  #             tikz code       #         '\\input{chunkname.tikz}'
  #             or animate code #         or '\\animategraphics[size]{1/interval}{chunkname}{1}{fig_num}'
  #             or plain code   #         or '\\includegraphics[size]{chunkname}'
  #           resize2,          #       }
  #         sub2,               #     }
  #       align2,               #   }
  #     fig2                    #   \caption[...]{...\label{...}}
  #                             # \end{...} % still fig2
  # nolint end

  rw <- options$resize.width
  rh <- options$resize.height
  resize1 <- resize2 <- ""
  if (!is.null(rw) || !is.null(rh)) {
    resize1 <- sprintf("\\resizebox{%s}{%s}{", rw %n% "!", rh %n% "!")
    resize2 <- "} "
  }

  tikz <- is_tikz_dev(options)

  a <- options$fig.align
  fig_cur <- options$fig.cur %n% 1L
  fig_num <- options$fig.num %n% 1L
  animate <- options$fig.show == "animate"
  fig_ncol <- options$fig.ncol %n% fig_num
  if (is.null(fig_sep <- options$fig.sep)) {
    fig_sep <- character(fig_num)
    if (fig_ncol < fig_num) {
      fig_sep[seq(fig_ncol, fig_num - 1L, fig_ncol)] <- "\\newline"
    }
  }
  sep_cur <- NULL

  # If this is a non-tikz animation, skip to the last fig.
  if (!tikz && animate && fig_cur < fig_num) return("")

  usesub <- length(subcap <- options$fig.subcap) && fig_num > 1
  # multiple plots: begin at 1, end at fig_num
  ai <- options$fig.show != "hold"

  # TRUE if this picture is standalone or first in set
  plot1 <- ai || fig_cur <= 1L
  # TRUE if this picture is standalone or last in set
  plot2 <- ai || fig_cur == fig_num

  # open align code if this picture is standalone/first in set
  align1 <- if (plot1)
    switch(a, left = "\n\n", center = "\n\n{\\centering ",
           right = "\n\n\\hfill{}", "\n")
  # close align code if this picture is standalone/last in set
  align2 <- if (plot2)
    switch(a, left = "\\hfill{}\n\n", center = "\n\n}\n\n", right = "\n\n", "")

  # figure environment: caption, short caption, label
  cap <- options$fig.cap
  scap <- options$fig.scap
  note <- ""
  fig1 <- fig2 <- ""
  mcap <- fig_num > 1L && options$fig.show == "asis" && !length(subcap)
  # initialize subfloat strings
  sub1 <- sub2 <- ""

  # Wrap in figure environment only if user specifies a caption
  if (length(cap) && !is.na(cap)) {
    lab <- paste0(options$fig.lp, options$label)
    # If pic is standalone/first in set: open figure environment
    if (plot1) {
      pos <- options$fig.pos
      if (pos != "" && !grepl("^[[{]", pos)) pos <- sprintf("[%s]", pos)
      if (is.null(scap) && !grepl("[{].*?[:.;].*?[}]", cap)) {
        scap <- strsplit(cap, "[:.;]( |\\\\|$)")[[1L]][1L]
      }
      scap <- if (is.null(scap) || is.na(scap)) "" else sprintf("[%s]", scap)
      cap <- if (cap == "") "" else sprintf(
        "\\caption%s{%s}%s\n", scap, cap,
        create_label(lab, if (mcap) fig_cur, latex = TRUE)
      )

      fig1 <- sprintf("\\begin{%s}%s\n%s", options$fig.env, pos, cap)
    }
    # Add subfloat code if needed
    if (usesub) {
      sub1 <- sprintf("\\subfloat[%s%s]{", subcap,
                      create_label(lab, fig_cur, latex = TRUE))
      sub2 <- "}"
      sep_cur <- fig_sep[fig_cur]; if (is.na(sep_cur)) sep_cur <- NULL
    }

    # If pic is standalone/last in set:
    # * place caption with label
    # * close figure environment
    if (plot2) {
      fig2 <- sprintf("\\end{%s}\n", options$fig.env)
      note <- sprintf("%s\n", options$fig.note)
    }
  } else if (pandoc_to(c("latex", "beamer"))) {
    # use alignment environments for R Markdown latex output
    # (\centering won't work)
    align_env <- switch(a, left = "flushleft", center = "center",
                        right = "flushright")
    align1 <- if (plot1) {
      if (a == "default") "\n" else sprintf("\n\n\\begin{%s}", align_env)
    }
    align2 <- if (plot2) {
      if (a == "default") "" else sprintf("\\end{%s}\n\n", align_env)
    }
  }

  ow <- options$out.width
  # maxwidth does not work with animations
  if (animate && identical(ow, "\\maxwidth")) ow <- NULL
  if (is.numeric(ow)) ow <- paste0(ow, "px")
  size <- paste(c(sprintf("width=%s", ow),
                  sprintf("height=%s", options$out.height),
                  options$out.extra), collapse = ",")

  paste0(
    fig1, align1, sub1, resize1,
    if (tikz) {
      sprintf("\\input{%s}", x)
    } else if (animate) {
      # \animategraphics{} should be inserted only *once*!
      aniopts <- options$aniopts
      aniopts <- if (is.na(aniopts)) NULL else gsub(";", ",", aniopts)
      size <- paste(c(size, sprintf("%s", aniopts)), collapse = ",")
      if (nzchar(size)) size <- sprintf("[%s]", size)
      sprintf("\\animategraphics%s{%s}{%s}{%s}{%s}", size, 1 / options$interval,
              sub(sprintf("%d$", fig_num), "", xfun::sans_ext(x)), 1L, fig_num)
    } else {
      if (nzchar(size)) size <- sprintf("[%s]", size)
      res <- sprintf(
        "\\includegraphics%s{%s} ", size,
        if (getOption("knitr.include_graphics.ext", FALSE)) {
          x
        } else {
          xfun::sans_ext(x)
        }
      )
      lnk <- options$fig.link
      if (is.null(lnk) || is.na(lnk)) {
        res
      } else {
        sprintf("\\href{%s}{%s}", lnk, res)
      }
    },
    resize2, sub2, sep_cur, align2, note, fig2
  )
}

hook_html_plot_rat <- function(x, options) {
  if (options$fig.show == 'animate') return(knitr::hook_plot_html(x, options))

  base <- knitr::opts_knit$get('base.url') %n% ''
  cap <- .img.cap(options)
  alt <- .img.cap(options, alt = TRUE)

  w <- options[['out.width']]; h <- options[['out.height']]
  s <- options$out.extra; a <- options$fig.align
  ai <- options$fig.show == 'asis'
  lnk <- options$fig.link
  pandoc_html <- cap != '' && knitr::is_html_output()
  in_bookdown <- isTRUE(knitr::opts_knit$get('bookdown.internal.label'))
  plot1 <- ai || options$fig.cur <= 1L
  plot2 <- ai || options$fig.cur == options$fig.num
  to <- pandoc_to(); from <- pandoc_from()
  if (is.null(w) && is.null(h) && is.null(s) && a == 'default' && !(pandoc_html && in_bookdown)) {
    # append <!-- --> to ![]() to prevent the figure environment in these cases
    nocap = cap == '' && !is.null(to) && !grepl('^markdown', to) &&
      (options$fig.num == 1 || ai) && !grepl('-implicit_figures', from)
    res = sprintf('![%s](%s%s)', cap, base, .upload.url(x))
    if (!is.null(lnk) && !is.na(lnk)) res = sprintf('[%s](%s)', res, lnk)
    res = paste0(res, if (nocap) '<!-- -->' else '', if (knitr::is_latex_output()) ' ' else '')
    return(res)
  }
  add_link = function(x) {
    if (is.null(lnk) || is.na(lnk)) return(x)
    sprintf('<a href="%s" target="_blank">%s</a>', lnk, x)
  }
  # use HTML syntax <img src=...>
  if (pandoc_html && !isTRUE(grepl('-implicit_figures', from))) {
    d1 = if (plot1) sprintf('<div class="figure"%s>\n', css_text_align(a))
    d2 = sprintf('<p class="caption">%s</p>', cap)
    note <- if (plot2) sprintf('<p class="fignote"><em>Note.</em> %s</p>', options$fig.note)
    img = sprintf(
      '<img src="%s" alt="%s" %s />',
      paste0(knitr::opts_knit$get('base.url'), .upload.url(x)), alt, .img.attr(w, h, s)
    )
    img = add_link(img)
    # whether to place figure caption at the top or bottom of a figure
    if (isTRUE(options$fig.topcaption)) {
      paste0(d1, if (ai || options$fig.cur <= 1) d2, img, "<br/>", note, if (plot2) '</div>')
    } else {
      paste0(d1, img, "<br/>", note, if (plot2) paste0('\n', d2, '\n</div>'))
    }
  } else add_link(.img.tag(
    .upload.url(x), w, h, alt,
    c(s, sprintf('style="%s"', css_align(a)))
  ))
}

