#' Specify per-property keyframes for `anime_add()`
#'
#' @param ... Keyframe values. Either a sequence of bare numeric values, or a
#'   sequence of lists each with `$value` and optional `$easing` / `$duration`.
#'
#' @return An `anime_keyframes` object.
#'
#' @examples
#' # Form 1: bare numeric keyframe values
#' anime_add(
#'   anime_timeline(),
#'   selector = ".circle",
#'   props = list(
#'     opacity = anime_keyframes(0, 1, 0.5),
#'     translateY = anime_keyframes(-20, 0, 10)
#'   )
#' )
#'
#' # Form 2: per-keyframe lists with optional easing and duration overrides
#' anime_add(
#'   anime_timeline(),
#'   selector = ".circle",
#'   props = list(
#'     opacity = anime_keyframes(
#'       list(value = 0),
#'       list(value = 1, easing = "easeOutQuad", duration = 400),
#'       list(value = 0.5, easing = "linear", duration = 200)
#'     )
#'   )
#' )
#'
#' @export
anime_keyframes <- function(...) {
  structure(list(...), class = "anime_keyframes")
}

#' Specify a from/to property range
#'
#' A convenience wrapper over a plain two-element vector. Prefer this form when
#' the intent should be explicit or when a CSS unit suffix is required.
#'
#' @param from Numeric. Starting value.
#' @param to Numeric. Ending value.
#' @param unit Character. Optional CSS unit suffix, e.g. `"px"`, `"%"`, `"deg"`.
#'
#' @return An `anime_from_to` object.
#'
#' @examples
#' anime_from_to(0, 1)
#' anime_from_to(0, 360, unit = "deg")
#'
#' @export
anime_from_to <- function(from, to, unit = "") {
  structure(list(from = from, to = to, unit = unit), class = "anime_from_to")
}
