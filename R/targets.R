#' Target SVG or HTML elements by a data-animejs-id attribute
#'
#' The primary mechanism for targeting individual elements annotated with a
#' `data-animejs-id` attribute, by hand or by an upstream SVG annotation tool.
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
  check_string(id, "id")
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
  check_string(cls, "cls")
  if (startsWith(cls, ".")) {
    cli::cli_abort(
      c(
        "{.arg cls} must be a class name without the leading dot.",
        i = "Did you mean {.val {sub('^\\\\.+', '', cls)}}?"
      )
    )
  }
  sprintf(".%s", cls)
}

#' Target elements by a data-layer attribute
#'
#' Produces an attribute selector matching a `data-layer` attribute, a
#' convention used by SVG annotation pipelines that tag all data elements
#' belonging to one plot layer (e.g. ggplot2 layers) with their layer index.
#'
#' @param layer_index Integer scalar. 1-based index of the layer.
#'
#' @return A CSS selector string of the form `"[data-layer='<layer_index>']"`.
#'
#' @examples
#' anime_target_layer(1L)
#'
#' @export
anime_target_layer <- function(layer_index) {
  check_count(layer_index, "layer_index")
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
  check_string(selector, "selector")
  selector
}
