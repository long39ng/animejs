# Initialise an Anime.js timeline

Initialise an Anime.js timeline

## Usage

``` r
anime_timeline(duration = 1000, ease = anime_easing(), delay = 0, loop = FALSE)
```

## Arguments

- duration:

  Default duration in milliseconds for all segments.

- ease:

  Default easing for all segments.

- delay:

  Default delay in milliseconds between segments.

- loop:

  Logical or integer. `FALSE` for no looping, `TRUE` for infinite
  looping, or a positive integer for a fixed number of iterations.

## Value

An `anime_timeline` object.

## Examples

``` r
anime_timeline(duration = 800, ease = anime_easing())
#> $defaults
#> $defaults$duration
#> [1] 800
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
#> list()
#> 
#> $events
#> list()
#> 
#> attr(,"class")
#> [1] "anime_timeline"
```
