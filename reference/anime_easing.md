# Easing constructors

A family of constructors for Anime.js v4 easing specifications. Each
returns an `anime_easing` object that serialises to the correct JS
string inside
[`anime_timeline()`](https://long39ng.github.io/animejs/reference/anime_timeline.md),
[`anime_add()`](https://long39ng.github.io/animejs/reference/anime_add.md),
or
[`anime_playback()`](https://long39ng.github.io/animejs/reference/anime_playback.md).

## Usage

``` r
anime_easing(family = "Quad", direction = "out")

anime_easing_elastic(direction = "out", amplitude = 1, period = 0.3)

anime_easing_back(direction = "out", overshoot = 1.70158)

anime_easing_bezier(x1, y1, x2, y2)

anime_easing_steps(count)

anime_easing_spring(bounce = 0.5, duration = 628)
```

## Arguments

- family:

  Character. One of "linear", "Quad", "Cubic", "Quart", "Quint", "Sine",
  "Expo", "Circ", "Bounce".

- direction:

  Character. One of "in", "out", "inOut", "outIn".

- amplitude, period:

  **(Elastic easing)** Numeric. Overshoot amplitude and oscillation
  period.

- overshoot:

  **(Back easing)** Numeric. Overshoot amount.

- x1, y1, x2, y2:

  **(Cubic bezier easing)** Coordinates of the first and second control
  point. `x1` and `x2` must be in \[0, 1\].

- count:

  **(Steps easing)** Positive integer. Number of discrete steps.

- bounce:

  **(Spring easing)** Number in \[-1, 1\]. Controls bounciness. Values
  from 0 to 1 produce bouncy curves; values below 0 produce over-damped
  curves. Keep within \[-0.5, 0.5\] for predictable behaviour.

- duration:

  **(Spring easing)** Number in \[10, 10000\]. The perceived duration in
  milliseconds at which the animation feels visually complete.

## Value

An `anime_easing` object.

## Examples

``` r
anime_easing("linear")
#> $name
#> [1] "linear"
#> 
#> $params
#> list()
#> 
#> attr(,"class")
#> [1] "anime_easing"
anime_easing("Quad", "outIn")
#> $name
#> [1] "outInQuad"
#> 
#> $params
#> list()
#> 
#> attr(,"class")
#> [1] "anime_easing"

anime_easing_elastic()
#> $name
#> [1] "outElastic"
#> 
#> $params
#> $params$amplitude
#> [1] 1
#> 
#> $params$period
#> [1] 0.3
#> 
#> 
#> attr(,"class")
#> [1] "anime_easing"
anime_easing_elastic("in", amplitude = 1.5, period = 0.3)
#> $name
#> [1] "inElastic"
#> 
#> $params
#> $params$amplitude
#> [1] 1.5
#> 
#> $params$period
#> [1] 0.3
#> 
#> 
#> attr(,"class")
#> [1] "anime_easing"

anime_easing_back()
#> $name
#> [1] "outBack"
#> 
#> $params
#> $params$overshoot
#> [1] 1.70158
#> 
#> 
#> attr(,"class")
#> [1] "anime_easing"
anime_easing_back("in", overshoot = 2.5)
#> $name
#> [1] "inBack"
#> 
#> $params
#> $params$overshoot
#> [1] 2.5
#> 
#> 
#> attr(,"class")
#> [1] "anime_easing"

anime_easing_bezier(0.4, 0, 0.2, 1)
#> $name
#> [1] "cubicBezier"
#> 
#> $params
#> $params$x1
#> [1] 0.4
#> 
#> $params$y1
#> [1] 0
#> 
#> $params$x2
#> [1] 0.2
#> 
#> $params$y2
#> [1] 1
#> 
#> 
#> attr(,"class")
#> [1] "anime_easing"
anime_easing_bezier(0.68, -0.55, 0.265, 1.55)
#> $name
#> [1] "cubicBezier"
#> 
#> $params
#> $params$x1
#> [1] 0.68
#> 
#> $params$y1
#> [1] -0.55
#> 
#> $params$x2
#> [1] 0.265
#> 
#> $params$y2
#> [1] 1.55
#> 
#> 
#> attr(,"class")
#> [1] "anime_easing"

anime_easing_steps(10)
#> $name
#> [1] "steps"
#> 
#> $params
#> $params$count
#> [1] 10
#> 
#> 
#> attr(,"class")
#> [1] "anime_easing"

anime_easing_spring()
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
anime_easing_spring(bounce = 0.65, duration = 350)
#> $name
#> [1] "spring"
#> 
#> $params
#> $params$bounce
#> [1] 0.65
#> 
#> $params$duration
#> [1] 350
#> 
#> 
#> attr(,"class")
#> [1] "anime_easing"
```
