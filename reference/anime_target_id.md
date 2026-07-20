# Target SVG or HTML elements by a data-animejs-id attribute

The primary mechanism for targeting individual elements annotated with a
`data-animejs-id` attribute, by hand or by an upstream SVG annotation
tool.

## Usage

``` r
anime_target_id(id)
```

## Arguments

- id:

  Character scalar. Value of the `data-animejs-id` attribute.

## Value

A CSS selector string of the form `"[data-animejs-id='<id>']"`.

## Examples

``` r
anime_target_id("c1")
#> [1] "[data-animejs-id='c1']"
```
