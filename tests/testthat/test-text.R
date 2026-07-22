# anime_text() ------------------------------------------------------------

test_that("anime_text() returns an anime_text object", {
  expect_s3_class(anime_text(c("a", "b")), "anime_text")
})

test_that("anime_text() stores the type tag and character values", {
  txt <- anime_text(c("a", "b", "c"))
  expect_equal(txt$type, "text")
  expect_identical(txt$values, c("a", "b", "c"))
})

test_that("anime_text() coerces non-character values to character", {
  txt <- anime_text(c(0, 25, 50))
  expect_identical(txt$values, c("0", "25", "50"))
})

test_that("anime_text() accepts a single value", {
  expect_identical(anime_text("only")$values, "only")
})

test_that("anime_text() rejects non-atomic or empty input", {
  expect_snapshot(error = TRUE, anime_text(list("a", "b")))
  expect_snapshot(error = TRUE, anime_text(character(0)))
  expect_snapshot(error = TRUE, anime_text())
})

test_that("text_to_js() serialises to a tagged list with an array of values", {
  expect_identical(
    text_to_js(anime_text(c("a", "b"))),
    list(type = "text", values = list("a", "b"))
  )
})

test_that("text_to_js() keeps a single value as a length-1 array", {
  serialised <- text_to_js(anime_text("only"))
  expect_identical(serialised$values, list("only"))
})

test_that("to_js_props() routes anime_text through text_to_js()", {
  result <- to_js_props(list(label = anime_text(c("x", "y"))))
  expect_equal(result$label, list(type = "text", values = list("x", "y")))
})

test_that("to_js_props() keeps text and tween props side by side", {
  result <- to_js_props(list(
    opacity = anime_from_to(0, 1),
    label = anime_text(c("x", "y"))
  ))
  expect_equal(result$opacity, list(from = 0, to = 1))
  expect_equal(result$label$type, "text")
})

test_that("anime_render() config round-trips anime_text through JSON", {
  skip_if_not_installed("jsonlite")

  tl <- anime_timeline(duration = 1000) |>
    anime_add(
      selector = anime_target_id("counter"),
      props = list(label = anime_text(c("0", "50", "100")))
    )
  widget <- anime_render(tl)

  json <- jsonlite::toJSON(widget$x$config, auto_unbox = TRUE)
  parsed <- jsonlite::fromJSON(json, simplifyVector = FALSE)

  label <- parsed$segments[[1]]$props$label
  expect_equal(label$type, "text")
  expect_length(label$values, 3L)
  expect_equal(label$values[[1]], "0")
  expect_equal(label$values[[3]], "100")
})

test_that("anime_render() keeps a single text value as a JSON array", {
  skip_if_not_installed("jsonlite")

  tl <- anime_timeline() |>
    anime_add(
      selector = anime_target_id("counter"),
      props = list(label = anime_text("only"))
    )
  widget <- anime_render(tl)

  json <- jsonlite::toJSON(widget$x$config, auto_unbox = TRUE)
  parsed <- jsonlite::fromJSON(json, simplifyVector = FALSE)

  label <- parsed$segments[[1]]$props$label
  expect_length(label$values, 1L)
  expect_equal(label$values[[1]], "only")
})
