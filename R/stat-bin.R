#' Base ggproto classes for ratlas
#'
#' @seealso [ggproto]
#' @keywords internal
#' @name ratlas-ggproto
NULL


#' @rdname ratlas-ggproto
#' @format NULL
#' @usage NULL
#' @export
StatBin2 <- ggplot2::ggproto("StatBin2", ggplot2::Stat,
  setup_params = function(data, params) {
    params$flipped_aes <- ggplot2::has_flipped_aes(data, params, main_is_orthogonal = FALSE)

    has_x <- !(is.null(data$x) && is.null(params$x))
    has_y <- !(is.null(data$y) && is.null(params$y))
    if (!has_x && !has_y) {
      rlang::abort("stat_bin() requires an x or y aesthetic.")
    }
    if (has_x && has_y) {
      rlang::abort("stat_bin() can only have an x or y aesthetic.")
    }

    x <- flipped_names(params$flipped_aes)$x
    if (is.integer(data[[x]])) {
      rlang::abort(glue("StatBin requires a continuous {x} variable: the {x} variable is discrete.",
                 "Perhaps you want stat=\"count\"?"))
    }

    if (!is.null(params$drop)) {
      warn("`drop` is deprecated. Please use `pad` instead.")
      params$drop <- NULL
    }
    if (!is.null(params$origin)) {
      warn("`origin` is deprecated. Please use `boundary` instead.")
      params$boundary <- params$origin
      params$origin <- NULL
    }
    if (!is.null(params$right)) {
      warn("`right` is deprecated. Please use `closed` instead.")
      params$closed <- if (params$right) "right" else "left"
      params$right <- NULL
    }
    if (!is.null(params$width)) {
      rlang::abort("`width` is deprecated. Do you want `geom_bar()`?")
    }
    if (!is.null(params$boundary) && !is.null(params$center)) {
      rlang::abort("Only one of `boundary` and `center` may be specified.")
    }

    if (is.null(params$breaks) && is.null(params$binwidth) && is.null(params$bins)) {
      message_wrap("`stat_bin()` using `bins = 30`. Pick better value with `binwidth`.")
      params$bins <- 30
    }

    params
  },

  extra_params = c("na.rm", "orientation"),

  compute_group = function(data, scales, binwidth = NULL, bins = NULL,
                           center = NULL, boundary = NULL,
                           closed = c("right", "left"), pad = FALSE,
                           breaks = NULL, flipped_aes = FALSE,
                           # The following arguments are not used, but must
                           # be listed so parameters are computed correctly
                           origin = NULL, right = NULL, drop = NULL,
                           width = NULL) {
    x <- flipped_names(flipped_aes)$x
    if (!is.null(breaks)) {
      if (!scales[[x]]$is_discrete()) {
        breaks <- scales[[x]]$transform(breaks)
      }
      bins <- bin_breaks(breaks, closed)
    } else if (!is.null(binwidth)) {
      if (is.function(binwidth)) {
        binwidth <- binwidth(data[[x]])
      }
      bins <- bin_breaks_width(scales[[x]]$dimension(), binwidth,
                               center = center, boundary = boundary, closed = closed)
    } else {
      bins <- bin_breaks_bins(scales[[x]]$dimension(), bins, center = center,
                              boundary = boundary, closed = closed)
    }
    bins <- bin_vector(data[[x]], bins, weight = data$weight, pad = pad)
    bins <- bins[bins$x <= max(bins[bins$count > 0, "x"]) & bins$x >= min(bins[bins$count > 0, "x"]), ]
    bins$flipped_aes <- flipped_aes
    flip_data(bins, flipped_aes)
  },

  default_aes = ggplot2::aes(x = after_stat(count), y = after_stat(count), weight = 1),

  required_aes = "x|y"
)

bin_breaks <- function(breaks, closed = c("right", "left")) {
  bins(breaks, closed)
}

bin_breaks_width <- function(x_range, width = NULL, center = NULL,
                             boundary = NULL, closed = c("right", "left")) {
  if (length(x_range) != 2) rlang::abort("`x_range` must have two elements")

  # if (length(x_range) == 0) {
  #   return(bin_params(numeric()))
  # }
  if (!(is.numeric(width) && length(width) == 1)) rlang::abort("`width` must be a numeric scalar")
  if (width <= 0) {
    rlang::abort("`binwidth` must be positive")
  }

  if (!is.null(boundary) && !is.null(center)) {
    rlang::abort("Only one of 'boundary' and 'center' may be specified.")
  } else if (is.null(boundary)) {
    if (is.null(center)) {
      # If neither edge nor center given, compute both using tile layer's
      # algorithm. This puts min and max of data in outer half of their bins.
      boundary <- width / 2

    } else {
      # If center given but not boundary, compute boundary.
      boundary <- center - width / 2
    }
  }

  # Find the left side of left-most bin: inputs could be Dates or POSIXct, so
  # coerce to numeric first.
  x_range <- as.numeric(x_range)
  width <- as.numeric(width)
  boundary <- as.numeric(boundary)
  shift <- floor((x_range[1] - boundary) / width)
  origin <- boundary + shift * width

  # Small correction factor so that we don't get an extra bin when, for
  # example, origin = 0, max(x) = 20, width = 10.
  max_x <- x_range[2] + (1 - 1e-08) * width
  breaks <- seq(origin, max_x, width)

  if (length(breaks) == 1) {
    # In exceptionally rare cases, the above can fail and produce only a
    # single break (see issue #3606). We fix this by adding a second break.
    breaks <- c(breaks, breaks + width)
  } else if (length(breaks) > 1e6) {
    rlang::abort("The number of histogram bins must be less than 1,000,000.\nDid you make `binwidth` too small?")
  }

  bin_breaks(breaks, closed = closed)
}

