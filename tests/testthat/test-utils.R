# validate_duration() -----------------------------------------------------

test_that("validate_duration() accepts a non-negative numeric scalar", {
  expect_no_error(validate_duration(1000))
  expect_no_error(validate_duration(0.5))
  expect_no_error(validate_duration(0))
})

test_that("validate_duration() rejects invalid input", {
  expect_snapshot(error = TRUE, validate_duration("fast"))
  expect_snapshot(error = TRUE, validate_duration(TRUE))
  expect_snapshot(error = TRUE, validate_duration(NULL))
  expect_snapshot(error = TRUE, validate_duration(-1))
  expect_snapshot(error = TRUE, validate_duration(c(100, 200)))
  expect_snapshot(error = TRUE, validate_duration("x", arg = "delay"))
})

# to_js_props() -- plain scalar -------------------------------------------

test_that("to_js_props() passes through a plain numeric scalar unchanged", {
  result <- to_js_props(list(opacity = 1))
  expect_equal(result$opacity, 1)
})

test_that("to_js_props() passes through a plain character scalar unchanged", {
  result <- to_js_props(list(fill = "#ff0000"))
  expect_equal(result$fill, "#ff0000")
})

# to_js_props() -- length-2 numeric vector treated as from/to -------------

test_that("to_js_props() converts a length-2 numeric vector to a from/to list", {
  result <- to_js_props(list(opacity = c(0, 1)))
  expect_type(result$opacity, "list")
  expect_equal(result$opacity$from, 0)
  expect_equal(result$opacity$to, 1)
})

test_that("to_js_props() handles multiple properties simultaneously", {
  result <- to_js_props(list(opacity = c(0, 1), translateY = c(-20, 0)))
  expect_equal(result$opacity$from, 0)
  expect_equal(result$opacity$to, 1)
  expect_equal(result$translateY$from, -20)
  expect_equal(result$translateY$to, 0)
})

# to_js_props() -- nested easing serialisation ----------------------------

test_that("to_js_props() serialises anime_easing objects inside keyframes", {
  kf <- anime_keyframes(
    list(to = 1, ease = anime_easing_spring()),
    list(to = 0, ease = "outQuad")
  )
  result <- to_js_props(list(opacity = kf))
  expect_identical(
    result$opacity[[1]]$ease,
    list(type = "spring", bounce = 0.5, duration = 628)
  )
  expect_identical(result$opacity[[2]]$ease, "outQuad")
})

test_that("to_js_props() serialises the per-property ease of anime_from_to", {
  ft <- anime_from_to(0, 1, ease = anime_easing_bezier(0.4, 0, 0.2, 1))
  result <- to_js_props(list(opacity = ft))
  expect_identical(result$opacity$from, 0)
  expect_identical(result$opacity$to, 1)
  expect_identical(
    result$opacity$ease,
    list(type = "cubicBezier", args = list(0.4, 0, 0.2, 1))
  )
})

# timeline_to_json_config() -----------------------------------------------

test_that("timeline_to_json_config() tags the config kind", {
  config <- timeline_to_json_config(anime_timeline())
  expect_identical(config$kind, "timeline")
})

test_that("timeline_to_json_config() preserves defaults", {
  tl <- anime_timeline(duration = 800, ease = "outElastic", delay = 0)
  result <- timeline_to_json_config(tl)
  expect_equal(result$defaults$duration, 800)
  expect_equal(result$defaults$ease, "outElastic")
})

test_that("timeline_to_json_config() serialises easing objects in defaults", {
  tl <- anime_timeline(ease = anime_easing_spring())
  result <- timeline_to_json_config(tl)
  expect_identical(
    result$defaults$ease,
    list(type = "spring", bounce = 0.5, duration = 628)
  )
})

test_that("timeline_to_json_config() preserves loop", {
  tl <- anime_timeline(loop = TRUE)
  result <- timeline_to_json_config(tl)
  expect_true(result$loop)
})

test_that("timeline_to_json_config() round-trips through JSON without data loss", {
  skip_if_not_installed("jsonlite")

  tl <- anime_timeline(duration = 1000, ease = "linear", delay = 0) |>
    anime_add(selector = ".dot", props = list(opacity = c(0, 1)))
  config <- timeline_to_json_config(tl)
  json <- jsonlite::toJSON(config, auto_unbox = TRUE)
  round_trip <- jsonlite::fromJSON(json, simplifyVector = FALSE)

  expect_equal(round_trip$kind, "timeline")
  expect_equal(round_trip$defaults$duration, 1000)
  expect_equal(round_trip$segments[[1]]$selector, ".dot")
  expect_equal(round_trip$segments[[1]]$props$opacity$from, 0)
  expect_equal(round_trip$segments[[1]]$props$opacity$to, 1)
})

test_that("timeline_to_json_config() includes optional playback fields when present", {
  tl <- anime_timeline() |>
    anime_playback(autoplay = FALSE, controls = TRUE, alternate = TRUE)
  result <- timeline_to_json_config(tl)
  expect_false(result$autoplay)
  expect_true(result$controls)
  expect_true(result$alternate)
})
