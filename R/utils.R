#' Convert an anime_timeline to a JSON-serialisable config list
#'
#' This is the serialisation step called by [anime_render()] immediately before
#' [animejs_widget()]. All R S3 objects are converted to plain lists; scalar
#' fields are marked for `auto_unbox` treatment by remaining length-1 vectors
#' (jsonlite handles this when called with `auto_unbox = TRUE`).
#'
#' @param timeline An `anime_timeline` object.
#' @return A plain list suitable for `jsonlite::toJSON(auto_unbox = TRUE)`.
#' @keywords internal
timeline_to_json_config <- function(timeline) {
  stopifnot(inherits(timeline, "anime_timeline"))

  segments <- lapply(timeline$segments, function(seg) {
    out <- list(
      selector = seg$selector,
      props = to_js_props(seg$props),
      offset = seg$offset %||% "+=0"
    )
    if (!is.null(seg$duration)) {
      out$duration <- seg$duration
    }
    if (!is.null(seg$ease)) {
      out$ease <- easing_to_js(seg$ease)
    }
    if (!is.null(seg$delay)) {
      out$delay <- seg$delay
    }
    if (!is.null(seg$stagger)) {
      out$stagger <- stagger_to_js(seg$stagger)
    }
    out
  })

  if (!is.null(timeline$defaults$ease)) {
    timeline$defaults$ease <- easing_to_js(timeline$defaults$ease)
  }

  config <- list(
    defaults = timeline$defaults,
    loop = timeline$loop %||% FALSE,
    segments = segments,
    events = timeline$events %||% list()
  )

  if (!is.null(timeline$autoplay)) {
    config$autoplay <- timeline$autoplay
  }
  if (!is.null(timeline$controls)) {
    config$controls <- timeline$controls
  }
  if (!is.null(timeline$direction)) {
    config$direction <- timeline$direction
  }

  config
}

#' Convert a named list of property animations to JS-serialisable form
#'
#' Handles plain scalars, length-2 numeric from/to vectors, `anime_from_to`
#' objects, and `anime_keyframes` objects.
#'
#' @param props Named list of property animations as supplied to [anime_add()].
#' @return A named list ready for `jsonlite::toJSON()`.
#' @keywords internal
to_js_props <- function(props) {
  if (!is.list(props)) {
    rlang::abort("`props` must be a named list.")
  }

  lapply(props, prop_value_to_js)
}

prop_value_to_js <- function(value) {
  if (inherits(value, "anime_from_to")) {
    if (is.null(value$unit) || nzchar(value$unit)) {
      list(
        from = paste0(value$from, value$unit),
        to = paste0(value$to, value$unit)
      )
    } else {
      list(from = value$from, to = value$to)
    }
  } else if (inherits(value, "anime_keyframes")) {
    # Each element is one keyframe value (numeric or list with $value + opts).
    lapply(value, function(v) {
      if (is.numeric(v)) list(to = v) else v
    })
  } else if (
    is.numeric(value) &&
      length(value) == 2L &&
      !inherits(value, "anime_from_to")
  ) {
    # Bare length-2 numeric vector: treat as from/to
    list(from = value[[1L]], to = value[[2L]])
  } else {
    value
  }
}

#' Convert an anime_stagger object to a JS-serialisable list
#'
#' The JS binding calls `anime.stagger(value, opts)`. This function produces
#' the R-side representation of that call. The JS binding reconstructs the
#' actual `anime.stagger()` call.
#'
#' @param stagger An `anime_stagger` object.
#' @return A plain list.
#' @keywords internal
stagger_to_js <- function(stagger) {
  stopifnot(inherits(stagger, "anime_stagger"))

  out <- list(value = stagger$value)

  # Omit "from" when it is the JS default ("first") to keep the payload lean
  if (!is.null(stagger$from) && stagger$from != "first") {
    out$from <- stagger$from
  }
  if (!is.null(stagger$grid)) {
    out$grid <- stagger$grid
  }
  if (!is.null(stagger$axis)) {
    out$axis <- stagger$axis
  }
  if (!is.null(stagger$ease)) {
    out$ease <- stagger$ease
  }

  out
}

easing_to_js <- function(ease) {
  if (is.character(ease)) {
    return(ease)
  }
  if (!inherits(ease, "anime_easing")) {
    rlang::abort(sprintf(
      "`ease` must be an `anime_easing` object or a character string, not `%s`.",
      class(ease)[[1L]]
    ))
  }

  name <- ease$name
  p <- ease$params

  if (name %in% .EASING_SIMPLE) {
    name
  } else if (name %in% .EASING_ELASTIC) {
    sprintf("%s(%s,%s)", name, p$amplitude, p$period)
  } else if (name %in% .EASING_BACK) {
    sprintf("%s(%s)", name, p$overshoot)
  } else if (name == "steps") {
    sprintf("steps(%d)", p$count)
  } else if (name == "spring") {
    sprintf("spring(%s,%s)", p$bounce, p$duration)
  } else if (name == "cubicBezier") {
    sprintf("cubicBezier(%s,%s,%s,%s)", p$x1, p$y1, p$x2, p$y2)
  } else {
    rlang::abort(sprintf("Unrecognised easing name: '%s'.", name))
  }
}

#' Validate a duration or delay value
#'
#' @param x Value to validate.
#' @param arg Argument name used in error messages.
#' @return `x` invisibly if valid.
#' @keywords internal
validate_duration <- function(x, arg = "duration") {
  if (!is.numeric(x) || length(x) != 1L) {
    rlang::abort(
      paste0(
        "`",
        arg,
        "` must be a single numeric value, not ",
        typeof(x),
        " of length ",
        length(x),
        "."
      ),
      call = rlang::caller_env()
    )
  }
  if (x < 0) {
    rlang::abort(
      paste0("`", arg, "` must be >= 0, not ", x, "."),
      call = rlang::caller_env()
    )
  }
  invisible(x)
}
