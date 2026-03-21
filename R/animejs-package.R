#' animejs: R Bindings to the Anime.js Animation Library
#'
#' @description
#' `animejs` provides a pipe-friendly R interface to
#' [Anime.js v4](https://animejs.com/), a JavaScript animation library.
#' Timelines are authored in R and serialised to JSON; the htmlwidgets
#' infrastructure renders them in a browser environment.
#'
#' The central workflow is:
#'
#' 1. Create a timeline with [anime_timeline()].
#' 2. Add animation segments with [anime_add()].
#' 3. Configure playback with [anime_playback()] and attach event callbacks
#'    with [anime_on()].
#' 4. Render to an htmlwidget with [anime_render()].
#'
#' Property values are specified via [anime_from_to()] and [anime_keyframes()].
#' Per-element delay offsets are specified via [anime_stagger()].
#' Easing functions are specified via the `anime_easing_*()` family.
#' Target selectors are constructed via the `anime_target_*()` family.
#'
#' @section Package options:
#' None currently. All configuration is per-timeline.
#'
#' @keywords internal
"_PACKAGE"