bin_breaks_bins <- function(x_range, bins = 30, center = NULL,
                            boundary = NULL, closed = c("right", "left")) {
  if (length(x_range) != 2) rlang::abort("`x_range` must have two elements")

  bins <- as.integer(bins)
  if (bins < 1) {
    rlang::abort("Need at least one bin.")
  } else if (scales::zero_range(x_range)) {
    # 0.1 is the same width as the expansion `default_expansion()` gives for 0-width data
    width <- 0.1
  } else if (bins == 1) {
    width <- diff(x_range)
    boundary <- x_range[1]
  } else {
    width <- (x_range[2] - x_range[1]) / (bins - 1)
  }

  bin_breaks_width(x_range, width, boundary = boundary, center = center,
                   closed = closed)
}


# Compute bins ------------------------------------------------------------

bin_vector <- function(x, bins, weight = NULL, pad = FALSE) {
  if (!is_bins(bins)) rlang::abort("`bins` must be a ggplot2_bins object")

  if (all(is.na(x))) {
    return(bin_out(length(x), NA, NA, xmin = NA, xmax = NA))
  }

  if (is.null(weight)) {
    weight <- rep(1, length(x))
  } else {
    weight[is.na(weight)] <- 0
  }

  bin_idx <- cut(x, bins$fuzzy, right = bins$right_closed,
                 include.lowest = TRUE)
  bin_count <- as.numeric(tapply(weight, bin_idx, sum, na.rm = TRUE))
  bin_count[is.na(bin_count)] <- 0

  bin_x <- (bins$breaks[-length(bins$breaks)] + bins$breaks[-1]) / 2
  bin_widths <- diff(bins$breaks)

  # Pad row of 0s at start and end
  if (pad) {
    bin_count <- c(0, bin_count, 0)

    width1 <- bin_widths[1]
    widthn <- bin_widths[length(bin_widths)]

    bin_widths <- c(width1, bin_widths, widthn)
    bin_x <- c(bin_x[1] - width1, bin_x, bin_x[length(bin_x)] + widthn)
  }

  # Add row for missings
  if (any(is.na(bins))) {
    bin_count <- c(bin_count, sum(is.na(bins)))
    bin_widths <- c(bin_widths, NA)
    bin_x <- c(bin_x, NA)
  }

  bin_out(bin_count, bin_x, bin_widths)
}

bin_out <- function(count = integer(0), x = numeric(0), width = numeric(0),
                    xmin = x - width / 2, xmax = x + width / 2) {
  density <- count / width / sum(abs(count))

  new_data_frame(list(
    count = count,
    x = x,
    xmin = xmin,
    xmax = xmax,
    width = width,
    density = density,
    ncount = count / max(abs(count)),
    ndensity = density / max(abs(density))
  ), n = length(count))
}

bins <- function(breaks, closed = c("right", "left"),
                 fuzz = 1e-08 * stats::median(diff(breaks))) {
  if (!is.numeric(breaks)) rlang::abort("`breaks` must be a numeric vector")
  closed <- match.arg(closed)

  breaks <- sort(breaks)
  # Adapted base::hist - this protects from floating point rounding errors
  if (closed == "right") {
    fuzzes <- c(-fuzz, rep.int(fuzz, length(breaks) - 1))
  } else {
    fuzzes <- c(rep.int(-fuzz, length(breaks) - 1), fuzz)
  }

  structure(
    list(
      breaks = breaks,
      fuzzy = breaks + fuzzes,
      right_closed = closed == "right"
    ),
    class = "ggplot2_bins"
  )
}

is_bins <- function(x) inherits(x, "ggplot2_bins")

new_data_frame <- function(x = list(), n = NULL) {
  if (length(x) != 0 && is.null(names(x))) {
    rlang::abort("Elements must be named")
  }
  lengths <- vapply(x, length, integer(1))
  if (is.null(n)) {
    n <- if (length(x) == 0 || min(lengths) == 0) 0 else max(lengths)
  }
  for (i in seq_along(x)) {
    if (lengths[i] == n) next
    if (lengths[i] != 1) {
      rlang::abort("Elements must equal the number of rows or 1")
    }
    x[[i]] <- rep(x[[i]], n)
  }

  class(x) <- "data.frame"

  attr(x, "row.names") <- .set_row_names(n)
  x
}
