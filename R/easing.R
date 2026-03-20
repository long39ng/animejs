#' Built-in Anime.js v4 easing identifiers
#'
#' A character vector of all named easing functions supported by Anime.js v4.
#' Pass any element as the `ease` argument to [anime_timeline()],
#' [anime_add()], or [anime_playback()]. For parametric easings use
#' [anime_easing_bezier()] or [anime_easing_spring()].
#'
#' @note `steps(n)` is not included because it requires a numeric argument and
#'   cannot be used as a bare string. Construct it manually,
#'   e.g. `"steps(10)"`.
#'
#' @export
ANIME_EASINGS <- c(
  "linear",
  "easeInSine",
  "easeOutSine",
  "easeInOutSine",
  "easeInQuad",
  "easeOutQuad",
  "easeInOutQuad",
  "easeInCubic",
  "easeOutCubic",
  "easeInOutCubic",
  "easeInQuart",
  "easeOutQuart",
  "easeInOutQuart",
  "easeInQuint",
  "easeOutQuint",
  "easeInOutQuint",
  "easeInExpo",
  "easeOutExpo",
  "easeInOutExpo",
  "easeInCirc",
  "easeOutCirc",
  "easeInOutCirc",
  "easeInBack",
  "easeOutBack",
  "easeInOutBack",
  "easeInElastic",
  "easeOutElastic",
  "easeInOutElastic",
  "easeInBounce",
  "easeOutBounce",
  "easeInOutBounce"
)

#' Specify a cubic bezier easing
#'
#' Constructs the Anime.js v4 `cubicBezier(x1, y1, x2, y2)` easing string.
#' X coordinates of both control points are validated against \[0, 1\] in R
#' rather than deferred to Anime.js, so that out-of-range values produce an
#' immediate, descriptive error at timeline construction time rather than a
#' silent visual glitch in the browser.
#'
#' @param x1,y1 Coordinates of the first control point. `x1` must be in
#'   \[0, 1\].
#' @param x2,y2 Coordinates of the second control point. `x2` must be in
#'   \[0, 1\].
#'
#' @return A character string of the form `"cubicBezier(x1,y1,x2,y2)"`.
#'
#' @examples
#' anime_easing_bezier(0.4, 0, 0.2, 1) # Material Design standard curve
#' anime_easing_bezier(0.68, -0.55, 0.265, 1.55) # Back overshoot
#'
#' @export
anime_easing_bezier <- function(x1, y1, x2, y2) {
  if (!is.numeric(x1) || length(x1) != 1L || x1 < 0 || x1 > 1) {
    rlang::abort(
      paste0("`x1` must be a single numeric value in [0, 1], not ", x1, "."),
      call = rlang::caller_env()
    )
  }
  if (!is.numeric(x2) || length(x2) != 1L || x2 < 0 || x2 > 1) {
    rlang::abort(
      paste0("`x2` must be a single numeric value in [0, 1], not ", x2, "."),
      call = rlang::caller_env()
    )
  }
  sprintf("cubicBezier(%s,%s,%s,%s)", x1, y1, x2, y2)
}

#' Specify a spring physics easing
#'
#' Constructs the Anime.js v4 `spring(mass, stiffness, damping, velocity)`
#' easing string.
#'
#' @param mass Numeric. Object mass.
#' @param stiffness Numeric. Spring stiffness.
#' @param damping Numeric. Damping coefficient.
#' @param velocity Numeric. Initial velocity.
#'
#' @return A character string of the form
#'   `"spring(mass,stiffness,damping,velocity)"`.
#'
#' @examples
#' anime_easing_spring()
#' anime_easing_spring(mass = 2, stiffness = 80, damping = 5, velocity = 1)
#'
#' @export
anime_easing_spring <- function(
  mass = 1,
  stiffness = 100,
  damping = 10,
  velocity = 0
) {
  sprintf("spring(%s,%s,%s,%s)", mass, stiffness, damping, velocity)
}
