#' Specify discrete text keyframes for an element
#'
#' Constructs a text-swap specification for use in the `props` argument of
#' [anime_add()]. Unlike a numeric tween, a text prop does not interpolate:
#' the values are spread evenly across the segment's duration and the target
#' element's `textContent` is swapped to the value for the current position as
#' the timeline plays or is scrubbed. Useful for animated titles, counters,
#' and tickers.
#'
#' The segment's `selector` picks the text element(s) to update, so the prop
#' name you file this under is only a label; use something descriptive such as
#' `text` or `label`.
#'
#' @param values An atomic vector of the successive text values. Non-character
#'   vectors are coerced with [as.character()], so pre-format numbers (e.g. with
#'   [format()] or [formatC()]) if you need thousands separators or fixed
#'   notation.
#'
#' @return An `anime_text` object.
#'
#' @examples
#' # A counter that steps through four values across the segment
#' anime_add(
#'   anime_timeline(),
#'   selector = anime_target_id("counter"),
#'   props = list(text = anime_text(c("0", "25", "50", "100")))
#' )
#'
#' # Compose a text swap with an ordinary tween on the same segment
#' anime_add(
#'   anime_timeline(),
#'   selector = anime_target_id("title"),
#'   props = list(
#'     opacity = anime_keyframes(0, 1),
#'     label = anime_text(c("Loading", "Ready"))
#'   )
#' )
#'
#' @export
anime_text <- function(values) {
  rlang::check_required(values)
  if (!is.atomic(values) || length(values) == 0L) {
    cli::cli_abort(c(
      "{.arg values} must be a non-empty atomic vector.",
      x = "You supplied {.obj_type_friendly {values}}."
    ))
  }
  structure(
    list(type = "text", values = as.character(values)),
    class = "anime_text"
  )
}

is_anime_text <- function(x) {
  inherits(x, "anime_text")
}

# Convert an anime_text object to its JSON-serialisable form. `values` is
# wrapped with as.list() so a single value still serialises to a JSON array
# (auto_unbox would otherwise collapse a length-1 vector to a scalar), matching
# what the JS binding indexes into.
text_to_js <- function(value) {
  list(type = "text", values = as.list(value$values))
}
