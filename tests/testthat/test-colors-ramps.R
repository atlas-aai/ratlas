test_that("prebuilt ramps work", {
  # DLM -----
  expect_equal(ramp_dlm(c(0, 1)), c("#FFFFFF", "#2B4098"))
  expect_equal(
    ramp_dlm(seq(0, 1, by = .2)),
    c("#FFFFFF", "#D4D8EA", "#AAB2D5", "#7F8CC1", "#5566AC", "#2B4098")
  )
  expect_equal(
    ramp_dlm(seq(.2, 1, by = .2)),
    c("#D4D8EA", "#AAB2D5", "#7F8CC1", "#5566AC", "#2B4098")
  )
  expect_equal(
    ramp_dlm(seq(0, 1, length.out = 10), end = "#2B4098"),
    rep("#2B4098", 10)
  )

  # Okabe Ito -----
  expect_equal(ramp_okabeito(c(0, 1)), c("#FFFFFF", palette_okabeito[1]))
  expect_equal(
    ramp_okabeito(c(0, 1), index = 2),
    c("#FFFFFF", palette_okabeito[2])
  )
  expect_equal(
    ramp_okabeito(c(0, 1), index = 5),
    c("#FFFFFF", palette_okabeito[5])
  )
})
