# Convert a named list of property animations to JS-serialisable form

Handles plain scalars, length-2 numeric from/to vectors, `anime_from_to`
objects, and `anime_keyframes` objects.

## Usage

``` r
to_js_props(props)
```

## Arguments

- props:

  Named list of property animations as supplied to
  [`anime_add()`](https://long39ng.github.io/animejs/reference/anime_add.md).

## Value

A named list ready for
[`jsonlite::toJSON()`](https://jeroen.r-universe.dev/jsonlite/reference/fromJSON.html).
