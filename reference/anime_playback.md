# Configure animation playback

Sets autoplay, looping, direction, speed, and optional controls UI on an
`anime_timeline` or `anime_animation`. Arguments left as `NULL` keep the
settings already stored on the object.

## Usage

``` r
anime_playback(
  x,
  autoplay = NULL,
  loop = NULL,
  loop_delay = NULL,
  playback_rate = NULL,
  reversed = NULL,
  alternate = NULL,
  controls = NULL
)
```

## Arguments

- x:

  An `anime_timeline` or `anime_animation` object.

- autoplay:

  Logical. Start playing immediately on load.

- loop:

  Logical or positive integer. `FALSE` for no looping, `TRUE` for
  infinite looping, or a fixed number of iterations.

- loop_delay:

  Numeric. Delay in milliseconds between iterations.

- playback_rate:

  Numeric. Playback speed multiplier (1 is normal speed).

- reversed:

  Logical. Play in reverse from the end.

- alternate:

  Logical. Alternate direction on each iteration (requires `loop` to be
  `TRUE` or a positive integer to have any visible effect).

- controls:

  Logical. Inject a play/pause/seek control bar into the widget
  container.

## Value

The modified `anime_timeline` or `anime_animation` object.

## Examples

``` r
anime_timeline() |>
  anime_playback(loop = TRUE, alternate = TRUE, controls = TRUE)
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
#> [1] TRUE
#> 
#> $segments
#> list()
#> 
#> $events
#> list()
#> 
#> $alternate
#> [1] TRUE
#> 
#> $controls
#> [1] TRUE
#> 
#> attr(,"class")
#> [1] "anime_timeline"
```
