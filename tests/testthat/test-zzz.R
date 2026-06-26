test_that(".onLoad() sets table format when auto_format is enabled", {
  called <- FALSE
  local_mocked_bindings(auto_set_format = function() called <<- TRUE)

  withr::local_options(ratlas.auto_format = TRUE)
  .onLoad(libname = NULL, pkgname = "ratlas")
  expect_true(called)
})

test_that(".onLoad() skips formatting when auto_format is disabled", {
  called <- FALSE
  local_mocked_bindings(auto_set_format = function() called <<- TRUE)

  withr::local_options(ratlas.auto_format = FALSE)
  .onLoad(libname = NULL, pkgname = "ratlas")
  expect_false(called)
})

test_that(".onAttach() does not load fonts unless requested", {
  called <- FALSE
  local_mocked_bindings(
    require_font = function(...) called <<- TRUE,
    .package = "systemfonts"
  )

  withr::local_options(ratlas.loadfonts = NULL)
  .onAttach(libname = NULL, pkgname = "ratlas")
  expect_false(called)
})

test_that(".onAttach() loads the configured font when requested", {
  args <- NULL
  local_mocked_bindings(
    require_font = function(...) args <<- list(...),
    .package = "systemfonts"
  )

  withr::local_options(
    ratlas.loadfonts = TRUE,
    ratlas.font_dir = "/tmp/fake-fonts"
  )
  .onAttach(libname = NULL, pkgname = "ratlas")

  expect_equal(args[[1]], "Roboto Condensed")
  expect_equal(args$dir, "/tmp/fake-fonts")
})
