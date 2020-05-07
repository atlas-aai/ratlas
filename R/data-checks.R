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