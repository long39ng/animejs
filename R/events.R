#' Attach a JavaScript callback to a timeline event
#'
#' The callback must be the name of a globally scoped JavaScript function
#' already present on the page, for example one injected via
#' `htmltools::tags$script()`. At render time the JavaScript binding resolves
#' the name to `window[callback]` and attaches it to the corresponding
#' Anime.js timeline hook.
#'
#' @param timeline An `anime_timeline` object.
#' @param event One of `"onBegin"`, `"onUpdate"`, `"onComplete"`,
#'   `"onLoop"`, matching the Anime.js v4 timeline callback API.
#' @param callback Character scalar. Name of the global JS function to invoke.
#'
#' @return The modified `anime_timeline` object (visibly), suitable for
#'   continued piping.
#'
#' @examples
#' \dontrun{
#' svg_src <- '<svg viewBox="0 0 200 100" xmlns="http://www.w3.org/2000/svg">
#'   <circle class="circle" cx="100" cy="50" r="20" fill="#4e79a7"/>
#' </svg>'
#'
#' widget <- anime_timeline(duration = 800) |>
#'   anime_add(selector = ".circle", props = list(opacity = c(0, 1))) |>
#'   anime_on("onComplete", "handleAnimationDone") |>
#'   anime_render(svg = svg_src)
#'
#' callback_js <- htmltools::tags$script(
#'   "function handleAnimationDone() {
#'     console.log('Animation complete.');
#'   }"
#' )
#'
#' htmltools::browsable(htmltools::tagList(callback_js, widget))
#' }
#'
#' @export
anime_on <- function(
  timeline,
  event = c("onBegin", "onUpdate", "onComplete", "onLoop"),
  callback
) {
  stopifnot(inherits(timeline, "anime_timeline"))
  event <- rlang::arg_match(event)
  timeline$events[[event]] <- callback
  timeline
}
