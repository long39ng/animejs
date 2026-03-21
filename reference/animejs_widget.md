# Create a bare animejs htmlwidget

This is the low-level constructor. Most users will not call this
directly; it is the final rendering step called by
[`anime_render()`](https://long39ng.github.io/animejs/reference/anime_render.md).

## Usage

``` r
animejs_widget(
  svg,
  timeline_config,
  width = NULL,
  height = NULL,
  elementId = NULL
)
```

## Arguments

- svg:

  Character. Raw SVG markup to embed in the widget. If `NULL`, an empty
  string is used (the timeline will animate against existing DOM content
  – advanced use only).

- timeline_config:

  List. A serialisable timeline specification produced by
  [`anime_timeline()`](https://long39ng.github.io/animejs/reference/anime_timeline.md)
  and its modifiers, then passed through
  [`timeline_to_json_config()`](https://long39ng.github.io/animejs/reference/timeline_to_json_config.md).

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

An object of class `c("animejs", "htmlwidget)`
