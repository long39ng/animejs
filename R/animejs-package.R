#' animejs: R Bindings to the Anime.js Animation Library
#'
#' @description
#' `animejs` provides a pipe-friendly R interface to
#' [Anime.js v4](https://animejs.com/), a JavaScript animation library.
#' Animations are authored in R and serialised to JSON; the htmlwidgets
#' infrastructure renders them in a browser environment.
#'
#' The central workflow is:
#'
#' 1. Create a single animation with [anime_animate()], or a timeline with
#'    [anime_timeline()] and add segments to it with [anime_add()].
#' 2. Configure playback with [anime_playback()] and attach event callbacks
#'    with [anime_on()].
#' 3. Render to an htmlwidget with [anime_render()].
#'
#' Property values are specified via [anime_from_to()] and [anime_keyframes()].
#' Per-element delay offsets are specified via [anime_stagger()].
#' Easing functions are specified via the `anime_easing_*()` family.
#' Target selectors are constructed via the `anime_target_*()` family.
#' In Shiny applications, use [animejsOutput()] and [renderAnimejs()].
#'
#' @section Package options:
#' None currently. All configuration is per-animation.
#'
#' @importFrom rlang %||%
#' @keywords internal
"_PACKAGE"
