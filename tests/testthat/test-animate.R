test_that("anime_animate() returns an anime_animation object", {
  anim <- anime_animate(selector = ".dot", props = list(opacity = c(0, 1)))
  expect_s3_class(anim, "anime_animation")
})

test_that("anime_animate() stores tween and playback parameters", {
  anim <- anime_animate(
    selector = ".dot",
    props = list(opacity = anime_from_to(0, 1)),
    duration = 600,
    ease = "outQuad",
    delay = 50,
    loop = 3,
    alternate = TRUE,
    reversed = TRUE,
    autoplay = FALSE,
    stagger = anime_stagger(100)
  )
  expect_equal(anim$selector, ".dot")
  expect_equal(anim$duration, 600)
  expect_equal(anim$ease, "outQuad")
  expect_equal(anim$delay, 50)
  expect_equal(anim$loop, 3)
  expect_true(anim$alternate)
  expect_true(anim$reversed)
  expect_false(anim$autoplay)
  expect_s3_class(anim$stagger, "anime_stagger")
})

test_that("anime_animate() initialises events as an empty list", {
  anim <- anime_animate(selector = ".dot", props = list(opacity = 1))
  expect_identical(anim$events, list())
})

test_that("anime_animate() validates its inputs", {
  expect_snapshot(error = TRUE, anime_animate(1, props = list(opacity = 1)))
  expect_snapshot(error = TRUE, anime_animate(".dot", props = list(1)))
  expect_snapshot(error = TRUE, {
    anime_animate(".dot", props = list(opacity = 1), duration = -1)
  })
  expect_snapshot(error = TRUE, {
    anime_animate(".dot", props = list(opacity = 1), ease = 42)
  })
  expect_snapshot(error = TRUE, {
    anime_animate(".dot", props = list(opacity = 1), loop = "yes")
  })
  expect_snapshot(error = TRUE, {
    anime_animate(".dot", props = list(opacity = 1), stagger = 100)
  })
})

test_that("animation_to_json_config() tags the config kind", {
  anim <- anime_animate(selector = ".dot", props = list(opacity = 1))
  expect_identical(animation_to_json_config(anim)$kind, "animation")
})

test_that("animation_to_json_config() serialises tween parameters", {
  anim <- anime_animate(
    selector = ".dot",
    props = list(opacity = anime_from_to(0, 1)),
    duration = 600,
    ease = anime_easing_spring(),
    delay = 50
  )
  config <- animation_to_json_config(anim)
  expect_equal(config$selector, ".dot")
  expect_equal(config$props$opacity, list(from = 0, to = 1))
  expect_equal(config$duration, 600)
  expect_identical(
    config$ease,
    list(type = "spring", bounce = 0.5, duration = 628)
  )
  expect_equal(config$delay, 50)
})

test_that("animation_to_json_config() omits unset tween parameters", {
  anim <- anime_animate(selector = ".dot", props = list(opacity = 1))
  config <- animation_to_json_config(anim)
  expect_null(config$duration)
  expect_null(config$ease)
  expect_null(config$delay)
  expect_null(config$stagger)
})

test_that("animation_to_json_config() serialises playback and stagger settings", {
  anim <- anime_animate(
    selector = ".dot",
    props = list(opacity = 1),
    loop = TRUE,
    alternate = TRUE,
    stagger = anime_stagger(100, from = "center")
  ) |>
    anime_playback(loop_delay = 200, controls = TRUE)

  config <- animation_to_json_config(anim)
  expect_true(config$loop)
  expect_true(config$alternate)
  expect_equal(config$loopDelay, 200)
  expect_true(config$controls)
  expect_equal(config$stagger$value, 100)
  expect_equal(config$stagger$from, "center")
})

test_that("animation config round-trips through JSON without data loss", {
  skip_if_not_installed("jsonlite")

  anim <- anime_animate(
    selector = ".dot",
    props = list(translateY = anime_keyframes(0, -30, 0)),
    ease = anime_easing_steps(4),
    loop = 2
  )
  widget <- anime_render(anim)

  json <- jsonlite::toJSON(widget$x$config, auto_unbox = TRUE)
  parsed <- jsonlite::fromJSON(json, simplifyVector = FALSE)

  expect_equal(parsed$kind, "animation")
  expect_equal(parsed$selector, ".dot")
  expect_length(parsed$props$translateY, 3L)
  expect_equal(parsed$ease, list(type = "steps", count = 4, fromStart = FALSE))
  expect_equal(parsed$loop, 2)
})
