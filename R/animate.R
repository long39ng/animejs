#' Create a single Anime.js animation
#'
#' The R equivalent of Anime.js v4's `animate(targets, parameters)`: one set
#' of property animations applied to one target selector, without a timeline.
#' Use [anime_timeline()] and [anime_add()] instead when several segments must
#' be sequenced.
#'
#' Like a timeline, an `anime_animation` can be modified with
#' [anime_playback()] and [anime_on()], and is rendered with [anime_render()].
#'
#' @inheritParams anime_add
#' @param duration Duration in milliseconds. `NULL` uses the Anime.js default.
#' @param ease Easing, an `anime_easing` object or an Anime.js easing name
#'   string. `NULL` uses the Anime.js default.
#' @param delay Delay in milliseconds before the animation starts. `NULL` uses
#'   the Anime.js default.
#' @param loop Logical or positive integer. `FALSE` for no looping, `TRUE` for
#'   infinite looping, or a fixed number of iterations.
#' @param alternate Logical. Alternate direction on each iteration.
#' @param reversed Logical. Play in reverse from the end.
#' @param autoplay Logical. Start playing immediately on load.
#'
#' @examples
#' anime_animate(
#'   selector = anime_target_class("circle"),
#'   props = list(
#'     translateY = anime_from_to(-40, 0),
#'     opacity = anime_from_to(0, 1)
#'   ),
#'   duration = 600,
#'   ease = anime_easing_spring()
#' )
#'
#' @return An `anime_animation` object.
#' @export
anime_animate <- function(
  selector,
  props,
  duration = NULL,
  ease = NULL,
  delay = NULL,
  loop = FALSE,
  alternate = FALSE,
  reversed = FALSE,
  autoplay = TRUE,
  stagger = NULL
) {
  check_string(selector, "selector")
  check_props(props)
  if (!is.null(duration)) {
    validate_duration(duration, "duration")
  }
  check_ease(ease)
  if (!is.null(delay)) {
    validate_duration(delay, "delay")
  }
  check_loop(loop)
  check_bool(alternate, "alternate")
  check_bool(reversed, "reversed")
  check_bool(autoplay, "autoplay")
  check_stagger(stagger)

  structure(
    list(
      selector = selector,
      props = props,
      duration = duration,
      ease = ease,
      delay = delay,
      loop = loop,
      alternate = alternate,
      reversed = reversed,
      autoplay = autoplay,
      stagger = stagger,
      events = list()
    ),
    class = "anime_animation"
  )
}
