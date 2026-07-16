test_that("anime_playback() sets autoplay, loop, controls", {
  tl <- anime_timeline() |>
    anime_playback(autoplay = TRUE, loop = TRUE, controls = TRUE)

  expect_true(tl$autoplay)
  expect_true(tl$loop)
  expect_true(tl$controls)
})

test_that("anime_playback() sets reversed and alternate flags", {
  tl_rev <- anime_timeline() |> anime_playback(reversed = TRUE)
  expect_true(tl_rev$reversed)
  expect_false(isTRUE(tl_rev$alternate))

  tl_alt <- anime_timeline() |> anime_playback(alternate = TRUE, loop = TRUE)
  expect_true(tl_alt$alternate)
  expect_false(isTRUE(tl_alt$reversed))
})

test_that("anime_playback() leaves settings unchanged when arguments are NULL", {
  tl <- anime_timeline(loop = TRUE) |>
    anime_playback(controls = TRUE) |>
    anime_playback(autoplay = FALSE)

  expect_true(tl$loop)
  expect_true(tl$controls)
  expect_false(tl$autoplay)
})

test_that("anime_playback() sets loop_delay and playback_rate", {
  tl <- anime_timeline() |>
    anime_playback(loop = TRUE, loop_delay = 250, playback_rate = 2)
  expect_equal(tl$loop_delay, 250)
  expect_equal(tl$playback_rate, 2)
})

test_that("anime_playback() accepts an iteration count for loop", {
  tl <- anime_timeline() |> anime_playback(loop = 3)
  expect_equal(tl$loop, 3)
})

test_that("anime_playback() works on anime_animation objects", {
  anim <- anime_animate(selector = ".dot", props = list(opacity = 1)) |>
    anime_playback(loop = TRUE, controls = TRUE)
  expect_true(anim$loop)
  expect_true(anim$controls)
})

test_that("anime_playback() validates its inputs", {
  tl <- anime_timeline()
  expect_snapshot(error = TRUE, anime_playback(list(), loop = TRUE))
  expect_snapshot(error = TRUE, anime_playback(tl, autoplay = "yes"))
  expect_snapshot(error = TRUE, anime_playback(tl, loop = -1))
  expect_snapshot(error = TRUE, anime_playback(tl, loop_delay = -100))
  expect_snapshot(error = TRUE, anime_playback(tl, playback_rate = "fast"))
  expect_snapshot(error = TRUE, anime_playback(tl, controls = 1))
})

test_that("timeline_to_json_config() emits reversed/alternate only when TRUE", {
  tl_plain <- anime_timeline() |> anime_playback()
  cfg_plain <- timeline_to_json_config(tl_plain)
  expect_null(cfg_plain$reversed)
  expect_null(cfg_plain$alternate)

  tl_rev <- anime_timeline() |> anime_playback(reversed = TRUE)
  cfg_rev <- timeline_to_json_config(tl_rev)
  expect_true(cfg_rev$reversed)
  expect_null(cfg_rev$alternate)
})

test_that("loop_delay and playback_rate serialise to camelCase config fields", {
  tl <- anime_timeline() |>
    anime_playback(loop = TRUE, loop_delay = 250, playback_rate = 1.5)
  cfg <- timeline_to_json_config(tl)
  expect_equal(cfg$loopDelay, 250)
  expect_equal(cfg$playbackRate, 1.5)
})

test_that("anime_playback() preserves existing timeline segments and events", {
  tl <- anime_timeline() |>
    anime_add(
      selector = anime_target_class("circle"),
      props = list(opacity = anime_from_to(0, 1))
    )
  result <- anime_playback(tl, autoplay = FALSE, controls = TRUE)
  expect_length(result$segments, 1L)
})
