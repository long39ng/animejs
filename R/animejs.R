#' Create a bare animejs htmlwidget
#'
#' This is the low-level constructor. Most users will not call this directly;
#' it is the final rendering step called by [anime_render()].
#'
#' @param svg Character. Raw SVG markup to embed in the widget. If `NULL`, an
#'   empty string is used (the timeline will animate against existing DOM
#'   content -- advanced use only).
#' @param timeline_config List. A serialisable timeline specification produced
#'   by [anime_timeline()] and its modifiers, then passed through
#'   `timeline_to_json_config()`.
#' @inheritParams htmlwidgets::createWidget
#'
#' @return An object of class `c("animejs", "htmlwidget)`
#' @export
animejs_widget <- function(
  svg,
  timeline_config,
  width = NULL,
  height = NULL,
  elementId = NULL
) {
  svg <- svg %||% ""
  stopifnot(is.character(svg), length(svg) == 1L)
  stopifnot(is.list(timeline_config))

  x <- list(
    svg = svg,
    config = timeline_config
  )

  htmlwidgets::createWidget(
    name = "animejs",
    x = x,
    width = width,
    height = height,
    package = "animejs",
    elementId = elementId
  )
}

#' Render an anime_timeline as an htmlwidget
#'
#' Selialises an [anime_timeline()] object to JSON and wraps it together with
#' an SVG payload in an htmlwidget.
#'
#' @param timeline An `anime_timeline` object produced by [anime_timeline()].
#' @inheritParams animejs_widget
#'
#' @return An object of class `c("animejs", "htmlwidget")`.
#' @export
#'
#' @examples
#' tl <- anime_timeline(duration = 800) |>
#'   anime_add(
#'     selector = anime_target_class("dot"),
#'     props = list(opacity = anime_from_to(0, 1))
#'   )
#' svg <- '<svg viewBox="0 0 100 100"><circle class="dot" cx="50" cy="50" r="10"/></svg>'
#' if (interactive()) {
#'   anime_render(tl, svg)
#' }
anime_render <- function(
  timeline,
  svg = NULL,
  width = NULL,
  height = NULL,
  elementId = NULL
) {
  if (!inherits(timeline, "anime_timeline")) {
    rlang::abort(
      paste0(
        "`timeline` must be an `anime_timeline` object, not ",
        class(timeline)[[1L]],
        "."
      )
    )
  }

  config <- timeline_to_json_config(timeline)

  animejs_widget(
    svg = svg %||% "",
    timeline_config = config,
    width = width,
    height = height,
    elementId = elementId
  )
}
