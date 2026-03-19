test_that("ANIME_EASINGS is a character vector with at least 10 names", {
  expect_type(ANIME_EASINGS, "character")
  expect_gte(length(ANIME_EASINGS), 10L)
  expect_true(all(nzchar(ANIME_EASINGS)))
})

test_that("ANIME_EASINGS contains the 10 most common Anime.js v4 easing names", {
  common <- c(
    "linear",
    "easeInQuad",
    "easeOutQuad",
    "easeInOutQuad",
    "easeInCubic",
    "easeOutCubic",
    "easeInOutCubic",
    "easeInElastic",
    "easeOutElastic",
    "easeInBounce"
  )
  expect_true(all(common %in% ANIME_EASINGS))
})

test_that("anime_easing_bezier() formats four-coordinate string correctly", {
  expect_equal(anime_easing_bezier(0.4, 0, 0.2, 1), "cubicBezier(0.4,0,0.2,1)")
})

test_that("anime_easing_bezier() handles negative y control-point values", {
  expect_equal(
    anime_easing_bezier(0.68, -0.55, 0.265, 1.55),
    "cubicBezier(0.68,-0.55,0.265,1.55)"
  )
})

test_that("anime_easing_bezier() rejects x1 outside [0, 1]", {
  expect_error(anime_easing_bezier(-0.1, 0, 0.2, 1), class = "rlang_error")
  expect_error(anime_easing_bezier(1.1, 0, 0.2, 1), class = "rlang_error")
})

test_that("anime_easing_bezier() rejects x2 outside [0, 1]", {
  expect_error(anime_easing_bezier(0.4, 0, -0.1, 1), class = "rlang_error")
  expect_error(anime_easing_bezier(0.4, 0, 1.1, 1), class = "rlang_error")
})

test_that("anime_easing_spring() uses correct defaults", {
  expect_equal(anime_easing_spring(), "spring(1,100,10,0)")
})

test_that("anime_easing_spring() formats explicit arguments correctly", {
  expect_equal(
    anime_easing_spring(mass = 2, stiffness = 80, damping = 5, velocity = 1),
    "spring(2,80,5,1)"
  )
})
