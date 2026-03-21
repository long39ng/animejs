#' Configure timeline playback
#'
#' Sets autoplay, loop, direction, and optional controls UI on an
#' `anime_timeline`. Calling this function overwrites any playback settings
#' already on the timeline (including the `loop` value set in
#' [anime_timeline()]).
#'
#' @param timeline An `anime_timeline` object.
#' @param autoplay Logical. Start playing immediately on load.
#' @param loop Logical or integer. `FALSE` for no looping, `TRUE` for infinite
#'   looping, or a positive integer for a fixed number of iterations.
#' @param reversed Logical. Play the timeline in reverse from the end.
#' @param alternate Logical. Alternate direction on each iteration (requires
#'   `loop` to be `TRUE` or a positive integer to have any visible effect).
#' @param controls Logical. Inject a play/pause/seek control bar into the
#'   widget container.
#'
#' @return The modified `anime_timeline` object.
#' @export
anime_playback <- function(
  timeline,
  autoplay = TRUE,
  loop = FALSE,
  reversed = FALSE,
  alternate = FALSE,
  controls = FALSE
) {
  stopifnot(inherits(timeline, "anime_timeline"))
  stopifnot(is.logical(autoplay), length(autoplay) == 1L)
  stopifnot(is.logical(reversed), length(reversed) == 1L)
  stopifnot(is.logical(alternate), length(alternate) == 1L)
  stopifnot(is.logical(controls), length(controls) == 1L)

  timeline$autoplay <- autoplay
  timeline$loop <- loop
  timeline$reversed <- reversed
  timeline$alternate <- alternate
  timeline$controls <- controls

  timeline
}
