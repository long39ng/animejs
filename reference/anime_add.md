# Add an animation segment to a timeline

Pipe-friendly. Each call appends one segment: a set of CSS property
animations applied to a target selector.

## Usage

``` r
anime_add(
  timeline,
  selector,
  props,
  offset = "+=0",
  duration = NULL,
  ease = NULL,
  delay = NULL,
  stagger = NULL
)
```

## Arguments

- timeline:

  An `anime_timeline` object.

- selector:

  CSS selector string identifying the SVG/HTML elements to animate. Use
  `anime_target_*()` helpers to construct selectors.

- props:

  A named list of property animations. Values may be scalars,
  two-element vectors (from/to), or
  [`anime_keyframes()`](https://long39ng.github.io/animejs/reference/anime_keyframes.md)
  objects.

- offset:

  Timeline offset. `"+=N"` means N ms after the previous segment ends; a
  bare number is an absolute position in ms.

- duration:

  Overrides the timeline default for this segment.

- ease:

  Overrides the timeline default for this segment.

- delay:

  Overrides the timeline default for this segment.

- stagger:

  An `anime_stagger` object for per-element delay offsets.

## Value

The modified `anime_timeline` object.

## Examples

``` r
anime_timeline() |>
  anime_add(
    selector = anime_target_class("circle"),
    props    = list(opacity = anime_from_to(0, 1)),
    duration = 600
  )
#> $defaults
#> $defaults$duration
#> [1] 1000
#> 
#> $defaults$ease
#> $name
#> [1] "outQuad"
#> 
#> $params
#> list()
#> 
#> attr(,"class")
#> [1] "anime_easing"
#> 
#> $defaults$delay
#> [1] 0
#> 
#> 
#> $loop
#> [1] FALSE
#> 
#> $segments
#> $segments[[1]]
#> $segments[[1]]$selector
#> [1] ".circle"
#> 
#> $segments[[1]]$props
#> $segments[[1]]$props$opacity
#> $from
#> [1] 0
#> 
#> $to
#> [1] 1
#> 
#> $unit
#> [1] ""
#> 
#> attr(,"class")
#> [1] "anime_from_to"
#> 
#> 
#> $segments[[1]]$offset
#> [1] "+=0"
#> 
#> $segments[[1]]$duration
#> [1] 600
#> 
#> 
#> 
#> $events
#> list()
#> 
#> attr(,"class")
#> [1] "anime_timeline"
```
