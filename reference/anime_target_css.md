# Target elements by an arbitrary CSS selector

A pass-through for selectors not covered by the other `anime_target_*()`
helpers.

## Usage

``` r
anime_target_css(selector)
```

## Arguments

- selector:

  Character scalar. A valid CSS selector string.

## Value

`selector` unchanged.

## Examples

``` r
anime_target_css(".panel > circle")
#> [1] ".panel > circle"
```
