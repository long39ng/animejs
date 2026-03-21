# Target all data elements belonging to a ggplot2 layer

Produces an attribute selector matching the `data-layer` attribute
injected by `gganime`'s SVG annotation pipeline. Exposed for power users
who compose `animejs` timelines against annotated ggplot2 SVG output
directly.

## Usage

``` r
anime_target_layer(layer_index)
```

## Arguments

- layer_index:

  Integer scalar. 1-based index of the ggplot2 layer.

## Value

A CSS selector string of the form `"[data-layer='<layer_index>']"`.

## Examples

``` r
anime_target_layer(1L)
#> [1] "[data-layer='1']"
```
