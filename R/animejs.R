#' Create a bare animejs htmlwidget
#'
#' This is the low-level constructor. Most users will not call this directly;
#' it is the final rendering step called by [anime_render()].
#'
#' @param svg Character. Raw SVG markup to embed in the widget. If `NULL`, an
#'   empty string is used (the animation will run against existing DOM
#'   content -- advanced use only).
#' @param config List. A serialisable animation specification produced by
#'   [anime_timeline()] or [anime_animate()] and their modifiers, then
#'   serialised by [anime_render()].
#' @inheritParams htmlwidgets::createWidget
#'
#' @return An object of class `c("animejs", "htmlwidget")`.
#' @export
animejs_widget <- function(
  svg,
  config,
  width = NULL,
  height = NULL,
  elementId = NULL
) {
  svg <- svg %||% ""
  check_string(svg, "svg")
  if (!is.list(config)) {
    cli::cli_abort(
      c(
        "{.arg config} must be a list.",
        x = "You supplied {.obj_type_friendly {config}}."
      )
    )
  }

  x <- list(
    svg = svg,
    config = config
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

#' Render an animation or timeline as an htmlwidget
#'
#' Serialises an [anime_timeline()] or [anime_animate()] object to JSON and
#' wraps it together with an SVG payload in an htmlwidget.
#'
#' @param x An `anime_timeline` object produced by [anime_timeline()], or an
#'   `anime_animation` object produced by [anime_animate()].
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
  x,
  svg = NULL,
  width = NULL,
  height = NULL,
  elementId = NULL
) {
  check_anime_object(x)

  config <- if (inherits(x, "anime_timeline")) {
    timeline_to_json_config(x)
  } else {
    animation_to_json_config(x)
  }

  animejs_widget(
    svg = svg %||% "",
    config = config,
    width = width,
    height = height,
    elementId = elementId
  )
}
