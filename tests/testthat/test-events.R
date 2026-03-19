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

test_that("anime_on() throws an informative error for an unrecognised event name", {
  tl <- anime_timeline()
  expect_error(anime_on(tl, "onUnknown", "cb"), class = "rlang_error")
  expect_error(anime_on(tl, "complete", "cb"), class = "rlang_error")
  expect_error(anime_on(tl, "onFinished", "cb"), class = "rlang_error")
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

test_that("anime_on() returns the modified timeline visibly", {
  tl <- anime_timeline()
  result <- withVisible(anime_on(tl, "onComplete", "cb"))
  expect_true(result$visible)
  expect_s3_class(result$value, "anime_timeline")
})
