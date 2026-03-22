# Configure timeline playback

Sets autoplay, loop, direction, and optional controls UI on an
`anime_timeline`. Calling this function overwrites any playback settings
already on the timeline (including the `loop` value set in
[`anime_timeline()`](https://long39ng.github.io/animejs/reference/anime_timeline.md)).

## Usage

``` r
anime_playback(
  timeline,
  autoplay = TRUE,
  loop = NULL,
  reversed = FALSE,
  alternate = FALSE,
  controls = FALSE
)
```

## Arguments

- timeline:

  An `anime_timeline` object.

- autoplay:

  Logical. Start playing immediately on load.

- loop:

  Logical or integer. `FALSE` for no looping, `TRUE` for infinite
  looping, or a positive integer for a fixed number of iterations.

- reversed:

  Logical. Play the timeline in reverse from the end.

- alternate:

  Logical. Alternate direction on each iteration (requires `loop` to be
  `TRUE` or a positive integer to have any visible effect).

- controls:

  Logical. Inject a play/pause/seek control bar into the widget
  container.

## Value

The modified `anime_timeline` object.
