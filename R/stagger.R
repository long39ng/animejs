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
#' @param ease Easing applied to the stagger distribution itself.
#'
#' @return An `anime_stagger` object.
#'
#' @examples
#' # Simple linear stagger, 100 ms between elements
#' anime_stagger(100)
#'
#' # Stagger from centre outward
#' anime_stagger(200, from = "center")
#'
#' # 2-D grid stagger along the x axis
#' anime_stagger(50, grid = c(3, 4), axis = "x")
#'
#' @export
anime_stagger <- function(
  value,
  from = "first",
  grid = NULL,
  axis = NULL,
  ease = NULL
) {
  if (is.character(from)) {
    from <- rlang::arg_match(from, c("first", "last", "center"))
  } else if (is.numeric(from)) {
    if (length(from) != 1L || from < 0 || from != floor(from)) {
      rlang::abort(
        "`from` must be one of \"first\", \"last\", \"center\", or a non-negative integer index."
      )
    }
  } else {
    rlang::abort(
      "`from` must be a character string or a non-negative integer index."
    )
  }

  structure(
    list(value = value, from = from, grid = grid, axis = axis, ease = ease),
    class = "anime_stagger"
  )
}
