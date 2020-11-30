abort_bad_argument <- function(arg, must, not = NULL) {
  msg <- glue::glue("`{arg}` must {must}")
  if (!is.null(not)) {
    msg <- glue::glue("{msg}; not {not}")
  }

  rlang::abort("error_bad_argument",
               message = msg,
               arg = arg,
               must = must,
               not = not)
}

check_output <- function(output) {
  if (!is.null(output)) {
    output <- match.arg(output, choices = c("latex", "html"))
  } else {
    output <- getOption("knitr.table.format", default = "error")
    if (output == "error") {
      msg <- glue::glue("`output` must be specified or defined",
                        " globally with ",
                        "`options(knitr.table.format = 'latex')`",
                        " or",
                        " `options(knitr.table.format = 'html')`.")
      msg <- message_wrap(msg)
      rlang::abort("error_bad_argument",
                   message = paste0(msg, collapse = "\n"),
                   arg = "output",
                   must = "be specified",
                   not = NULL)
    } else {
      return(output)
    }
  }
}

check_pos_int <- function(x, name) {
  if (!is.numeric(x)) {
    abort_bad_argument(name, must = "be a numeric scalar", not = typeof(x))
  }
  x <- as.integer(x)

  if (length(x) != 1) {
    abort_bad_argument(name, must = "be of length 1", not = length(x))
  }

  if (is.na(x)) {
    abort_bad_argument(name, must = "be non-missing")
  }

  if (x <= 0) {
    abort_bad_argument(name, must = "be greater than zero")
  } else {
    x
  }
}

check_0_int <- function(x, name) {
  if (!is.numeric(x)) {
    abort_bad_argument(name, must = "be a numeric scalar", not = typeof(x))
  }
  x <- as.integer(x)

  if (is.na(x)) {
    abort_bad_argument(name, must = "be non-missing")
  }

  if (x < 0) {
    abort_bad_argument(name, must = "be greater than or equal to zero")
  } else {
    x
  }
}
check_0_int <- Vectorize(check_0_int, USE.NAMES = FALSE)

check_bound_real <- function(x, name, lb, ub) {
  if (!is.numeric(x)) {
    abort_bad_argument(name, must = "be numeric", not = typeof(x))
  }

  if (is.na(x)) {
    x
  } else if (x < lb | x > ub) {
    abort_bad_argument(name, must = glue::glue("be between {lb} and {ub}"))
  } else {
    x
  }
}
check_bound_real <- Vectorize(check_bound_real, USE.NAMES = FALSE)

check_number <- function(x, name) {
  if (!is.numeric(x)) {
    abort_bad_argument(name, must = "be numeric", not = typeof(x))
  } else {
    x
  }
}
check_number <- Vectorize(check_number, USE.NAMES = FALSE)

check_character <- function(x, name) {
  if (!is.character(x)) {
    abort_bad_argument(name, must = "be character", not = typeof(x))
  } else {
    x
  }
}
check_character <- Vectorize(check_character, USE.NAMES = FALSE)
