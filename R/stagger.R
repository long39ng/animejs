#' Create a stagger configuration for per-element delay offsets
#'
#' When applied to a multi-element selector, Anime.js distributes animation
#' start times across elements according to the stagger value.
#'
#' @param value Numeric. Base delay in milliseconds between each element.
#' @param from One of `"first"`, `"last"`, `"center"`, or a numeric index.
#'   Controls which element starts first.
#' @param start Numeric. Starting value added to every staggered delay.
#' @param reversed Logical. Reverse the stagger order.
#' @param grid Integer vector of length 2 (`c(rows, cols)`) for 2D grid
#'   stagger.
#' @param axis One of `"x"`, `"y"`. Used together with `grid`.
#' @param ease Easing applied to the stagger distribution itself, an
#'   `anime_easing` object or an Anime.js easing name string.
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
  start = NULL,
  reversed = FALSE,
  grid = NULL,
  axis = NULL,
  ease = NULL
) {
  check_number(value, "value")
  if (is.character(from)) {
    from <- rlang::arg_match(from, c("first", "last", "center"))
  } else if (is.numeric(from)) {
    if (length(from) != 1L || is.na(from) || from < 0 || from != floor(from)) {
      cli::cli_abort(
        c(
          "{.arg from} must be {.val first}, {.val last}, {.val center}, or a
           non-negative integer index.",
          x = "You supplied {.val {from}}."
        )
      )
    }
  } else {
    cli::cli_abort(
      c(
        "{.arg from} must be {.val first}, {.val last}, {.val center}, or a
         non-negative integer index.",
        x = "You supplied {.obj_type_friendly {from}}."
      )
    )
  }
  if (!is.null(start)) {
    check_number(start, "start")
  }
  check_bool(reversed, "reversed")
  if (!is.null(grid)) {
    if (!is.numeric(grid) || length(grid) != 2L || anyNA(grid)) {
      cli::cli_abort(
        c(
          "{.arg grid} must be an integer vector of length 2,
           {.code c(rows, cols)}.",
          x = "You supplied {.obj_type_friendly {grid}}."
        )
      )
    }
  }
  if (!is.null(axis)) {
    axis <- rlang::arg_match(axis, c("x", "y"))
  }
  check_ease(ease)

  structure(
    list(
      value = value,
      from = from,
      start = start,
      reversed = reversed,
      grid = grid,
      axis = axis,
      ease = ease
    ),
    class = "anime_stagger"
  )
}
