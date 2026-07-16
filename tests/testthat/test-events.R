test_that("anime_on() stores the callback under the correct event key", {
  tl <- anime_timeline()
  tl2 <- anime_on(tl, "onComplete", "myCallback")
  expect_equal(tl2$events[["onComplete"]], "myCallback")
})

test_that("anime_on() stores the callback as a raw character string", {
  tl <- anime_timeline()
  tl2 <- anime_on(tl, "onBegin", "handleBegin")
  expect_type(tl2$events[["onBegin"]], "character")
})

test_that("anime_on() accepts all seven Anime.js v4 events", {
  events <- c(
    "onBegin",
    "onBeforeUpdate",
    "onUpdate",
    "onRender",
    "onLoop",
    "onPause",
    "onComplete"
  )
  tl <- anime_timeline()
  for (event in events) {
    tl <- anime_on(tl, event, paste0("handle_", event))
  }
  expect_named(tl$events, events)
})

test_that("anime_on() works on anime_animation objects", {
  anim <- anime_animate(selector = ".dot", props = list(opacity = 1)) |>
    anime_on("onComplete", "handleComplete")
  expect_equal(anim$events[["onComplete"]], "handleComplete")
})

test_that("anime_on() validates its inputs", {
  tl <- anime_timeline()
  expect_snapshot(error = TRUE, anime_on(tl, "onUnknown", "cb"))
  expect_snapshot(error = TRUE, anime_on(tl, "complete", "cb"))
  expect_snapshot(error = TRUE, anime_on(list(), "onComplete", "cb"))
  expect_snapshot(error = TRUE, anime_on(tl, "onComplete", 42))
})

test_that("multiple anime_on() calls accumulate across different events", {
  tl <- anime_timeline() |>
    anime_on("onBegin", "handleBegin") |>
    anime_on("onComplete", "handleComplete") |>
    anime_on("onLoop", "handleLoop")

  expect_equal(tl$events[["onBegin"]], "handleBegin")
  expect_equal(tl$events[["onComplete"]], "handleComplete")
  expect_equal(tl$events[["onLoop"]], "handleLoop")
})

test_that("a second anime_on() for the same event overwrites the first (last-write-wins)", {
  tl <- anime_timeline() |>
    anime_on("onComplete", "firstCallback") |>
    anime_on("onComplete", "secondCallback")

  expect_equal(tl$events[["onComplete"]], "secondCallback")
  expect_length(tl$events, 1L)
})
