# Package index

## Animations & Timelines

Create a single animation, or initialise and build an animation
timeline.

- [`anime_animate()`](https://long39ng.github.io/animejs/reference/anime_animate.md)
  : Create a single Anime.js animation
- [`anime_timeline()`](https://long39ng.github.io/animejs/reference/anime_timeline.md)
  : Initialise an Anime.js timeline
- [`anime_add()`](https://long39ng.github.io/animejs/reference/anime_add.md)
  : Add an animation segment to a timeline

## Property Animations

Describe how individual CSS or SVG properties change over time.

- [`anime_from_to()`](https://long39ng.github.io/animejs/reference/anime_from_to.md)
  : Specify a from/to property range
- [`anime_keyframes()`](https://long39ng.github.io/animejs/reference/anime_keyframes.md)
  : Specify per-property keyframes for an animation

## Stagger

Distribute animation start times across multiple elements.

- [`anime_stagger()`](https://long39ng.github.io/animejs/reference/anime_stagger.md)
  : Create a stagger configuration for per-element delay offsets

## Easing

Construct easing specifications for timeline defaults and per-segment
overrides.

- [`anime_easing()`](https://long39ng.github.io/animejs/reference/anime_easing.md)
  [`anime_easing_elastic()`](https://long39ng.github.io/animejs/reference/anime_easing.md)
  [`anime_easing_back()`](https://long39ng.github.io/animejs/reference/anime_easing.md)
  [`anime_easing_bezier()`](https://long39ng.github.io/animejs/reference/anime_easing.md)
  [`anime_easing_steps()`](https://long39ng.github.io/animejs/reference/anime_easing.md)
  [`anime_easing_spring()`](https://long39ng.github.io/animejs/reference/anime_easing.md)
  : Easing constructors

## Target Selectors

Build CSS selector strings that identify the elements to animate.

- [`anime_target_class()`](https://long39ng.github.io/animejs/reference/anime_target_class.md)
  : Target elements by CSS class
- [`anime_target_css()`](https://long39ng.github.io/animejs/reference/anime_target_css.md)
  : Target elements by an arbitrary CSS selector
- [`anime_target_id()`](https://long39ng.github.io/animejs/reference/anime_target_id.md)
  : Target SVG or HTML elements by a data-animejs-id attribute
- [`anime_target_layer()`](https://long39ng.github.io/animejs/reference/anime_target_layer.md)
  : Target elements by a data-layer attribute

## Events

Attach JavaScript callbacks to timeline lifecycle events.

- [`anime_on()`](https://long39ng.github.io/animejs/reference/anime_on.md)
  : Attach a JavaScript callback to an animation event

## Playback

Control looping, direction, and interactive UI controls.

- [`anime_playback()`](https://long39ng.github.io/animejs/reference/anime_playback.md)
  : Configure animation playback

## Rendering

Serialise an animation specification and produce an htmlwidget.

- [`anime_render()`](https://long39ng.github.io/animejs/reference/anime_render.md)
  : Render an animation or timeline as an htmlwidget
- [`animejs_widget()`](https://long39ng.github.io/animejs/reference/animejs_widget.md)
  : Create a bare animejs htmlwidget

## Shiny

Use animejs widgets in Shiny applications.

- [`animejsOutput()`](https://long39ng.github.io/animejs/reference/animejs-shiny.md)
  [`renderAnimejs()`](https://long39ng.github.io/animejs/reference/animejs-shiny.md)
  : Shiny bindings for animejs
