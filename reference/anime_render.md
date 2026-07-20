# Render an animation or timeline as an htmlwidget

Serialises an
[`anime_timeline()`](https://long39ng.github.io/animejs/reference/anime_timeline.md)
or
[`anime_animate()`](https://long39ng.github.io/animejs/reference/anime_animate.md)
object to JSON and wraps it together with an SVG payload in an
htmlwidget.

## Usage

``` r
anime_render(x, svg = NULL, width = NULL, height = NULL, elementId = NULL)
```

## Arguments

- x:

  An `anime_timeline` object produced by
  [`anime_timeline()`](https://long39ng.github.io/animejs/reference/anime_timeline.md),
  or an `anime_animation` object produced by
  [`anime_animate()`](https://long39ng.github.io/animejs/reference/anime_animate.md).

- svg:

  Character. Raw SVG markup to embed in the widget. If `NULL`, an empty
  string is used (the animation will run against existing DOM content –
  advanced use only).

- width:

  Fixed width for widget (in css units). The default is `NULL`, which
  results in intelligent automatic sizing based on the widget's
  container.

- height:

  Fixed height for widget (in css units). The default is `NULL`, which
  results in intelligent automatic sizing based on the widget's
  container.

- elementId:

  Use an explicit element ID for the widget (rather than an
  automatically generated one). Useful if you have other JavaScript that
  needs to explicitly discover and interact with a specific widget
  instance.

## Value

An object of class `c("animejs", "htmlwidget")`.

## Examples

``` r
tl <- anime_timeline(duration = 800) |>
  anime_add(
    selector = anime_target_class("dot"),
    props = list(opacity = anime_from_to(0, 1))
  )
svg <- '<svg viewBox="0 0 100 100"><circle class="dot" cx="50" cy="50" r="10"/></svg>'
if (interactive()) {
  anime_render(tl, svg)
}
```
