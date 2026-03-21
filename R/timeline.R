#' Initialise an Anime.js timeline
#'
#' @param duration Default duration in milliseconds for all segments.
#' @param ease Default easing for all segments.
#' @param delay Default delay in milliseconds between segments.
#' @inheritParams anime_playback
#'
#' @return An `anime_timeline` object.
#' @export
anime_timeline <- function(
  duration = 1000,
  ease = anime_easing(),
  delay = 0,
  loop = FALSE
) {
  structure(
    list(
      defaults = list(
        duration = duration,
        ease = ease,
        delay = delay
      ),
      loop = loop,
      segments = list(),
      events = list()
    ),
    class = "anime_timeline"
  )
}

#' Add an animation segment to a timeline
#'
#' Pipe-friendly. Each call appends one segment: a set of CSS property
#' animations applied to a target selector.
#'
#' @param timeline An `anime_timeline` object.
#' @param selector CSS selector string identifying the SVG/HTML elements to
#'   animate. Use `anime_target_*()` helpers to construct selectors.
#' @param props A named list of property animations. Values may be scalars,
#'   two-element vectors (from/to), or `anime_keyframes()` objects.
#' @param offset Timeline offset. `"+=N"` means N ms after the previous
#'   segment ends; a bare number is an absolute position in ms.
#' @param duration Overrides the timeline default for this segment.
#' @param ease Overrides the timeline default for this segment.
#' @param delay Overrides the timeline default for this segment.
#' @param stagger An `anime_stagger` object for per-element delay offsets.
#'
#' @return The modified `anime_timeline` object.
#' @export
anime_add <- function(
  timeline,
  selector,
  props,
  offset = "+=0",
  duration = NULL,
  ease = NULL,
  delay = NULL,
  stagger = NULL
) {
  stopifnot(inherits(timeline, "anime_timeline"))

  segment <- list(
    selector = selector,
    props = props,
    offset = offset
  )
  if (!is.null(duration)) {
    segment$duration <- duration
  }
  if (!is.null(ease)) {
    segment$ease <- ease
  }
  if (!is.null(delay)) {
    segment$delay <- delay
  }
  if (!is.null(stagger)) {
    segment$stagger <- stagger
  }

  timeline$segments <- c(timeline$segments, list(segment))
  timeline
}
