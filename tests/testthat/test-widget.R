test_that("animejs_widget() returns an animejs htmlwidget", {
  w <- animejs_widget(
    svg = "<svg></svg>",
    config = list()
  )
  expect_s3_class(w, "animejs")
  expect_s3_class(w, "htmlwidget")
})

test_that("animejs_widget() stores svg content under $x$svg", {
  svg <- "<svg><circle r='10'/></svg>"
  w <- animejs_widget(svg = svg, config = list())
  expect_identical(w$x$svg, svg)
})

test_that("animejs_widget() stores config under $x$config as a list", {
  cfg <- list(defaults = list(duration = 1000), loop = FALSE, segments = list())
  w <- animejs_widget(svg = "", config = cfg)
  expect_type(w$x$config, "list")
  expect_identical(w$x$config, cfg)
})

test_that("animejs_widget() passes width and height to the widget", {
  w <- animejs_widget(
    svg = "",
    config = list(),
    width = 400,
    height = 200
  )
  expect_equal(w$width, 400)
  expect_equal(w$height, 200)
})

test_that("animejs_widget() coerces NULL svg to an empty string", {
  w <- animejs_widget(svg = NULL, config = list())
  expect_identical(w$x$svg, "")
})

test_that("animejs_widget() validates its inputs", {
  expect_snapshot(error = TRUE, animejs_widget(svg = 1, config = list()))
  expect_snapshot(error = TRUE, animejs_widget(svg = "", config = "nope"))
})
