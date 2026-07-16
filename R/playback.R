#' Configure animation playback
#'
#' Sets autoplay, looping, direction, speed, and optional controls UI on an
#' `anime_timeline` or `anime_animation`. Arguments left as `NULL` keep the
#' settings already stored on the object.
#'
#' @param x An `anime_timeline` or `anime_animation` object.
#' @param autoplay Logical. Start playing immediately on load.
#' @param loop Logical or positive integer. `FALSE` for no looping, `TRUE` for
#'   infinite looping, or a fixed number of iterations.
#' @param loop_delay Numeric. Delay in milliseconds between iterations.
#' @param playback_rate Numeric. Playback speed multiplier (1 is normal
#'   speed).
#' @param reversed Logical. Play in reverse from the end.
#' @param alternate Logical. Alternate direction on each iteration (requires
#'   `loop` to be `TRUE` or a positive integer to have any visible effect).
#' @param controls Logical. Inject a play/pause/seek control bar into the
#'   widget container.
#'
#' @examples
#' anime_timeline() |>
#'   anime_playback(loop = TRUE, alternate = TRUE, controls = TRUE)
#'
#' @return The modified `anime_timeline` or `anime_animation` object.
#' @export
anime_playback <- function(
  x,
  autoplay = NULL,
  loop = NULL,
  loop_delay = NULL,
  playback_rate = NULL,
  reversed = NULL,
  alternate = NULL,
  controls = NULL
) {
  check_anime_object(x)

  if (!is.null(autoplay)) {
    check_bool(autoplay, "autoplay")
    x$autoplay <- autoplay
  }
  if (!is.null(loop)) {
    check_loop(loop)
    x$loop <- loop
  }
  if (!is.null(loop_delay)) {
    validate_duration(loop_delay, "loop_delay")
    x$loop_delay <- loop_delay
  }
  if (!is.null(playback_rate)) {
    check_number(playback_rate, "playback_rate", min = 0)
    x$playback_rate <- playback_rate
  }
  if (!is.null(reversed)) {
    check_bool(reversed, "reversed")
    x$reversed <- reversed
  }
  if (!is.null(alternate)) {
    check_bool(alternate, "alternate")
    x$alternate <- alternate
  }
  if (!is.null(controls)) {
    check_bool(controls, "controls")
    x$controls <- controls
  }

  x
}
