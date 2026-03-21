#' Specify per-property keyframes for an animation
#'
#' Constructs a keyframes object for use in the `props` argument of
#' [anime_add()]. Each positional argument is one keyframe.
#'
#' @param ... Keyframe values. Either bare numeric values, or lists each with
#'   a `$to` key and optional `$ease` and `$duration` overrides.
#'
#' @return An `anime_keyframes` object.
#'
#' @examples
#' # Bare numeric keyframe values
#' anime_add(
#'   anime_timeline(),
#'   selector = ".circle",
#'   props = list(
#'     opacity = anime_keyframes(0, 1, 0.5),
#'     translateY = anime_keyframes(-20, 0, 10)
#'   )
#' )
#'
#' # Per-keyframe lists with optional ease and duration overrides
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
#' Convenience constructor for a two-value property animation that runs from
#' `from` to `to`. An optional CSS unit suffix is concatenated into both
#' values during serialisation (e.g. `100` with `unit = "px"` becomes
#' `"100px"`).
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
