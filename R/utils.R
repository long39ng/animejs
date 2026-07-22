# Internal validation helpers ---------------------------------------------

check_anime_object <- function(x, arg = "x", call = rlang::caller_env()) {
  if (!inherits(x, c("anime_timeline", "anime_animation"))) {
    cli::cli_abort(
      c(
        "{.arg {arg}} must be an {.cls anime_timeline} or
         {.cls anime_animation} object.",
        x = "You supplied {.obj_type_friendly {x}}."
      ),
      call = call
    )
  }
  invisible(x)
}

check_string <- function(x, arg, call = rlang::caller_env()) {
  if (!rlang::is_string(x)) {
    cli::cli_abort(
      c(
        "{.arg {arg}} must be a single string.",
        x = "You supplied {.obj_type_friendly {x}}."
      ),
      call = call
    )
  }
  invisible(x)
}

check_bool <- function(x, arg, call = rlang::caller_env()) {
  if (!rlang::is_bool(x)) {
    cli::cli_abort(
      c(
        "{.arg {arg}} must be {.val {TRUE}} or {.val {FALSE}}.",
        x = "You supplied {.obj_type_friendly {x}}."
      ),
      call = call
    )
  }
  invisible(x)
}

check_number <- function(
  x,
  arg,
  min = -Inf,
  max = Inf,
  call = rlang::caller_env()
) {
  if (!is.numeric(x) || length(x) != 1L || is.na(x)) {
    cli::cli_abort(
      c(
        "{.arg {arg}} must be a single number.",
        x = "You supplied {.obj_type_friendly {x}}."
      ),
      call = call
    )
  }
  if (x < min || x > max) {
    range_msg <- if (is.infinite(min)) {
      "{.arg {arg}} must be at most {.val {max}}."
    } else if (is.infinite(max)) {
      "{.arg {arg}} must be at least {.val {min}}."
    } else {
      "{.arg {arg}} must be between {.val {min}} and {.val {max}}."
    }
    cli::cli_abort(
      c(range_msg, x = "You supplied {.val {x}}."),
      call = call
    )
  }
  invisible(x)
}

check_count <- function(x, arg, call = rlang::caller_env()) {
  if (
    !is.numeric(x) ||
      length(x) != 1L ||
      is.na(x) ||
      x < 1 ||
      x != round(x)
  ) {
    supplied <- if (is.numeric(x) && length(x) == 1L && !is.na(x)) {
      "You supplied {.val {x}}."
    } else {
      "You supplied {.obj_type_friendly {x}}."
    }
    cli::cli_abort(
      c("{.arg {arg}} must be a single positive integer.", x = supplied),
      call = call
    )
  }
  invisible(x)
}

check_loop <- function(loop, call = rlang::caller_env()) {
  if (rlang::is_bool(loop)) {
    return(invisible(loop))
  }
  if (
    is.numeric(loop) &&
      length(loop) == 1L &&
      !is.na(loop) &&
      loop >= 1 &&
      loop == round(loop)
  ) {
    return(invisible(loop))
  }
  supplied <- if (is.numeric(loop) && length(loop) == 1L && !is.na(loop)) {
    "You supplied {.val {loop}}."
  } else {
    "You supplied {.obj_type_friendly {loop}}."
  }
  cli::cli_abort(
    c(
      "{.arg loop} must be {.val {TRUE}}, {.val {FALSE}}, or a positive
       integer number of iterations.",
      x = supplied
    ),
    call = call
  )
}

check_ease <- function(ease, arg = "ease", call = rlang::caller_env()) {
  if (is.null(ease) || rlang::is_string(ease) || is_anime_easing(ease)) {
    return(invisible(ease))
  }
  cli::cli_abort(
    c(
      "{.arg {arg}} must be an {.cls anime_easing} object or an Anime.js
       easing name string.",
      x = "You supplied {.obj_type_friendly {ease}}.",
      i = "See {.fn anime_easing} for the available constructors."
    ),
    call = call
  )
}

check_props <- function(props, call = rlang::caller_env()) {
  if (!is.list(props) || length(props) == 0L || !rlang::is_named(props)) {
    cli::cli_abort(
      c(
        "{.arg props} must be a named list of property animations.",
        i = "For example {.code list(opacity = anime_from_to(0, 1))}."
      ),
      call = call
    )
  }
  invisible(props)
}

check_stagger <- function(stagger, call = rlang::caller_env()) {
  if (!is.null(stagger) && !inherits(stagger, "anime_stagger")) {
    cli::cli_abort(
      c(
        "{.arg stagger} must be an {.cls anime_stagger} object.",
        x = "You supplied {.obj_type_friendly {stagger}}.",
        i = "Create one with {.fn anime_stagger}."
      ),
      call = call
    )
  }
  invisible(stagger)
}

validate_duration <- function(
  x,
  arg = "duration",
  call = rlang::caller_env()
) {
  check_number(x, arg, min = 0, call = call)
}

is_anime_easing <- function(x) {
  inherits(x, "anime_easing")
}

# Serialisation -----------------------------------------------------------

# Convert an anime_timeline to the JSON-serialisable config consumed by the
# JavaScript binding. Called by anime_render() before animejs_widget().
timeline_to_json_config <- function(timeline) {
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
      out$ease <- easing_to_config(seg$ease)
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
    timeline$defaults$ease <- easing_to_config(timeline$defaults$ease)
  }

  config <- list(
    kind = "timeline",
    defaults = timeline$defaults,
    loop = timeline$loop %||% FALSE,
    segments = segments,
    events = timeline$events %||% list()
  )

  playback_to_config(config, timeline)
}

