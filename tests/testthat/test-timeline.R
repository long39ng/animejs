test_that("anime_timeline() returns an anime_timeline object", {
  tl <- anime_timeline()
  expect_s3_class(tl, "anime_timeline")
})

test_that("anime_timeline() stores defaults correctly", {
  tl <- anime_timeline(
    duration = 500,
    ease = "linear",
    loop = TRUE,
    delay = 100
  )
  expect_equal(tl$defaults$duration, 500)
  expect_equal(tl$defaults$ease, "linear")
  expect_equal(tl$defaults$delay, 100)
  expect_true(tl$loop)
})

test_that("anime_timeline() initialises segments and events as empty lists", {
  tl <- anime_timeline()
  expect_identical(tl$segments, list())
  expect_identical(tl$events, list())
})

test_that("anime_add() appends a segment with correct fields", {
  tl <- anime_timeline() |>
    anime_add(selector = ".circle", props = list(opacity = c(0, 1)))
  expect_length(tl$segments, 1L)
  expect_equal(tl$segments[[1]]$selector, ".circle")
  expect_equal(tl$segments[[1]]$offset, "+=0")
})

test_that("anime_add() stores segment-level overrides when provided", {
  tl <- anime_timeline() |>
    anime_add(
      selector = ".circle",
      props = list(opacity = 1),
      duration = 400,
      ease = "linear",
      delay = 50
    )
  seg <- tl$segments[[1]]
  expect_equal(seg$duration, 400)
  expect_equal(seg$ease, "linear")
  expect_equal(seg$delay, 50)
})

test_that("anime_add() omits segment-level overrides when NULL", {
  tl <- anime_timeline() |>
    anime_add(selector = ".circle", props = list(opacity = 1))
  seg <- tl$segments[[1]]
  expect_null(seg$duration)
  expect_null(seg$ease)
  expect_null(seg$delay)
})

test_that("anime_add() throws an informative error for non-anime_timeline input", {
  expect_error(
    anime_add(list(), selector = ".x", props = list()),
    class = "simpleError"
  )
})

test_that("pipe chaining accumulates multiple segments", {
  tl <- anime_timeline() |>
    anime_add(selector = ".a", props = list(opacity = c(0, 1))) |>
    anime_add(selector = ".b", props = list(translateX = c(-20, 0)))
  expect_length(tl$segments, 2L)
  expect_equal(tl$segments[[1]]$selector, ".a")
  expect_equal(tl$segments[[2]]$selector, ".b")
})
