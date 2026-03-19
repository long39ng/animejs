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

test_that("anime_render() errors informatively on non-anime_timeline input", {
  expect_error(anime_render(list()), regexp = "anime_timeline")
  expect_error(anime_render("not a timeline"), regexp = "anime_timeline")
})

test_that("anime_render() config round-trips through JSON correctly", {
  skip_if_not_installed("jsonlite")

  tl <- anime_timeline(duration = 800, easing = "easeOutQuad") |>
    anime_add(
      selector = anime_target_id("c1"),
      props = list(opacity = anime_from_to(0, 1)),
      offset = "+=0"
    )
  widget <- anime_render(tl)
  config <- widget$x$config

  json <- jsonlite::toJSON(config, auto_unbox = TRUE)
  parsed <- jsonlite::fromJSON(json, simplifyVector = FALSE)

  expect_equal(parsed$defaults$duration, 800)
  expect_equal(parsed$defaults$easing, "easeOutQuad")
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