# Convert an anime_animation to the JSON-serialisable config consumed by the
# JavaScript binding.
animation_to_json_config <- function(animation) {
  config <- list(
    kind = "animation",
    selector = animation$selector,
    props = to_js_props(animation$props),
    loop = animation$loop %||% FALSE,
    events = animation$events %||% list()
  )
  if (!is.null(animation$duration)) {
    config$duration <- animation$duration
  }
  if (!is.null(animation$ease)) {
    config$ease <- easing_to_config(animation$ease)
  }
  if (!is.null(animation$delay)) {
    config$delay <- animation$delay
  }
  if (!is.null(animation$stagger)) {
    config$stagger <- stagger_to_js(animation$stagger)
  }

  playback_to_config(config, animation)
}

# Copy playback settings stored on an anime_timeline/anime_animation into a
# config list, translating to Anime.js camelCase parameter names.
playback_to_config <- function(config, x) {
  if (!is.null(x$autoplay)) {
    config$autoplay <- x$autoplay
  }
  if (!is.null(x$controls)) {
    config$controls <- x$controls
  }
  if (isTRUE(x$reversed)) {
    config$reversed <- TRUE
  }
  if (isTRUE(x$alternate)) {
    config$alternate <- TRUE
  }
  if (!is.null(x$loop_delay)) {
    config$loopDelay <- x$loop_delay
  }
  if (!is.null(x$playback_rate)) {
    config$playbackRate <- x$playback_rate
  }
  config
}

# Convert a named list of property animations to JS-serialisable form.
# Handles plain scalars, length-2 numeric from/to vectors, anime_from_to
# objects, and anime_keyframes objects.
to_js_props <- function(props) {
  lapply(props, prop_value_to_js)
}

prop_value_to_js <- function(value) {
  if (inherits(value, "anime_from_to")) {
    from_to_to_js(value)
  } else if (inherits(value, "anime_keyframes")) {
    lapply(unclass(value), keyframe_to_js)
  } else if (inherits(value, "anime_text")) {
    text_to_js(value)
  } else if (is.numeric(value) && length(value) == 2L) {
    # Bare length-2 numeric vector: treat as from/to
    list(from = value[[1L]], to = value[[2L]])
  } else {
    value
  }
}

from_to_to_js <- function(value) {
  out <- if (!is.null(value$unit) && nzchar(value$unit)) {
    list(
      from = paste0(value$from, value$unit),
      to = paste0(value$to, value$unit)
    )
  } else {
    list(from = value$from, to = value$to)
  }
  if (!is.null(value$ease)) {
    out$ease <- easing_to_config(value$ease)
  }
  out
}

# Each keyframe is either an atomic value (serialised as its `to` value) or a
# list of Anime.js keyframe parameters (`to`, `ease`, `duration`, ...).
keyframe_to_js <- function(kf) {
  if (rlang::is_scalar_atomic(kf)) {
    return(list(to = kf))
  }
  if (!is.null(kf$ease)) {
    kf$ease <- easing_to_config(kf$ease)
  }
  kf
}

# Convert an anime_stagger object to a JS-serialisable list. The JS binding
# reconstructs the corresponding anime.stagger(value, opts) call.
stagger_to_js <- function(stagger) {
  out <- list(value = stagger$value)

  # Omit "from" when it is the JS default ("first") to keep the payload lean
  if (!is.null(stagger$from) && !identical(stagger$from, "first")) {
    out$from <- stagger$from
  }
  if (!is.null(stagger$start)) {
    out$start <- stagger$start
  }
  if (isTRUE(stagger$reversed)) {
    out$reversed <- TRUE
  }
  if (!is.null(stagger$grid)) {
    out$grid <- stagger$grid
  }
  if (!is.null(stagger$axis)) {
    out$axis <- stagger$axis
  }
  if (!is.null(stagger$ease)) {
    out$ease <- easing_to_config(stagger$ease)
  }

  out
}

# Convert an easing specification to its JSON-serialisable form.
#
# Anime.js v4 parses plain names ("outQuad") and parameterised elastic/back
# names ("outElastic(1,0.3)") directly from strings, so those serialise to
# strings. Spring, steps, and cubic bezier eases have no v4 string form (the
# string syntax was removed from the core) and must be reconstructed as
# function calls by the JS binding, so they serialise to tagged lists.
easing_to_config <- function(ease, call = rlang::caller_env()) {
  if (is.null(ease) || is.character(ease)) {
    return(ease)
  }
  if (!is_anime_easing(ease)) {
    cli::cli_abort(
      c(
        "{.arg ease} must be an {.cls anime_easing} object or an Anime.js
         easing name string.",
        x = "You supplied {.obj_type_friendly {ease}}."
      ),
      call = call
    )
  }

  name <- ease$name
  p <- ease$params

  if (name %in% .EASING_SIMPLE) {
    name
  } else if (name %in% .EASING_ELASTIC) {
    sprintf("%s(%s,%s)", name, p$amplitude, p$period)
  } else if (name %in% .EASING_BACK) {
    sprintf("%s(%s)", name, p$overshoot)
  } else if (name == "spring") {
    list(type = "spring", bounce = p$bounce, duration = p$duration)
  } else if (name == "steps") {
    list(type = "steps", count = p$count, fromStart = p$from_start)
  } else if (name == "cubicBezier") {
    list(type = "cubicBezier", args = list(p$x1, p$y1, p$x2, p$y2))
  } else {
    cli::cli_abort(
      "Unrecognised easing name: {.val {name}}.",
      call = call
    )
  }
}
