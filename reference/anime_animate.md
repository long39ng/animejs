# Create a single Anime.js animation

The R equivalent of Anime.js v4's `animate(targets, parameters)`: one
set of property animations applied to one target selector, without a
timeline. Use
[`anime_timeline()`](https://long39ng.github.io/animejs/reference/anime_timeline.md)
and
[`anime_add()`](https://long39ng.github.io/animejs/reference/anime_add.md)
instead when several segments must be sequenced.

## Usage

``` r
anime_animate(
  selector,
  props,
  duration = NULL,
  ease = NULL,
  delay = NULL,
  loop = FALSE,
  alternate = FALSE,
  reversed = FALSE,
  autoplay = TRUE,
  stagger = NULL
)
```

## Arguments

- selector:

  CSS selector string identifying the SVG/HTML elements to animate. Use
  `anime_target_*()` helpers to construct selectors.

- props:

  A named list of property animations. Values may be scalars,
  two-element numeric vectors (from/to),
  [`anime_from_to()`](https://long39ng.github.io/animejs/reference/anime_from_to.md)
  objects, or
  [`anime_keyframes()`](https://long39ng.github.io/animejs/reference/anime_keyframes.md)
  objects.

- duration:

  Duration in milliseconds. `NULL` uses the Anime.js default.

- ease:

  Easing, an `anime_easing` object or an Anime.js easing name string.
  `NULL` uses the Anime.js default.

- delay:

  Delay in milliseconds before the animation starts. `NULL` uses the
  Anime.js default.

- loop:

  Logical or positive integer. `FALSE` for no looping, `TRUE` for
  infinite looping, or a fixed number of iterations.

- alternate:

  Logical. Alternate direction on each iteration.

- reversed:

  Logical. Play in reverse from the end.

- autoplay:

  Logical. Start playing immediately on load.

- stagger:

  An `anime_stagger` object for per-element delay offsets.

## Value

An `anime_animation` object.

## Details

Like a timeline, an `anime_animation` can be modified with
[`anime_playback()`](https://long39ng.github.io/animejs/reference/anime_playback.md)
and
[`anime_on()`](https://long39ng.github.io/animejs/reference/anime_on.md),
and is rendered with
[`anime_render()`](https://long39ng.github.io/animejs/reference/anime_render.md).

## Examples

``` r
anime_animate(
  selector = anime_target_class("circle"),
  props = list(
    translateY = anime_from_to(-40, 0),
    opacity = anime_from_to(0, 1)
  ),
  duration = 600,
  ease = anime_easing_spring()
)
#> $selector
#> [1] ".circle"
#> 
#> $props
#> $props$translateY
#> $from
#> [1] -40
#> 
#> $to
#> [1] 0
#> 
#> $unit
#> [1] ""
#> 
#> $ease
#> NULL
#> 
#> attr(,"class")
#> [1] "anime_from_to"
#> 
#> $props$opacity
#> $from
#> [1] 0
#> 
#> $to
#> [1] 1
#> 
#> $unit
#> [1] ""
#> 
#> $ease
#> NULL
#> 
#> attr(,"class")
#> [1] "anime_from_to"
#> 
#> 
#> $duration
#> [1] 600
#> 
#> $ease
#> $name
#> [1] "spring"
#> 
#> $params
#> $params$bounce
#> [1] 0.5
#> 
#> $params$duration
#> [1] 628
#> 
#> 
#> attr(,"class")
#> [1] "anime_easing"
#> 
#> $delay
#> NULL
#> 
#> $loop
#> [1] FALSE
#> 
#> $alternate
#> [1] FALSE
#> 
#> $reversed
#> [1] FALSE
#> 
#> $autoplay
#> [1] TRUE
#> 
#> $stagger
#> NULL
#> 
#> $events
#> list()
#> 
#> attr(,"class")
#> [1] "anime_animation"
```
