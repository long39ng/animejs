test_that("anime_render() returns an htmlwidget", {
  tl <- anime_timeline()
  widget <- anime_render(tl)
  expect_s3_class(widget, "htmlwidget")
  expect_s3_class(widget, "animejs")
})

test_that("anime_render() with svg = NULL sets x$svg to empty string", {
  tl <- anime_timeline()
  widget <- anime_render(tl, svg = NULL)
  expect_equal(widget$x$svg, "")
})

test_that("anime_render() passes svg content through to x$svg", {
  svg <- '<svg viewBox="0 0 100 100"><circle cx="50" cy="50" r="10"/></svg>'
  tl <- anime_timeline()
  widget <- anime_render(tl, svg = svg)
  expect_equal(widget$x$svg, svg)
})

test_that("anime_render() renders anime_animation objects", {
  anim <- anime_animate(selector = ".dot", props = list(opacity = c(0, 1)))
  widget <- anime_render(anim)
  expect_s3_class(widget, "animejs")
  expect_identical(widget$x$config$kind, "animation")
})

test_that("anime_render() errors informatively on unsupported input", {
  expect_snapshot(error = TRUE, anime_render(list()))
  expect_snapshot(error = TRUE, anime_render("not a timeline"))
})

test_that("anime_render() config round-trips through JSON correctly", {
  skip_if_not_installed("jsonlite")

  tl <- anime_timeline(duration = 800, ease = "outQuad") |>
    anime_add(
      selector = anime_target_id("c1"),
      props = list(opacity = anime_from_to(0, 1)),
      offset = "+=0"
    )
  widget <- anime_render(tl)
  config <- widget$x$config

  json <- jsonlite::toJSON(config, auto_unbox = TRUE)
  parsed <- jsonlite::fromJSON(json, simplifyVector = FALSE)

  expect_equal(parsed$kind, "timeline")
  expect_equal(parsed$defaults$duration, 800)
  expect_equal(parsed$defaults$ease, "outQuad")
  expect_length(parsed$segments, 1L)
  expect_equal(parsed$segments[[1]]$selector, "[data-animejs-id='c1']")
})

test_that("anime_render() config serialises anime_from_to to {from, to}", {
  skip_if_not_installed("jsonlite")

  tl <- anime_timeline() |>
    anime_add(
      selector = anime_target_class("bar"),
      props = list(
        opacity = anime_from_to(0, 1),
        width = anime_from_to(0, 200, unit = "px")
      )
    )
  widget <- anime_render(tl)
  config <- widget$x$config

  json <- jsonlite::toJSON(config, auto_unbox = TRUE)
  parsed <- jsonlite::fromJSON(json, simplifyVector = FALSE)

  props <- parsed$segments[[1]]$props
  expect_equal(props$opacity$from, 0)
  expect_equal(props$opacity$to, 1)
  expect_equal(props$width$from, "0px")
  expect_equal(props$width$to, "200px")
})

test_that("anime_render() config serialises anime_keyframes to array of {to} objects", {
  skip_if_not_installed("jsonlite")

  tl <- anime_timeline() |>
    anime_add(
      selector = anime_target_class("dot"),
      props = list(translateY = anime_keyframes(0, -30, 0))
    )
  widget <- anime_render(tl)
  config <- widget$x$config

  json <- jsonlite::toJSON(config, auto_unbox = TRUE)
  parsed <- jsonlite::fromJSON(json, simplifyVector = FALSE)

  kfs <- parsed$segments[[1]]$props$translateY
  expect_length(kfs, 3L)
  expect_equal(kfs[[1]]$to, 0)
  expect_equal(kfs[[2]]$to, -30)
  expect_equal(kfs[[3]]$to, 0)
})

test_that("anime_render() config serialises keyframe-level easing", {
  skip_if_not_installed("jsonlite")

  tl <- anime_timeline() |>
    anime_add(
      selector = anime_target_class("dot"),
      props = list(
        translateY = anime_keyframes(
          list(to = -30, ease = anime_easing_spring()),
          list(to = 0, ease = "outQuad")
        )
      )
    )
  widget <- anime_render(tl)

  json <- jsonlite::toJSON(widget$x$config, auto_unbox = TRUE)
  parsed <- jsonlite::fromJSON(json, simplifyVector = FALSE)

  kfs <- parsed$segments[[1]]$props$translateY
  expect_equal(
    kfs[[1]]$ease,
    list(type = "spring", bounce = 0.5, duration = 628)
  )
  expect_equal(kfs[[2]]$ease, "outQuad")
})

test_that("anime_render() config serialises segment and stagger easing", {
  skip_if_not_installed("jsonlite")

  tl <- anime_timeline() |>
    anime_add(
      selector = anime_target_class("dot"),
      props = list(opacity = anime_from_to(0, 1)),
      ease = anime_easing_bezier(0.4, 0, 0.2, 1),
      stagger = anime_stagger(100, ease = anime_easing_steps(4))
    )
  widget <- anime_render(tl)

  json <- jsonlite::toJSON(widget$x$config, auto_unbox = TRUE)
  parsed <- jsonlite::fromJSON(json, simplifyVector = FALSE)

  segment <- parsed$segments[[1]]
  expect_equal(
    segment$ease,
    list(type = "cubicBezier", args = list(0.4, 0, 0.2, 1))
  )
  expect_equal(
    segment$stagger$ease,
    list(type = "steps", count = 4, fromStart = FALSE)
  )
})

test_that("anime_render() config serialises anime_stagger with from omitted when 'first'", {
  skip_if_not_installed("jsonlite")

  tl <- anime_timeline() |>
    anime_add(
      selector = anime_target_class("circle"),
      props = list(opacity = anime_from_to(0, 1)),
      stagger = anime_stagger(100)
    )
  widget <- anime_render(tl)
  config <- widget$x$config

  json <- jsonlite::toJSON(config, auto_unbox = TRUE)
  parsed <- jsonlite::fromJSON(json, simplifyVector = FALSE)

  stagger <- parsed$segments[[1]]$stagger
  expect_equal(stagger$value, 100)
  expect_null(stagger$from)
})

test_that("anime_render() config serialises anime_stagger with from = 'center' included", {
  skip_if_not_installed("jsonlite")

  tl <- anime_timeline() |>
    anime_add(
      selector = anime_target_class("circle"),
      props = list(opacity = anime_from_to(0, 1)),
      stagger = anime_stagger(100, from = "center")
    )
  widget <- anime_render(tl)
  config <- widget$x$config

  json <- jsonlite::toJSON(config, auto_unbox = TRUE)
  parsed <- jsonlite::fromJSON(json, simplifyVector = FALSE)

  expect_equal(parsed$segments[[1]]$stagger$from, "center")
})
