# Specify per-property keyframes for an animation

Constructs a keyframes object for use in the `props` argument of
[`anime_add()`](https://long39ng.github.io/animejs/reference/anime_add.md).
Each positional argument is one keyframe.

## Usage

``` r
anime_keyframes(...)
```

## Arguments

- ...:

  Keyframe values. Either bare numeric values, or lists each with a
  `$to` key and optional `$ease` and `$duration` overrides.

## Value

An `anime_keyframes` object.

## Examples

``` r
# Bare numeric keyframe values
anime_add(
  anime_timeline(),
  selector = ".circle",
  props = list(
    opacity = anime_keyframes(0, 1, 0.5),
    translateY = anime_keyframes(-20, 0, 10)
  )
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
#> [[1]]
#> [1] 0
#> 
#> [[2]]
#> [1] 1
#> 
#> [[3]]
#> [1] 0.5
#> 
#> attr(,"class")
#> [1] "anime_keyframes"
#> 
#> $segments[[1]]$props$translateY
#> [[1]]
#> [1] -20
#> 
#> [[2]]
#> [1] 0
#> 
#> [[3]]
#> [1] 10
#> 
#> attr(,"class")
#> [1] "anime_keyframes"
#> 
#> 
#> $segments[[1]]$offset
#> [1] "+=0"
#> 
#> 
#> 
#> $events
#> list()
#> 
#> attr(,"class")
#> [1] "anime_timeline"

# Per-keyframe lists with optional ease and duration overrides
anime_add(
  anime_timeline(),
  selector = ".circle",
  props = list(
    opacity = anime_keyframes(
      list(to = 0),
      list(to = 1, ease = anime_easing("Cubic"), duration = 400),
      list(to = 0.5, ease = "linear", duration = 200)
    )
  )
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
#> [[1]]
#> [[1]]$to
#> [1] 0
#> 
#> 
#> [[2]]
#> [[2]]$to
#> [1] 1
#> 
#> [[2]]$ease
#> $name
#> [1] "outCubic"
#> 
#> $params
#> list()
#> 
#> attr(,"class")
#> [1] "anime_easing"
#> 
#> [[2]]$duration
#> [1] 400
#> 
#> 
#> [[3]]
#> [[3]]$to
#> [1] 0.5
#> 
#> [[3]]$ease
#> [1] "linear"
#> 
#> [[3]]$duration
#> [1] 200
#> 
#> 
#> attr(,"class")
#> [1] "anime_keyframes"
#> 
#> 
#> $segments[[1]]$offset
#> [1] "+=0"
#> 
#> 
#> 
#> $events
#> list()
#> 
#> attr(,"class")
#> [1] "anime_timeline"
```
