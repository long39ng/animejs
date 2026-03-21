#' Specify per-property keyframes for `anime_add()`
#'
#' @param ... Keyframe values. Either bare numeric values, or lists each with
#'   a `$to` key and optional `$ease` and `$duration` overrides.
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
#' # Form 2: per-keyframe lists with optional ease and duration overrides
#' anime_add(
#'   anime_timeline(),
#'   selector = ".circle",
#'   props = list(
#'     opacity = anime_keyframes(
#'       list(to = 0),
#'       list(to = 1, ease = anime_easing("Cubic"), duration = 400),
#'       list(to = 0.5, ease = "linear", duration = 200)
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
