# anime_keyframes() -------------------------------------------------------

test_that("anime_keyframes() returns an anime_keyframes object", {
  kf <- anime_keyframes(0, 1, 0.5)
  expect_s3_class(kf, "anime_keyframes")
})

test_that("anime_keyframes() stores bare numeric values as list elements", {
  kf <- anime_keyframes(0, 1, 0.5)
  expect_equal(kf[[1]], 0)
  expect_equal(kf[[2]], 1)
  expect_equal(kf[[3]], 0.5)
})

test_that("anime_keyframes() stores list-based keyframes as list elements", {
  kf <- anime_keyframes(
    list(to = 0),
    list(to = 1, ease = "easeOutQuad", duration = 400)
  )
  expect_s3_class(kf, "anime_keyframes")
  expect_equal(kf[[1]]$to, 0)
  expect_equal(kf[[2]]$to, 1)
})

test_that("anime_keyframes() preserves optional ease and duration per keyframe", {
  kf <- anime_keyframes(
    list(to = 0),
    list(to = 1, ease = "easeOutQuad", duration = 400),
    list(to = 0.5, ease = "linear", duration = 200)
  )
  expect_equal(kf[[2]]$ease, "easeOutQuad")
  expect_equal(kf[[2]]$duration, 400)
  expect_equal(kf[[3]]$ease, "linear")
  expect_equal(kf[[3]]$duration, 200)
})

test_that("to_js_props() passes list-based keyframes through with correct keys", {
  kf <- anime_keyframes(
    list(to = 0),
    list(to = 1, ease = "easeOutQuad", duration = 400)
  )
  result <- to_js_props(list(opacity = kf))
  expect_equal(result$opacity[[1]], list(to = 0))
  expect_equal(result$opacity[[2]]$to, 1)
  expect_equal(result$opacity[[2]]$ease, "easeOutQuad")
  expect_equal(result$opacity[[2]]$duration, 400)
})

test_that("to_js_props() handles mixed bare and list keyframes", {
  kf <- anime_keyframes(
    0,
    list(to = 1, ease = "easeOutQuad")
  )
  result <- to_js_props(list(opacity = kf))
  expect_equal(result$opacity[[1]], list(to = 0))
  expect_equal(result$opacity[[2]]$ease, "easeOutQuad")
})

# anime_from_to() ---------------------------------------------------------

test_that("anime_from_to() returns an anime_from_to object", {
  ft <- anime_from_to(0, 1)
  expect_s3_class(ft, "anime_from_to")
})

test_that("anime_from_to() stores from, to, and unit", {
  ft <- anime_from_to(0, 100, unit = "px")
  expect_equal(ft$from, 0)
  expect_equal(ft$to, 100)
  expect_equal(ft$unit, "px")
})

test_that("anime_from_to() defaults unit to empty string", {
  ft <- anime_from_to(0, 1)
  expect_equal(ft$unit, "")
})

test_that("to_js_props() converts anime_from_to to a from/to list", {
  ft <- anime_from_to(0, 1)
  result <- to_js_props(list(opacity = ft))
  expect_equal(result$opacity$from, 0)
  expect_equal(result$opacity$to, 1)
})

test_that("to_js_props() embeds unit into value strings for anime_from_to", {
  ft <- anime_from_to(0, 100, unit = "px")
  result <- to_js_props(list(x = ft))
  expect_equal(result$x$from, "0px")
  expect_equal(result$x$to, "100px")
})
