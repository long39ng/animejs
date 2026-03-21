# Internal registry -------------------------------------------------------

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
.EASING_ELASTIC <- setNames(
  paste0(.EASING_DIRECTION, "Elastic"),
  .EASING_DIRECTION
)
.EASING_BACK <- setNames(
  paste0(.EASING_DIRECTION, "Back"),
  .EASING_DIRECTION
)

.EASINGS <- list(
  simple = list(
    constructor = "anime_easing",
    names = .EASING_SIMPLE,
    params = list()
  ),
  elastic = list(
    constructor = "anime_easing_elastic",
    names = .EASING_ELASTIC,
    params = list(direction = "out", amplitude = 1, period = 0.5)
  ),
  back = list(
    constructor = "anime_easing_back",
    names = .EASING_BACK,
    params = list(direction = "out", overshoot = 1.70158)
  ),
  steps = list(
    constructor = "anime_easing_steps",
    names = "steps",
    params = list(count = NULL)
  ),
  spring = list(
    constructor = "anime_easing_spring",
    names = "spring",
    params = list(bounce = 0.5, duration = 628)
  ),
  bezier = list(
    constructor = "anime_easing_bezier",
    names = "cubicBezier",
    params = list(x1 = NULL, y1 = NULL, x2 = NULL, y2 = NULL)
  )
)

# Constructor helper ------------------------------------------------------

new_easing <- function(name, params) {
  structure(list(name = name, params = params), class = "anime_easing")
}

# Per-family constructors -------------------------------------------------

#' Easing constructors
#'
#' A family of constructors for Anime.js v4 easing specifications. Each
#' returns an `anime_easing` object that serialises to the correct JS string
#' inside [anime_timeline()], [anime_add()], or [anime_playback()].
#'
#' @param family Character. One of "linear",
#'   `r paste0(paste0('"', .EASING_FAMILY_SIMPLE, '"'), collapse = ", ")`.
#' @param direction Character. One of
#'   `r paste0(paste0('"', .EASING_DIRECTION, '"'), collapse = ", ")`.
#' @param amplitude,period **(Elastic easing)** Numeric. Overshoot amplitude
#'  and oscillation period.
#' @param overshoot **(Back easing)** Numeric. Overshoot amount.
#' @param x1,y1,x2,y2 **(Cubic bezier easing)** Coordinates of the first and
#'  second control point. `x1` and `x2` must be in \[0, 1\].
#' @param count **(Steps easing)** Positive integer. Number of discrete steps.
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
  new_easing(
    .EASING_ELASTIC[[direction]],
    list(amplitude = amplitude, period = period)
  )
}

#' @rdname anime_easing
#' @export
anime_easing_back <- function(direction = "out", overshoot = 1.70158) {
  direction <- rlang::arg_match(direction, .EASING_DIRECTION)
  new_easing(
    .EASING_BACK[[direction]],
    list(overshoot = overshoot)
  )
}

#' @rdname anime_easing
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
  new_easing("cubicBezier", list(x1 = x1, y1 = y1, x2 = x2, y2 = y2))
}

#' @rdname anime_easing
#' @export
anime_easing_steps <- function(count) {
  if (
    missing(count) ||
      !is.numeric(count) ||
      length(count) != 1L ||
      count < 1 ||
      count != round(count)
  ) {
    rlang::abort(
      "`count` must be a single positive integer.",
      call = rlang::caller_env()
    )
  }
  new_easing("steps", list(count = as.integer(count)))
}

#' @rdname anime_easing
#' @export
anime_easing_spring <- function(bounce = 0.5, duration = 628) {
  if (
    !is.numeric(bounce) || length(bounce) != 1L || bounce < -1 || bounce > 1
  ) {
    rlang::abort(
      paste0(
        "`bounce` must be a single numeric value in [-1, 1], not ",
        bounce,
        "."
      ),
      call = rlang::caller_env()
    )
  }
  if (
    !is.numeric(duration) ||
      length(duration) != 1L ||
      duration < 10 ||
      duration > 10000
  ) {
    rlang::abort(
      paste0(
        "`duration` must be a single numeric value in [10, 10000], not ",
        duration,
        "."
      ),
      call = rlang::caller_env()
    )
  }
  new_easing("spring", list(bounce = bounce, duration = duration))
}
