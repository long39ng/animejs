# Easing name vectors -----------------------------------------------------

.EASING_DIRECTION <- c("in", "out", "inOut", "outIn")

.EASING_FAMILY_SIMPLE <- c(
  "Quad",
  "Cubic",
  "Quart",
  "Quint",
  "Sine",
  "Expo",
  "Circ",
  "Bounce"
)

.EASING_SIMPLE <- c(
  "linear",
  as.vector(outer(.EASING_DIRECTION, .EASING_FAMILY_SIMPLE, paste0))
)
.EASING_ELASTIC <- stats::setNames(
  paste0(.EASING_DIRECTION, "Elastic"),
  .EASING_DIRECTION
)
.EASING_BACK <- stats::setNames(
  paste0(.EASING_DIRECTION, "Back"),
  .EASING_DIRECTION
)

# Constructor helper ------------------------------------------------------

new_easing <- function(name, params) {
  structure(list(name = name, params = params), class = "anime_easing")
}

# Per-family constructors -------------------------------------------------

#' Easing constructors
#'
#' A family of constructors for Anime.js v4 easing specifications. Each
#' returns an `anime_easing` object that serialises to the corresponding
#' Anime.js v4 easing inside [anime_timeline()], [anime_add()],
#' [anime_animate()], or [anime_playback()].
#'
#' Plain Anime.js v4 easing name strings (e.g. `"inOutSine"`,
#' `"outElastic(1,0.3)"`) are also accepted wherever an `anime_easing` object
#' is expected. Note that Anime.js v4 has removed the string syntax for
#' `cubicBezier()`, `steps()`, and spring easings; use the constructors below
#' for those, and the widget reconstructs the corresponding function calls in
#' JavaScript.
#'
#' @param family Character. One of "linear",
#'   `r paste0(paste0('"', .EASING_FAMILY_SIMPLE, '"'), collapse = ", ")`.
#' @param direction Character. One of
#'   `r paste0(paste0('"', .EASING_DIRECTION, '"'), collapse = ", ")`.
#' @param amplitude,period **(Elastic easing)** Numeric. Overshoot amplitude
#'  in \[1, 10\] and oscillation period in (0, 2\].
#' @param overshoot **(Back easing)** Numeric. Overshoot amount.
#' @param x1,y1,x2,y2 **(Cubic bezier easing)** Coordinates of the first and
#'  second control point. `x1` and `x2` must be in \[0, 1\].
#' @param count **(Steps easing)** Positive integer. Number of discrete steps.
#' @param from_start **(Steps easing)** Logical. If `TRUE`, the value jumps at
#'   the start of each step instead of the end (CSS `jump-start` vs
#'   `jump-end`).
#' @param bounce **(Spring easing)** Number in \[-1, 1\]. Controls bounciness.
#'   Values from 0 to 1 produce bouncy curves; values below 0 produce
#'   over-damped curves. Keep within \[-0.5, 0.5\] for predictable behaviour.
#' @param duration **(Spring easing)** Number in \[10, 10000\]. The perceived
#'   duration in milliseconds at which the animation feels visually complete.
#'
#' @return An `anime_easing` object.
#'
#' @examples
#' anime_easing("linear")
#' anime_easing("Quad", "outIn")
#'
#' anime_easing_elastic()
#' anime_easing_elastic("in", amplitude = 1.5, period = 0.3)
#'
#' anime_easing_back()
#' anime_easing_back("in", overshoot = 2.5)
#'
#' anime_easing_bezier(0.4, 0, 0.2, 1)
#' anime_easing_bezier(0.68, -0.55, 0.265, 1.55)
#'
#' anime_easing_steps(10)
#' anime_easing_steps(5, from_start = TRUE)
#'
#' anime_easing_spring()
#' anime_easing_spring(bounce = 0.65, duration = 350)
#'
#' @name anime_easing
NULL

#' @rdname anime_easing
#' @export
anime_easing <- function(family = "Quad", direction = "out") {
  family <- rlang::arg_match(family, c("linear", .EASING_FAMILY_SIMPLE))
  direction <- rlang::arg_match(direction, .EASING_DIRECTION)
  if (family == "linear") {
    return(new_easing("linear", list()))
  }
  new_easing(paste0(direction, family), list())
}

#' @rdname anime_easing
#' @export
anime_easing_elastic <- function(
  direction = "out",
  amplitude = 1,
  period = 0.3
) {
  direction <- rlang::arg_match(direction, .EASING_DIRECTION)
  check_number(amplitude, "amplitude", min = 1, max = 10)
  check_number(period, "period", min = 0, max = 2)
  new_easing(
    .EASING_ELASTIC[[direction]],
    list(amplitude = amplitude, period = period)
  )
}

#' @rdname anime_easing
#' @export
anime_easing_back <- function(direction = "out", overshoot = 1.70158) {
  direction <- rlang::arg_match(direction, .EASING_DIRECTION)
  check_number(overshoot, "overshoot")
  new_easing(
    .EASING_BACK[[direction]],
    list(overshoot = overshoot)
  )
}

#' @rdname anime_easing
#' @export
anime_easing_bezier <- function(x1, y1, x2, y2) {
  rlang::check_required(x1)
  rlang::check_required(y1)
  rlang::check_required(x2)
  rlang::check_required(y2)
  check_number(x1, "x1", min = 0, max = 1)
  check_number(y1, "y1")
  check_number(x2, "x2", min = 0, max = 1)
  check_number(y2, "y2")
  new_easing("cubicBezier", list(x1 = x1, y1 = y1, x2 = x2, y2 = y2))
}

#' @rdname anime_easing
#' @export
anime_easing_steps <- function(count, from_start = FALSE) {
  rlang::check_required(count)
  check_count(count, "count")
  check_bool(from_start, "from_start")
  new_easing(
    "steps",
    list(count = as.integer(count), from_start = from_start)
  )
}

#' @rdname anime_easing
#' @export
anime_easing_spring <- function(bounce = 0.5, duration = 628) {
  check_number(bounce, "bounce", min = -1, max = 1)
  check_number(duration, "duration", min = 10, max = 10000)
  new_easing("spring", list(bounce = bounce, duration = duration))
}
