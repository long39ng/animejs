#' Target SVG or HTML elements by a data-animejs-id attribute
#'
#' The primary mechanism for targeting individual elements annotated by
#' `svg_annotate()` (in `gganime`) or by hand. Scoping to the widget
#' container is handled by the JavaScript binding; this function returns a
#' bare attribute selector.
#'
#' @param id Character scalar. Value of the `data-animejs-id` attribute.
#'
#' @return A CSS selector string of the form `"[data-animejs-id='<id>']"`.
#'
#' @examples
#' anime_target_id("c1")
#'
#' @export
anime_target_id <- function(id) {
  if (!is.character(id) || length(id) == 0L) {
    rlang::abort(
      "`id` must be a non-empty character scalar.",
      call = rlang::caller_env()
    )
  }
  sprintf("[data-animejs-id='%s']", id)
}

#' Target elements by CSS class
#'
#' @param cls Character scalar. Class name without a leading dot.
#'
#' @return A CSS selector string of the form `".<cls>"`.
#'
#' @examples
#' anime_target_class("circle")
#'
#' @export
anime_target_class <- function(cls) {
  if (!is.character(cls) || length(cls) == 0L) {
    rlang::abort(
      "`cls` must be a non-empty character scalar.",
      call = rlang::caller_env()
    )
  }
  sprintf(".%s", cls)
}

#' Target all data elements belonging to a ggplot2 layer
#'
#' Produces an attribute selector matching the `data-layer` attribute injected
#' by `gganime`'s SVG annotation pipeline. Exposed for power users who compose
#' `animejs` timelines against annotated ggplot2 SVG output directly.
#'
#' @param layer_index Integer scalar. 1-based index of the ggplot2 layer.
#'
#' @return A CSS selector string of the form `"[data-layer='<layer_index>']"`.
#'
#' @examples
#' anime_target_layer(1L)
#'
#' @export
anime_target_layer <- function(layer_index) {
  sprintf("[data-layer='%s']", layer_index)
}

#' Target elements by an arbitrary CSS selector
#'
#' A pass-through for selectors not covered by the other `anime_target_*()`
#' helpers.
#'
#' @param selector Character scalar. A valid CSS selector string.
#'
#' @return `selector` unchanged.
#'
#' @examples
#' anime_target_css(".panel > circle")
#'
#' @export
anime_target_css <- function(selector) {
  selector
}
