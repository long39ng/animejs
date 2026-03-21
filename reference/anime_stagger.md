# Create a stagger configuration for per-element delay offsets

When applied to a multi-element selector, Anime.js distributes animation
start times across elements according to the stagger value.

## Usage

``` r
anime_stagger(value, from = "first", grid = NULL, axis = NULL, ease = NULL)
```

## Arguments

- value:

  Numeric. Base delay in milliseconds between each element.

- from:

  One of `"first"`, `"last"`, `"center"`, or a numeric index. Controls
  which element starts first.

- grid:

  Integer vector of length 2 (`c(rows, cols)`) for 2D grid stagger.

- axis:

  One of `"x"`, `"y"`. Used together with `grid`.

- ease:

  Easing applied to the stagger distribution itself.

## Value

An `anime_stagger` object.

## Examples

``` r
# Simple linear stagger, 100 ms between elements
anime_stagger(100)
#> $value
#> [1] 100
#> 
#> $from
#> [1] "first"
#> 
#> $grid
#> NULL
#> 
#> $axis
#> NULL
#> 
#> $ease
#> NULL
#> 
#> attr(,"class")
#> [1] "anime_stagger"

# Stagger from centre outward
anime_stagger(200, from = "center")
#> $value
#> [1] 200
#> 
#> $from
#> [1] "center"
#> 
#> $grid
#> NULL
#> 
#> $axis
#> NULL
#> 
#> $ease
#> NULL
#> 
#> attr(,"class")
#> [1] "anime_stagger"

# 2-D grid stagger along the x axis
anime_stagger(50, grid = c(3, 4), axis = "x")
#> $value
#> [1] 50
#> 
#> $from
#> [1] "first"
#> 
#> $grid
#> [1] 3 4
#> 
#> $axis
#> [1] "x"
#> 
#> $ease
#> NULL
#> 
#> attr(,"class")
#> [1] "anime_stagger"
```
