# Specify discrete text keyframes for an element

Constructs a text-swap specification for use in the `props` argument of
[`anime_add()`](https://long39ng.github.io/animejs/reference/anime_add.md).
Unlike a numeric tween, a text prop does not interpolate: the values are
spread evenly across the segment's duration and the target element's
`textContent` is swapped to the value for the current position as the
timeline plays or is scrubbed. Useful for animated titles, counters, and
tickers.

## Usage

``` r
anime_text(values)
```

## Arguments

- values:

  An atomic vector of the successive text values. Non-character vectors
  are coerced with
  [`as.character()`](https://rdrr.io/r/base/character.html), so
  pre-format numbers (e.g. with
  [`format()`](https://rdrr.io/r/base/format.html) or
  [`formatC()`](https://rdrr.io/r/base/formatc.html)) if you need
  thousands separators or fixed notation.

## Value

An `anime_text` object.

## Details

The segment's `selector` picks the text element(s) to update, so the
prop name you file this under is only a label; use something descriptive
such as `text` or `label`.

## Examples

``` r
# A counter that steps through four values across the segment
anime_add(
  anime_timeline(),
  selector = anime_target_id("counter"),
  props = list(text = anime_text(c("0", "25", "50", "100")))
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
#> [1] "[data-animejs-id='counter']"
#> 
#> $segments[[1]]$props
#> $segments[[1]]$props$text
#> $type
#> [1] "text"
#> 
#> $values
#> [1] "0"   "25"  "50"  "100"
#> 
#> attr(,"class")
#> [1] "anime_text"
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

# Compose a text swap with an ordinary tween on the same segment
anime_add(
  anime_timeline(),
  selector = anime_target_id("title"),
  props = list(
    opacity = anime_keyframes(0, 1),
    label = anime_text(c("Loading", "Ready"))
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
#> [1] "[data-animejs-id='title']"
#> 
#> $segments[[1]]$props
#> $segments[[1]]$props$opacity
#> [[1]]
#> [1] 0
#> 
#> [[2]]
#> [1] 1
#> 
#> attr(,"class")
#> [1] "anime_keyframes"
#> 
#> $segments[[1]]$props$label
#> $type
#> [1] "text"
#> 
#> $values
#> [1] "Loading" "Ready"  
#> 
#> attr(,"class")
#> [1] "anime_text"
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
