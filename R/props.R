#' Specify per-property keyframes for an animation
#'
#' Constructs a keyframes object for use in the `props` argument of
#' [anime_add()] or [anime_animate()]. Each positional argument is one
#' keyframe.
#'
#' @param ... <[`dynamic-dots`][rlang::dyn-dots]> Keyframe values. Either bare
#'   atomic values, or lists each with a `$to` key and optional `$ease`,
#'   `$duration`, and `$delay` overrides. `$ease` accepts an `anime_easing`
#'   object or an Anime.js easing name string.
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
  frames <- rlang::list2(...)
  for (i in seq_along(frames)) {
    frame <- frames[[i]]
    if (rlang::is_scalar_atomic(frame)) {
      next
    }
    if (!is.list(frame) || is.null(frame$to)) {
      cli::cli_abort(
        c(
          "Each keyframe must be a bare atomic value or a list with a
           {.field to} element.",
          x = "Keyframe {i} is {.obj_type_friendly {frame}}."
        )
      )
    }
    check_ease(frame$ease, arg = "ease")
  }
  structure(frames, class = "anime_keyframes")
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
#' @param unit Character. Optional CSS unit suffix, e.g. `"px"`, `"%"`,
#'   `"deg"`.
#' @param ease Optional easing override for this property alone, an
#'   `anime_easing` object or an Anime.js easing name string.
#'
#' @return An `anime_from_to` object.
#'
#' @examples
#' anime_from_to(0, 1)
#' anime_from_to(0, 360, unit = "deg")
#' anime_from_to(0, 1, ease = anime_easing_spring())
#'
#' @export
anime_from_to <- function(from, to, unit = "", ease = NULL) {
  rlang::check_required(from)
  rlang::check_required(to)
  if (!is.null(unit)) {
    check_string(unit, "unit")
  }
  check_ease(ease)
  structure(
    list(from = from, to = to, unit = unit, ease = ease),
    class = "anime_from_to"
  )
}
