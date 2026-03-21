test_that(".EASINGS entries each have constructor, names, and params fields", {
  for (fam in names(.EASINGS)) {
    entry <- .EASINGS[[fam]]
    expect_true(
      all(c("constructor", "names", "params") %in% names(entry)),
      label = sprintf("family '%s' has required fields", fam)
    )
  }
})

test_that(".EASINGS registry is consistent with the family vectors", {
  expect_identical(.EASINGS$simple$names, .EASING_SIMPLE)
  expect_identical(.EASINGS$elastic$names, .EASING_ELASTIC)
  expect_identical(.EASINGS$back$names, .EASING_BACK)
})

test_that("anime_easing() returns an anime_easing object", {
  expect_s3_class(anime_easing("linear"), "anime_easing")
  expect_s3_class(anime_easing("Quad", "out"), "anime_easing")
  expect_s3_class(anime_easing("Bounce", "inOut"), "anime_easing")
})

test_that("anime_easing() stores name and an empty params list", {
  expect_equal(anime_easing("Quad", "out")$name, "outQuad")
  expect_identical(anime_easing("Quad", "out")$params, list())
})

test_that("anime_easing() defaults direction to 'Out' for non-linear families", {
  expect_equal(anime_easing("Quad")$name, "outQuad")
})

test_that("anime_easing() rejects unrecognised family names", {
  expect_error(anime_easing("Quadratic"), class = "rlang_error")
  expect_error(anime_easing("Elastic"), class = "rlang_error") # use anime_easing_elastic()
})

test_that("anime_easing() rejects invalid direction", {
  expect_error(anime_easing("Quad", "Both"), class = "rlang_error")
})

test_that("simple easings serialise to their full JS name", {
  expect_equal(easing_to_js(anime_easing("linear")), "linear")
  expect_equal(easing_to_js(anime_easing("Quad", "out")), "outQuad")
  expect_equal(easing_to_js(anime_easing("Cubic", "inOut")), "inOutCubic")
  expect_equal(easing_to_js(anime_easing("Bounce", "out")), "outBounce")
})

test_that("anime_easing_elastic() returns an anime_easing object", {
  expect_s3_class(anime_easing_elastic(), "anime_easing")
})

test_that("anime_easing_elastic() defaults to 'Out' direction", {
  expect_equal(anime_easing_elastic()$name, "outElastic")
})

test_that("anime_easing_elastic() stores amplitude and period", {
  e <- anime_easing_elastic("in", amplitude = 1.5, period = 0.3)
  expect_equal(e$name, "inElastic")
  expect_equal(e$params$amplitude, 1.5)
  expect_equal(e$params$period, 0.3)
})

test_that("anime_easing_elastic() serialises with defaults", {
  expect_equal(
    easing_to_js(anime_easing_elastic("out")),
    "outElastic(1,0.3)"
  )
  expect_equal(easing_to_js(anime_easing_elastic("in")), "inElastic(1,0.3)")
  expect_equal(
    easing_to_js(anime_easing_elastic("inOut")),
    "inOutElastic(1,0.3)"
  )
})

test_that("anime_easing_elastic() serialises with custom amplitude and period", {
  expect_equal(
    easing_to_js(anime_easing_elastic("out", amplitude = 1.5, period = 0.3)),
    "outElastic(1.5,0.3)"
  )
})

test_that("anime_easing_elastic() rejects invalid direction", {
  expect_error(anime_easing_elastic("Both"), class = "rlang_error")
})

test_that("anime_easing_back() returns an anime_easing object", {
  expect_s3_class(anime_easing_back(), "anime_easing")
})

test_that("anime_easing_back() defaults to 'Out' direction", {
  expect_equal(anime_easing_back()$name, "outBack")
})

test_that("anime_easing_back() stores overshoot", {
  e <- anime_easing_back("in", overshoot = 2.5)
  expect_equal(e$name, "inBack")
  expect_equal(e$params$overshoot, 2.5)
})

test_that("anime_easing_back() serialises with default overshoot", {
  expect_equal(easing_to_js(anime_easing_back("in")), "inBack(1.70158)")
  expect_equal(easing_to_js(anime_easing_back("out")), "outBack(1.70158)")
  expect_equal(
    easing_to_js(anime_easing_back("inOut")),
    "inOutBack(1.70158)"
  )
})

test_that("anime_easing_back() serialises with custom overshoot", {
  expect_equal(
    easing_to_js(anime_easing_back("in", overshoot = 2.5)),
    "inBack(2.5)"
  )
})

test_that("anime_easing_back() rejects invalid direction", {
  expect_error(anime_easing_back("Sideways"), class = "rlang_error")
})

test_that("anime_easing_steps() returns an anime_easing object", {
  expect_s3_class(anime_easing_steps(10), "anime_easing")
})

test_that("anime_easing_steps() stores count as an integer", {
  expect_identical(anime_easing_steps(5)$params$count, 5L)
})

test_that("anime_easing_steps() serialises to steps(n)", {
  expect_equal(easing_to_js(anime_easing_steps(10)), "steps(10)")
  expect_equal(easing_to_js(anime_easing_steps(1)), "steps(1)")
})

test_that("anime_easing_steps() errors when count is missing", {
  expect_error(anime_easing_steps(), class = "rlang_error")
})

test_that("anime_easing_steps() errors when count is non-positive", {
  expect_error(anime_easing_steps(0), class = "rlang_error")
  expect_error(anime_easing_steps(-1), class = "rlang_error")
})

test_that("anime_easing_steps() errors when count is non-integer", {
  expect_error(anime_easing_steps(2.5), class = "rlang_error")
})

test_that("anime_easing_spring() returns an anime_easing object", {
  expect_s3_class(anime_easing_spring(), "anime_easing")
})

test_that("anime_easing_spring() serialises with default parameters", {
  expect_equal(easing_to_js(anime_easing_spring()), "spring(0.5,628)")
})

test_that("anime_easing_spring() serialises with custom parameters", {
  expect_equal(
    easing_to_js(anime_easing_spring(bounce = 0.2, duration = 800)),
    "spring(0.2,800)"
  )
})

test_that("anime_easing_spring() stores both parameters", {
  e <- anime_easing_spring(bounce = 0.2, duration = 800)
  expect_equal(e$params$bounce, 0.2)
  expect_equal(e$params$duration, 800)
})

test_that("anime_easing_bezier() returns an anime_easing object", {
  expect_s3_class(anime_easing_bezier(0.4, 0, 0.2, 1), "anime_easing")
})

test_that("anime_easing_bezier() serialises correctly", {
  expect_equal(
    easing_to_js(anime_easing_bezier(0.4, 0, 0.2, 1)),
    "cubicBezier(0.4,0,0.2,1)"
  )
})

test_that("anime_easing_bezier() handles negative y values", {
  expect_equal(
    easing_to_js(anime_easing_bezier(0.68, -0.55, 0.265, 1.55)),
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

test_that("easing_to_js() passes plain strings through unchanged", {
  expect_equal(easing_to_js("outQuad"), "outQuad")
  expect_equal(easing_to_js("spring(1,100,10,0)"), "spring(1,100,10,0)")
  expect_equal(
    easing_to_js("cubicBezier(0.4,0,0.2,1)"),
    "cubicBezier(0.4,0,0.2,1)"
  )
})

test_that("easing_to_js() errors on non-character, non-anime_easing input", {
  expect_error(easing_to_js(42), class = "rlang_error")
  expect_error(easing_to_js(list()), class = "rlang_error")
})
