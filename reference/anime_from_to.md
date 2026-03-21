# Specify a from/to property range

Convenience constructor for a two-value property animation that runs
from `from` to `to`. An optional CSS unit suffix is concatenated into
both values during serialisation (e.g. `100` with `unit = "px"` becomes
`"100px"`).

## Usage

``` r
anime_from_to(from, to, unit = "")
```

## Arguments

- from:

  Numeric. Starting value.

- to:

  Numeric. Ending value.

- unit:

  Character. Optional CSS unit suffix, e.g. `"px"`, `"%"`, `"deg"`.

## Value

An `anime_from_to` object.

## Examples

``` r
anime_from_to(0, 1)
#> $from
#> [1] 0
#> 
#> $to
#> [1] 1
#> 
#> $unit
#> [1] ""
#> 
#> attr(,"class")
#> [1] "anime_from_to"
anime_from_to(0, 360, unit = "deg")
#> $from
#> [1] 0
#> 
#> $to
#> [1] 360
#> 
#> $unit
#> [1] "deg"
#> 
#> attr(,"class")
#> [1] "anime_from_to"
```
