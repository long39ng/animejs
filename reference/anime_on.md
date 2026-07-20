# Attach a JavaScript callback to an animation event

The callback must be the name of a globally scoped JavaScript function
already present on the page, for example one injected via
`htmltools::tags$script()`. At render time the JavaScript binding
resolves the name to `window[callback]` and attaches it to the
corresponding Anime.js callback.

## Usage

``` r
anime_on(x, event, callback)
```

## Arguments

- x:

  An `anime_timeline` or `anime_animation` object.

- event:

  One of "onBegin", "onBeforeUpdate", "onUpdate", "onRender", "onLoop",
  "onPause", "onComplete", matching the Anime.js v4 callback API.

- callback:

  Character scalar. Name of the global JS function to invoke.

## Value

The modified object.

## Examples

``` r
if (interactive() && rlang::is_installed("htmltools")) {
  svg_src <- '<svg viewBox="0 0 200 100" xmlns="http://www.w3.org/2000/svg">
    <circle class="circle" cx="100" cy="50" r="20" fill="#4e79a7"/>
  </svg>'

  widget <- anime_timeline(duration = 800) |>
    anime_add(selector = ".circle", props = list(opacity = c(0, 1))) |>
    anime_on("onComplete", "handleAnimationDone") |>
    anime_render(svg = svg_src)

  callback_js <- htmltools::tags$script(
    "function handleAnimationDone() {
      console.log('Animation complete.');
    }"
  )

  htmltools::browsable(htmltools::tagList(callback_js, widget))
}
```
