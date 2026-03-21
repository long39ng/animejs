# Convert an anime_stagger object to a JS-serialisable list

The JS binding calls `anime.stagger(value, opts)`. This function
produces the R-side representation of that call. The JS binding
reconstructs the actual `anime.stagger()` call.

## Usage

``` r
stagger_to_js(stagger)
```

## Arguments

- stagger:

  An `anime_stagger` object.

## Value

A plain list.
