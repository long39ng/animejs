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
  expect_null(s$grid)
  expect_null(s$axis)
  expect_null(s$ease)
})

test_that("anime_stagger() stores all parameters when provided", {
  s <- anime_stagger(
    200,
    from = "center",
    grid = c(3L, 4L),
    axis = "x",
    ease = "linear"
  )
  expect_equal(s$from, "center")
  expect_equal(s$grid, c(3L, 4L))
  expect_equal(s$axis, "x")
  expect_equal(s$ease, "linear")
})

test_that("stagger_to_js() produces correct list for simple stagger", {
  s <- anime_stagger(100, from = "first")
  result <- stagger_to_js(s)
  expect_equal(result$value, 100)
  expect_null(result$from) # Omits 'from' when it is 'first' (the JS default)
  expect_null(result$grid)
  expect_null(result$axis)
})

test_that("stagger_to_js() includes 'from' when not 'first'", {
  s <- anime_stagger(100, from = "center")
  result <- stagger_to_js(s)
  expect_equal(result$from, "center")
})

test_that("stagger_to_js() includes grid and axis when provided", {
  s <- anime_stagger(50, grid = c(2L, 3L), axis = "y")
  result <- stagger_to_js(s)
  expect_equal(result$grid, c(2L, 3L))
  expect_equal(result$axis, "y")
})

test_that("stagger_to_js() includes easing when provided", {
  s <- anime_stagger(100, ease = "inQuad")
  result <- stagger_to_js(s)
  expect_equal(result$ease, "inQuad")
})
