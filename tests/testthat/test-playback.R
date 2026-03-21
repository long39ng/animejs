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

test_that("anime_playback() preserves existing timeline segments and events", {
  tl <- anime_timeline() |>
    anime_add(
      selector = anime_target_class("circle"),
      props = list(opacity = anime_from_to(0, 1))
    )
  result <- anime_playback(tl, autoplay = FALSE, controls = TRUE)
  expect_length(result$segments, 1L)
})
