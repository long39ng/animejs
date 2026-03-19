test_that("anime_playback() sets autoplay on the timeline", {
  tl <- anime_timeline()
  result <- anime_playback(tl, autoplay = FALSE)
  expect_false(result$autoplay)

  result2 <- anime_playback(tl, autoplay = TRUE)
  expect_true(result2$autoplay)
})

test_that("anime_playback() sets loop on the timeline", {
  tl <- anime_timeline()
  result <- anime_playback(tl, loop = TRUE)
  expect_true(result$loop)
})

test_that("anime_playback() sets direction on the timeline", {
  tl <- anime_timeline()
  for (dir in c("normal", "reverse", "alternate")) {
    result <- anime_playback(tl, direction = dir)
    expect_equal(result$direction, dir)
  }
})

test_that("anime_playback() rejects invalid direction values", {
  tl <- anime_timeline()
  expect_error(
    anime_playback(tl, direction = "sideways"),
    regexp = "direction"
  )
})

test_that("anime_playback() sets controls on the timeline", {
  tl <- anime_timeline()
  result <- anime_playback(tl, controls = TRUE)
  expect_true(result$controls)
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
