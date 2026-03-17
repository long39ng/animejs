test_that("animejs_widget() returns an animejs htmlwidget", {
  w <- animejs_widget(
    svg = "<svg></svg>",
    timeline_config = list()
  )
  expect_s3_class(w, "animejs")
  expect_s3_class(w, "htmlwidget")
})

test_that("animejs_widget() returns stores svg_contnt under $x$svg", {
  svg <- "<svg><circle r='10'/></svg>"
  w <- animejs_widget(svg = svg, timeline_config = list())
  expect_identical(w$x$svg, svg)
})

test_that("animejs_widget() stores timeline_config under $x$config as a list", {
  cfg <- list(defaults = list(duration = 1000), loop = FALSE, segments = list())
  w <- animejs_widget(svg = "", timeline_config = cfg)
  expect_type(w$x$config, "list")
  expect_identical(w$x$config, cfg)
})

test_that("animejs_widget() passes width and height to the widget", {
  w <- animejs_widget(
    svg = "",
    timeline_config = list(),
    width = 400,
    height = 200
  )
  expect_equal(w$width, 400)
  expect_equal(w$height, 200)
})

test_that("animejs_widget() coerces NULL svg to an empty string", {
  w <- animejs_widget(svg = NULL, timeline_config = list())
  expect_identical(w$x$svg, "")
})
