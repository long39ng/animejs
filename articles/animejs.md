# Introduction to animejs

## Overview

`animejs` provides R bindings to [Anime.js v4](https://animejs.com), a
JavaScript animation library. It produces self-contained HTML widgets
via the `htmlwidgets` package, which render in browser environments like
RStudio Viewer, R Markdown documents, Quarto reports, and Shiny
applications.

The package has three conceptual layers:

1.  **Timeline** –
    [`anime_timeline()`](https://long39ng.github.io/animejs/reference/anime_timeline.md)
    and
    [`anime_add()`](https://long39ng.github.io/animejs/reference/anime_add.md)
    accumulate an animation specification in R.
2.  **Properties** –
    [`anime_from_to()`](https://long39ng.github.io/animejs/reference/anime_from_to.md)
    and
    [`anime_keyframes()`](https://long39ng.github.io/animejs/reference/anime_keyframes.md)
    describe how individual CSS/SVG properties move over time.
3.  **Rendering** –
    [`anime_render()`](https://long39ng.github.io/animejs/reference/anime_render.md)
    serialises the specification and wraps it in an htmlwidget.

## A minimal example

Any SVG whose elements carry a `data-animejs-id` or CSS class can be
targeted directly.

``` r
library(animejs)

svg_src <- '
<svg viewBox="0 0 400 200" xmlns="http://www.w3.org/2000/svg">
  <circle data-animejs-id="c1" cx="50"  cy="100" r="20" fill="#4e79a7"/>
  <circle data-animejs-id="c2" cx="120" cy="100" r="20" fill="#f28e2b"/>
  <circle data-animejs-id="c3" cx="190" cy="100" r="20" fill="#e15759"/>
</svg>
'

anime_timeline(
  duration = 800,
  ease = anime_easing_elastic(),
  loop = TRUE
) |>
  anime_add(
    selector = anime_target_css("circle"),
    props = list(
      translateY = anime_from_to(-80, 0),
      opacity = anime_from_to(0, 1)
    ),
    stagger = anime_stagger(150, from = "first")
  ) |>
  anime_add(
    selector = anime_target_id("c2"),
    props = list(r = anime_from_to(20, 40)),
    offset = "+=200"
  ) |>
  anime_render(svg = svg_src)
```

## Timeline

[`anime_timeline()`](https://long39ng.github.io/animejs/reference/anime_timeline.md)
initialises an animation timeline. The `duration`, `ease`, and `delay`
arguments set defaults that apply to every segment; individual segments
may override them via
[`anime_add()`](https://long39ng.github.io/animejs/reference/anime_add.md).

``` r
tl <- anime_timeline(
  duration = 1000,
  ease = anime_easing("Cubic", "inOut"),
  loop = TRUE
)
```

[`anime_add()`](https://long39ng.github.io/animejs/reference/anime_add.md)
appends one segment – a set of property animations applied to a CSS
selector. The `offset` argument positions the segment on the timeline:
`"+=0"` (default) starts immediately after the previous segment;
`"+=200"` inserts a 200 ms gap.

## Property animations

### From/to

[`anime_from_to()`](https://long39ng.github.io/animejs/reference/anime_from_to.md)
is the simplest property descriptor: a start value and an end value.

``` r
anime_from_to(0, 1) # opacity: 0 → 1
anime_from_to(0, 100, "px") # translateX: "0px" → "100px"
```

### Keyframes

[`anime_keyframes()`](https://long39ng.github.io/animejs/reference/anime_keyframes.md)
accepts two or more positional values. Bare numerics are used as `to`
values; named lists may additionally specify `ease` and `duration` per
keyframe.

``` r
# Bare numeric keyframes
anime_keyframes(0, 1, 0.5)

# List-based keyframes with per-keyframe easing
anime_keyframes(
  list(to = 0),
  list(to = 1, ease = "outQuad", duration = 400),
  list(to = 0.5, ease = "inCubic")
)
```

## Staggering

[`anime_stagger()`](https://long39ng.github.io/animejs/reference/anime_stagger.md)
distributes animation start times across the elements matched by the
selector. It is passed to the `stagger` argument of
[`anime_add()`](https://long39ng.github.io/animejs/reference/anime_add.md).

``` r
anime_add(
  tl,
  selector = ".bar",
  props = list(scaleY = anime_from_to(0, 1)),
  stagger = anime_stagger(80, from = "center")
)
```

For two-dimensional grid layouts, supply `grid = c(rows, cols)` and
optionally `axis = "x"` or `axis = "y"`.

## Easing

All easing constructors return `anime_easing` objects.

| Constructor                                                                              | Example result               |
|------------------------------------------------------------------------------------------|------------------------------|
| `anime_easing("Quad", "out")`                                                            | `"outQuad"`                  |
| [`anime_easing_elastic()`](https://long39ng.github.io/animejs/reference/anime_easing.md) | `"outElastic(1,0.3)"`        |
| [`anime_easing_spring()`](https://long39ng.github.io/animejs/reference/anime_easing.md)  | `"spring(0.5,628)"`          |
| `anime_easing_bezier(0.4, 0, 0.2, 1)`                                                    | `"cubicBezier(0.4,0,0.2,1)"` |
| `anime_easing_steps(10)`                                                                 | `"steps(10)"`                |

Plain Anime.js v4 easing name strings (e.g. `"inOutSine"`) are also
accepted wherever an `anime_easing` object is expected.

## Playback

[`anime_playback()`](https://long39ng.github.io/animejs/reference/anime_playback.md)
sets looping, direction, and UI controls:

``` r
tl |>
  anime_playback(loop = TRUE, alternate = TRUE, controls = TRUE) |>
  anime_render(svg = svg_src)
```

Setting `controls = TRUE` injects a play/pause button and a scrub slider
into the widget.

## Event callbacks

[`anime_on()`](https://long39ng.github.io/animejs/reference/anime_on.md)
registers a global JavaScript function as a timeline lifecycle callback.
Inject the function into the page via `htmltools::tags$script()`.

``` r
tl |>
  anime_on("onComplete", "myOnCompleteHandler") |>
  anime_render(svg = svg_src)
```

Valid events are `"onBegin"`, `"onUpdate"`, `"onComplete"`, and
`"onLoop"`.

## Saving widget output

For reproducible documents the widget can be saved to a self-contained
HTML file:

``` r
widget <- anime_render(tl, svg = svg_src)
htmlwidgets::saveWidget(widget, "animation.html", selfcontained = TRUE)
```
