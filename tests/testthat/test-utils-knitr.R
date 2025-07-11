test_that("unfound template errors", {
  err <- rlang::catch_cnd(find_resource("measr_docx", "template.docx"))
  expect_s3_class(err, "rlang_error")
  expect_match(err$message, "Couldn't find template file")
})
