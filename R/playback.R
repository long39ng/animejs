#' Configure timeline playback
#'
#' Sets autoplay, loop, direction, and optional controls UI on an
#' `anime_timeline`.
#'
#' @param timeline An `anime_timeline` object.
#' @param autoplay Logical. Start playing immediately on load.
#' @param controls Logical. Inject a play/pause/seek control bar into the
#'   widget container.
#' @inheritParams anime_timeline
#'
#' @return The modified `anime_timeline` object (visibly).
#' @export
anime_playback <- function(
  timeline,
  autoplay = TRUE,
  loop = FALSE,
  direction = c("normal", "reverse", "alternate"),
  controls = FALSE
) {
  stopifnot(inherits(timeline, "anime_timeline"))
  direction <- rlang::arg_match(direction)

  timeline$autoplay <- autoplay
  timeline$loop <- loop
  timeline$direction <- direction
  timeline$controls <- controls

  timeline
}
