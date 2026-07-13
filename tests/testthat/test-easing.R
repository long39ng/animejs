test_that("anime_easing() returns an anime_easing object", {
  expect_s3_class(anime_easing("linear"), "anime_easing")
  expect_s3_class(anime_easing("Quad", "out"), "anime_easing")
  expect_s3_class(anime_easing("Bounce", "inOut"), "anime_easing")
})

test_that("anime_easing() stores name and an empty params list", {
  expect_equal(anime_easing("Quad", "out")$name, "outQuad")
  expect_identical(anime_easing("Quad", "out")$params, list())
})

test_that("anime_easing() defaults direction to 'out' for non-linear families", {
  expect_equal(anime_easing("Quad")$name, "outQuad")
})

test_that("anime_easing() rejects unrecognised family and direction names", {
  expect_snapshot(error = TRUE, anime_easing("Quadratic"))
  expect_snapshot(error = TRUE, anime_easing("Elastic")) # use anime_easing_elastic()
  expect_snapshot(error = TRUE, anime_easing("Quad", "Both"))
})

test_that("simple easings serialise to their full JS name", {
  expect_identical(easing_to_config(anime_easing("linear")), "linear")
  expect_identical(easing_to_config(anime_easing("Quad", "out")), "outQuad")
  expect_identical(
    easing_to_config(anime_easing("Cubic", "inOut")),
    "inOutCubic"
  )
  expect_identical(easing_to_config(anime_easing("Bounce", "out")), "outBounce")
})

test_that("anime_easing_elastic() defaults to 'out' direction", {
  expect_equal(anime_easing_elastic()$name, "outElastic")
})

test_that("anime_easing_elastic() stores amplitude and period", {
  e <- anime_easing_elastic("in", amplitude = 1.5, period = 0.3)
  expect_equal(e$name, "inElastic")
  expect_equal(e$params$amplitude, 1.5)
  expect_equal(e$params$period, 0.3)
})

test_that("elastic easings serialise to v4-parseable name strings", {
  expect_identical(
    easing_to_config(anime_easing_elastic()),
    "outElastic(1,0.3)"
  )
  expect_identical(
    easing_to_config(anime_easing_elastic(
      "inOut",
      amplitude = 1.5,
      period = 0.4
    )),
    "inOutElastic(1.5,0.4)"
  )
})

test_that("anime_easing_elastic() validates its parameters", {
  expect_snapshot(error = TRUE, anime_easing_elastic("Both"))
  expect_snapshot(error = TRUE, anime_easing_elastic(amplitude = 0.5))
  expect_snapshot(error = TRUE, anime_easing_elastic(amplitude = 11))
  expect_snapshot(error = TRUE, anime_easing_elastic(period = 3))
})

test_that("anime_easing_back() defaults to 'out' direction", {
  expect_equal(anime_easing_back()$name, "outBack")
})

test_that("anime_easing_back() stores overshoot", {
  e <- anime_easing_back("in", overshoot = 2.5)
  expect_equal(e$name, "inBack")
  expect_equal(e$params$overshoot, 2.5)
})

test_that("back easings serialise to v4-parseable name strings", {
  expect_identical(easing_to_config(anime_easing_back()), "outBack(1.70158)")
  expect_identical(
    easing_to_config(anime_easing_back("inOut", overshoot = 2.5)),
    "inOutBack(2.5)"
  )
})

test_that("anime_easing_back() validates its parameters", {
  expect_snapshot(error = TRUE, anime_easing_back("Sideways"))
  expect_snapshot(error = TRUE, anime_easing_back(overshoot = "far"))
})

test_that("anime_easing_steps() stores count as an integer and from_start", {
  expect_identical(anime_easing_steps(5)$params$count, 5L)
  expect_false(anime_easing_steps(5)$params$from_start)
  expect_true(anime_easing_steps(5, from_start = TRUE)$params$from_start)
})

test_that("steps easings serialise to a tagged list (no v4 string form)", {
  expect_identical(
    easing_to_config(anime_easing_steps(10)),
    list(type = "steps", count = 10L, fromStart = FALSE)
  )
  expect_identical(
    easing_to_config(anime_easing_steps(5, from_start = TRUE)),
    list(type = "steps", count = 5L, fromStart = TRUE)
  )
})

test_that("anime_easing_steps() validates its parameters", {
  expect_snapshot(error = TRUE, anime_easing_steps())
  expect_snapshot(error = TRUE, anime_easing_steps(0))
  expect_snapshot(error = TRUE, anime_easing_steps(-1))
  expect_snapshot(error = TRUE, anime_easing_steps(2.5))
  expect_snapshot(error = TRUE, anime_easing_steps(10, from_start = "yes"))
})

test_that("anime_easing_spring() stores both parameters", {
  e <- anime_easing_spring(bounce = 0.2, duration = 800)
  expect_equal(e$params$bounce, 0.2)
  expect_equal(e$params$duration, 800)
})

test_that("spring easings serialise to a tagged list (no v4 string form)", {
  expect_identical(
    easing_to_config(anime_easing_spring()),
    list(type = "spring", bounce = 0.5, duration = 628)
  )
  expect_identical(
    easing_to_config(anime_easing_spring(bounce = 0.2, duration = 800)),
    list(type = "spring", bounce = 0.2, duration = 800)
  )
})

test_that("anime_easing_spring() validates its parameters", {
  expect_snapshot(error = TRUE, anime_easing_spring(bounce = 2))
  expect_snapshot(error = TRUE, anime_easing_spring(bounce = c(0.1, 0.2)))
  expect_snapshot(error = TRUE, anime_easing_spring(duration = 5))
  expect_snapshot(error = TRUE, anime_easing_spring(duration = 20000))
})

test_that("anime_easing_bezier() stores the control points", {
  e <- anime_easing_bezier(0.4, 0, 0.2, 1)
  expect_equal(e$params, list(x1 = 0.4, y1 = 0, x2 = 0.2, y2 = 1))
})

test_that("bezier easings serialise to a tagged list (no v4 string form)", {
  expect_identical(
    easing_to_config(anime_easing_bezier(0.4, 0, 0.2, 1)),
    list(type = "cubicBezier", args = list(0.4, 0, 0.2, 1))
  )
  expect_identical(
    easing_to_config(anime_easing_bezier(0.68, -0.55, 0.265, 1.55)),
    list(type = "cubicBezier", args = list(0.68, -0.55, 0.265, 1.55))
  )
})

test_that("anime_easing_bezier() validates its parameters", {
  expect_snapshot(error = TRUE, anime_easing_bezier(-0.1, 0, 0.2, 1))
  expect_snapshot(error = TRUE, anime_easing_bezier(1.1, 0, 0.2, 1))
  expect_snapshot(error = TRUE, anime_easing_bezier(0.4, 0, -0.1, 1))
  expect_snapshot(error = TRUE, anime_easing_bezier(0.4, 0, 1.1, 1))
  expect_snapshot(error = TRUE, anime_easing_bezier(0.4, 0, 0.2))
})

test_that("easing_to_config() passes name strings through unchanged", {
  expect_identical(easing_to_config("outQuad"), "outQuad")
  expect_identical(easing_to_config("outElastic(1,0.3)"), "outElastic(1,0.3)")
})

test_that("easing_to_config() returns NULL unchanged", {
  expect_null(easing_to_config(NULL))
})

test_that("easing_to_config() errors on unsupported input", {
  expect_snapshot(error = TRUE, easing_to_config(42))
  expect_snapshot(error = TRUE, easing_to_config(list()))
})
