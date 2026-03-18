#' Create a stagger configuration for per-element delay offsets
#'
#' When applied to a multi-element selector, Anime.js distributes animation
#' start times across elements according to the stagger value.
#'
#' @param value Numeric. Base delay in milliseconds between each element.
#' @param from One of `"first"`, `"last"`, `"center"`, or a numeric index.
#'   Controls which element starts first.
#' @param grid Integer vector of length 2 (`c(rows, cols)`) for 2D grid
#'   stagger.
#' @param axis One of `"x"`, `"y"`. Used together with `grid`.
#' @param easing Easing applied to the stagger distribution itself.
#'
#' @return An `anime_stagger` object.
#'
#' @examples
#' anime_stagger(100)
#' anime_stagger(200, from = "center", grid = c(3L, 4L), axis = "x")
#'
#' @export
anime_stagger <- function(
  value,
  from = "first",
  grid = NULL,
  axis = NULL,
  easing = NULL
) {
  structure(
    list(value = value, from = from, grid = grid, axis = axis, easing = easing),
    class = "anime_stagger"
  )
}
