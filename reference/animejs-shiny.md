# Shiny bindings for animejs

Output and render functions for using animejs widgets within Shiny
applications and interactive R Markdown documents.

## Usage

``` r
animejsOutput(outputId, width = "100%", height = "400px")

renderAnimejs(expr, env = parent.frame(), quoted = FALSE)
```

## Arguments

- outputId:

  Output variable to read from.

- width, height:

  Must be a valid CSS unit (like `"100%"`, `"400px"`, `"auto"`) or a
  number, which will be coerced to a string and have `"px"` appended.

- expr:

  An expression that generates an animejs widget, typically a call to
  [`anime_render()`](https://long39ng.github.io/animejs/reference/anime_render.md).

- env:

  The environment in which to evaluate `expr`.

- quoted:

  Is `expr` a quoted expression (with
  [`quote()`](https://rdrr.io/r/base/substitute.html))? This is useful
  if you want to save an expression in a variable.

## Value

`animejsOutput()` returns a Shiny output function that can be used in a
UI definition; `renderAnimejs()` returns a Shiny render function that
can be assigned to an output slot.

## Examples

``` r
if (interactive() && rlang::is_installed("shiny")) {
  library(shiny)

  svg_src <- '<svg viewBox="0 0 200 100" xmlns="http://www.w3.org/2000/svg">
    <circle class="dot" cx="100" cy="50" r="20" fill="#4e79a7"/>
  </svg>'

  ui <- fluidPage(
    sliderInput("duration", "Duration (ms)", 200, 2000, 800),
    animejsOutput("anim", height = "200px")
  )

  server <- function(input, output, session) {
    output$anim <- renderAnimejs({
      anime_animate(
        selector = anime_target_class("dot"),
        props = list(opacity = anime_from_to(0, 1)),
        duration = input$duration
      ) |>
        anime_render(svg = svg_src)
    })
  }

  shinyApp(ui, server)
}
```
