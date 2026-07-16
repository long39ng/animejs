test_that("anime_stagger() returns an anime_stagger object", {
  s <- anime_stagger(100)
  expect_s3_class(s, "anime_stagger")
})

test_that("anime_stagger() stores value correctly", {
  s <- anime_stagger(150)
  expect_equal(s$value, 150)
})

test_that("anime_stagger() defaults are correct", {
  s <- anime_stagger(100)
  expect_equal(s$from, "first")
  expect_null(s$start)
  expect_false(s$reversed)
  expect_null(s$grid)
  expect_null(s$axis)
  expect_null(s$ease)
})

test_that("anime_stagger() stores all parameters when provided", {
  s <- anime_stagger(
    200,
    from = "center",
    start = 500,
    reversed = TRUE,
    grid = c(3L, 4L),
    axis = "x",
    ease = "linear"
  )
  expect_equal(s$from, "center")
  expect_equal(s$start, 500)
  expect_true(s$reversed)
  expect_equal(s$grid, c(3L, 4L))
  expect_equal(s$axis, "x")
  expect_equal(s$ease, "linear")
})

test_that("anime_stagger() accepts a numeric from index", {
  s <- anime_stagger(100, from = 2)
  expect_equal(s$from, 2)
})

test_that("anime_stagger() validates its inputs", {
  expect_snapshot(error = TRUE, anime_stagger("fast"))
  expect_snapshot(error = TRUE, anime_stagger(100, from = "middle"))
  expect_snapshot(error = TRUE, anime_stagger(100, from = -1))
  expect_snapshot(error = TRUE, anime_stagger(100, from = TRUE))
  expect_snapshot(error = TRUE, anime_stagger(100, grid = c(1, 2, 3)))
  expect_snapshot(error = TRUE, anime_stagger(100, axis = "z"))
  expect_snapshot(error = TRUE, anime_stagger(100, ease = 42))
})

test_that("stagger_to_js() produces correct list for simple stagger", {
  s <- anime_stagger(100, from = "first")
  result <- stagger_to_js(s)
  expect_equal(result$value, 100)
  expect_null(result$from) # Omits 'from' when it is 'first' (the JS default)
  expect_null(result$start)
  expect_null(result$reversed)
  expect_null(result$grid)
  expect_null(result$axis)
})

test_that("stagger_to_js() includes 'from' when not 'first'", {
  s <- anime_stagger(100, from = "center")
  result <- stagger_to_js(s)
  expect_equal(result$from, "center")
})

test_that("stagger_to_js() includes start and reversed when set", {
  s <- anime_stagger(100, start = 250, reversed = TRUE)
  result <- stagger_to_js(s)
  expect_equal(result$start, 250)
  expect_true(result$reversed)
})

test_that("stagger_to_js() includes grid and axis when provided", {
  s <- anime_stagger(50, grid = c(2L, 3L), axis = "y")
  result <- stagger_to_js(s)
  expect_equal(result$grid, c(2L, 3L))
  expect_equal(result$axis, "y")
})

test_that("stagger_to_js() passes easing name strings through", {
  s <- anime_stagger(100, ease = "inQuad")
  result <- stagger_to_js(s)
  expect_equal(result$ease, "inQuad")
})

test_that("stagger_to_js() serialises anime_easing objects", {
  s <- anime_stagger(100, ease = anime_easing("Quad", "in"))
  expect_identical(stagger_to_js(s)$ease, "inQuad")

  s_spring <- anime_stagger(100, ease = anime_easing_spring())
  expect_identical(
    stagger_to_js(s_spring)$ease,
    list(type = "spring", bounce = 0.5, duration = 628)
  )
})
