#' Shiny bindings for animejs
#'
#' Output and render functions for using animejs widgets within Shiny
#' applications and interactive R Markdown documents.
#'
#' @param outputId Output variable to read from.
#' @param width,height Must be a valid CSS unit (like `"100%"`, `"400px"`,
#'   `"auto"`) or a number, which will be coerced to a string and have `"px"`
#'   appended.
#' @param expr An expression that generates an animejs widget, typically a
#'   call to [anime_render()].
#' @param env The environment in which to evaluate `expr`.
#' @param quoted Is `expr` a quoted expression (with `quote()`)? This is
#'   useful if you want to save an expression in a variable.
#'
#' @return `animejsOutput()` returns a Shiny output function that can be used
#'   in a UI definition; `renderAnimejs()` returns a Shiny render function
#'   that can be assigned to an output slot.
#'
#' @examples
#' if (interactive() && rlang::is_installed("shiny")) {
#'   library(shiny)
#'
#'   svg_src <- '<svg viewBox="0 0 200 100" xmlns="http://www.w3.org/2000/svg">
#'     <circle class="dot" cx="100" cy="50" r="20" fill="#4e79a7"/>
#'   </svg>'
#'
#'   ui <- fluidPage(
#'     sliderInput("duration", "Duration (ms)", 200, 2000, 800),
#'     animejsOutput("anim", height = "200px")
#'   )
#'
#'   server <- function(input, output, session) {
#'     output$anim <- renderAnimejs({
#'       anime_animate(
#'         selector = anime_target_class("dot"),
#'         props = list(opacity = anime_from_to(0, 1)),
#'         duration = input$duration
#'       ) |>
#'         anime_render(svg = svg_src)
#'     })
#'   }
#'
#'   shinyApp(ui, server)
#' }
#'
#' @name animejs-shiny
NULL

#' @rdname animejs-shiny
#' @export
animejsOutput <- function(outputId, width = "100%", height = "400px") {
  htmlwidgets::shinyWidgetOutput(
    outputId,
    "animejs",
    width,
    height,
    package = "animejs"
  )
}

#' @rdname animejs-shiny
#' @export
renderAnimejs <- function(expr, env = parent.frame(), quoted = FALSE) {
  if (!quoted) {
    expr <- substitute(expr)
  }
  htmlwidgets::shinyRenderWidget(expr, animejsOutput, env, quoted = TRUE)
}
