#' Convert an anime_timeline to a JSON-serialisable config list
#'
#' This is the serialisation step called by [anime_render()] immediately before
#' [animejs_widget()]. All R S3 objects are converted to plain lists; scalar
#' fields are marked for `auto_unbox` treatment by remaining length-1 vectors
#' (jsonlite handles this when called with `auto_unbox = TRUE`).
#'
#' @param timeline An `anime_timeline` object.
#' @return A plain list suitable for `jsonlite::toJSON(auto_unbox = TRUE)`.
#' @noRd
timeline_to_json_config <- function(timeline) {
  stopifnot(inherits(timeline, "anime_timeline"))

  # Serialise each segment, converting any S3 property/stagger objects.
  segments <- lapply(timeline$segments, function(seg) {
    out <- list(
      selector = seg$selector,
      props = to_js_props(seg$props),
      offset = seg$offset %||% "+=0"
    )
    if (!is.null(seg$duration)) {
      out$duration <- seg$duration
    }
    if (!is.null(seg$easing)) {
      out$easing <- seg$easing
    }
    if (!is.null(seg$delay)) {
      out$delay <- seg$delay
    }
    if (!is.null(seg$stagger)) {
      out$stagger <- stagger_to_js(seg$stagger)
    }
    out
  })

  config <- list(
    defaults = timeline$defaults,
    loop = timeline$loop %||% FALSE,
    segments = segments,
    events = timeline$events %||% list()
  )

  # Optional playback fields — only included when explicitly set.
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
#' @noRd
to_js_props <- function(props) {
  if (!is.list(props)) {
    rlang::abort("`props` must be a named list.")
  }

  is_kf <- vapply(props, inherits, logical(1L), "anime_keyframes")

  # Non-keyframe properties: one input key -> one output key
  plain <- lapply(props[!is_kf], prop_value_to_js)

  # Keyframe properties: one input key -> multiple output keys.
  # prop_value_to_js() returns a named list of per-property keyframe lists;
  # unlist one level to merge them into the top-level result.
  expanded <- unlist(
    lapply(props[is_kf], prop_value_to_js),
    recursive = FALSE
  )

  c(plain, expanded)
}

#' Convert one property value to its JS-serialisable form
#' @noRd
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
    # Each named element is a vector of keyframe values for one property.
    # Flatten to a list of per-keyframe objects keyed by property name.
    # anime_keyframes stores multiple properties; return them as a named list
    # of keyframe value lists.
    lapply(value, function(vals) {
      lapply(vals, function(v) list(value = v))
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
#' @noRd
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
  if (!is.null(stagger$easing)) {
    out$easing <- stagger$easing
  }

  out
}

#' Validate a duration or delay value
#'
#' @param x Value to validate.
#' @param arg Argument name used in error messages.
#' @return `x` invisibly if valid.
#' @noRd
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
