# Convert an anime_timeline to a JSON-serialisable config list

This is the serialisation step called by
[`anime_render()`](https://long39ng.github.io/animejs/reference/anime_render.md)
immediately before
[`animejs_widget()`](https://long39ng.github.io/animejs/reference/animejs_widget.md).
All R S3 objects are converted to plain lists; scalar fields are marked
for `auto_unbox` treatment by remaining length-1 vectors (jsonlite
handles this when called with `auto_unbox = TRUE`).

## Usage

``` r
timeline_to_json_config(timeline)
```

## Arguments

- timeline:

  An `anime_timeline` object.

## Value

A plain list suitable for `jsonlite::toJSON(auto_unbox = TRUE)`.
