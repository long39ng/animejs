# validate_duration() -----------------------------------------------------

test_that("validate_duration() accepts a positive numeric scalar", {
  expect_no_error(validate_duration(1000))
  expect_no_error(validate_duration(0.5))
})

test_that("validate_duration() rejects non-numeric input", {
  expect_error(validate_duration("fast"), class = "rlang_error")
  expect_error(validate_duration(TRUE), class = "rlang_error")
  expect_error(validate_duration(NULL), class = "rlang_error")
})

test_that("validate_duration() rejects negative values", {
  expect_error(validate_duration(-1), class = "rlang_error")
  expect_error(validate_duration(-0.1), class = "rlang_error")
})

test_that("validate_duration() rejects length > 1 vectors", {
  expect_error(validate_duration(c(100, 200)), class = "rlang_error")
})

test_that("validate_duration() uses the arg name in the error message", {
  expect_error(validate_duration("x", arg = "delay"), regexp = "delay")
})

# to_js_props() -- plain scalar -------------------------------------------

test_that("to_js_props() passes through a plain numeric scalar unchanged", {
  result <- to_js_props(list(opacity = 1))
  expect_equal(result$opacity, 1)
})

test_that("to_js_props() passes through a plain character scalar unchanged", {
  result <- to_js_props(list(ease = "linear"))
  expect_equal(result$ease, "linear")
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

# timeline_to_json_config() -----------------------------------------------

test_that("timeline_to_json_config() returns a list", {
  tl <- structure(
    list(
      defaults = list(
        duration = 1000,
        ease = "linear",
        delay = 0,
        direction = "normal"
      ),
      loop = FALSE,
      segments = list(),
      events = list()
    ),
    class = "anime_timeline"
  )
  result <- timeline_to_json_config(tl)
  expect_type(result, "list")
})

test_that("timeline_to_json_config() preserves defaults", {
  tl <- structure(
    list(
      defaults = list(
        duration = 800,
        ease = "easeOutElastic",
        delay = 0,
        direction = "normal"
      ),
      loop = FALSE,
      segments = list(),
      events = list()
    ),
    class = "anime_timeline"
  )
  result <- timeline_to_json_config(tl)
  expect_equal(result$defaults$duration, 800)
  expect_equal(result$defaults$ease, "easeOutElastic")
})

test_that("timeline_to_json_config() preserves loop", {
  tl <- structure(
    list(
      defaults = list(
        duration = 1000,
        ease = "linear",
        delay = 0,
        direction = "normal"
      ),
      loop = TRUE,
      segments = list(),
      events = list()
    ),
    class = "anime_timeline"
  )
  result <- timeline_to_json_config(tl)
  expect_true(result$loop)
})

test_that("timeline_to_json_config() round-trips through JSON without data loss", {
  skip_if_not_installed("jsonlite")

  tl <- structure(
    list(
      defaults = list(
        duration = 1000,
        ease = "linear",
        delay = 0,
        direction = "normal"
      ),
      loop = FALSE,
      segments = list(
        list(
          selector = ".dot",
          props = list(opacity = list(from = 0, to = 1)),
          offset = "+=0"
        )
      ),
      events = list()
    ),
    class = "anime_timeline"
  )
  config <- timeline_to_json_config(tl)
  json <- jsonlite::toJSON(config, auto_unbox = TRUE)
  round_trip <- jsonlite::fromJSON(json, simplifyVector = FALSE)

  expect_equal(round_trip$defaults$duration, 1000)
  expect_equal(round_trip$segments[[1]]$selector, ".dot")
  expect_equal(round_trip$segments[[1]]$props$opacity$from, 0)
  expect_equal(round_trip$segments[[1]]$props$opacity$to, 1)
})

test_that("timeline_to_json_config() includes optional playback fields when present", {
  tl <- structure(
    list(
      defaults = list(
        duration = 1000,
        ease = "linear",
        delay = 0,
        direction = "normal"
      ),
      loop = FALSE,
      autoplay = FALSE,
      controls = TRUE,
      direction = "alternate",
      segments = list(),
      events = list()
    ),
    class = "anime_timeline"
  )
  result <- timeline_to_json_config(tl)
  expect_false(result$autoplay)
  expect_true(result$controls)
})
