# Target elements by a data-layer attribute

Produces an attribute selector matching a `data-layer` attribute, a
convention used by SVG annotation pipelines that tag all data elements
belonging to one plot layer (e.g. ggplot2 layers) with their layer
index.

## Usage

``` r
anime_target_layer(layer_index)
```

## Arguments

- layer_index:

  Integer scalar. 1-based index of the layer.

## Value

A CSS selector string of the form `"[data-layer='<layer_index>']"`.

## Examples

``` r
anime_target_layer(1L)
#> [1] "[data-layer='1']"
```
