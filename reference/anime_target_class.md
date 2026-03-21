# Target elements by CSS class

Target elements by CSS class

## Usage

``` r
anime_target_class(cls)
```

## Arguments

- cls:

  Character scalar. Class name without a leading dot.

## Value

A CSS selector string of the form `".<cls>"`.

## Examples

``` r
anime_target_class("circle")
#> [1] ".circle"
```
