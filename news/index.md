# Changelog

## animejs 1.1.0

### New features

- [`anime_text()`](https://long39ng.github.io/animejs/reference/anime_text.md)
  adds discrete text keyframes: a segment prop whose values are swapped
  into the target element’s `textContent` as the timeline advances,
  rather than tweened. It composes with ordinary tween props on the same
  segment and follows the play/pause and scrub controls. Useful for
  animated titles, counters, and tickers.

## animejs 1.0.0

CRAN release: 2026-07-20

### Breaking changes

- The easing serialisation protocol now matches the Anime.js v4 API.
  Anime.js v4 removed the string syntax for cubic bezier, steps, and
  spring easings, so these are now serialised as structured payloads and
  reconstructed as `anime.cubicBezier()`, `anime.steps()`, and
  `anime.spring()` calls in JavaScript. Spring parameters (previously
  silently ignored) now actually take effect.

- [`anime_on()`](https://long39ng.github.io/animejs/reference/anime_on.md),
  [`anime_playback()`](https://long39ng.github.io/animejs/reference/anime_playback.md),
  and
  [`anime_render()`](https://long39ng.github.io/animejs/reference/anime_render.md)
  now take `x` as the name of their first argument (previously
  `timeline`), since they also accept the new `anime_animation` objects.

- [`anime_playback()`](https://long39ng.github.io/animejs/reference/anime_playback.md)
  arguments now default to `NULL`, meaning “leave the current setting
  unchanged”, instead of overwriting all playback settings on every
  call.

- [`anime_target_class()`](https://long39ng.github.io/animejs/reference/anime_target_class.md)
  and
  [`anime_target_id()`](https://long39ng.github.io/animejs/reference/anime_target_id.md)
  now require a single string;
  [`anime_target_class()`](https://long39ng.github.io/animejs/reference/anime_target_class.md)
  rejects class names with a leading dot instead of silently producing a
  broken selector.

- [`animejs_widget()`](https://long39ng.github.io/animejs/reference/animejs_widget.md)
  argument `timeline_config` has been renamed to `config`.

### New features

- [`anime_animate()`](https://long39ng.github.io/animejs/reference/anime_animate.md)
  creates a single animation without a timeline, mirroring Anime.js v4’s
  `animate()`. It works with
  [`anime_playback()`](https://long39ng.github.io/animejs/reference/anime_playback.md),
  [`anime_on()`](https://long39ng.github.io/animejs/reference/anime_on.md),
  and
  [`anime_render()`](https://long39ng.github.io/animejs/reference/anime_render.md).

- [`anime_easing_steps()`](https://long39ng.github.io/animejs/reference/anime_easing.md)
  gains a `from_start` argument to jump at the start of each step (CSS
  `jump-start` behaviour).

- [`anime_from_to()`](https://long39ng.github.io/animejs/reference/anime_from_to.md)
  gains an `ease` argument for per-property easing.

- [`anime_on()`](https://long39ng.github.io/animejs/reference/anime_on.md)
  supports all seven Anime.js v4 callbacks, adding `"onBeforeUpdate"`,
  `"onRender"`, and `"onPause"`.

- [`anime_playback()`](https://long39ng.github.io/animejs/reference/anime_playback.md)
  gains `loop_delay` and `playback_rate` arguments.

- [`anime_stagger()`](https://long39ng.github.io/animejs/reference/anime_stagger.md)
  gains `start` and `reversed` arguments.

- [`animejsOutput()`](https://long39ng.github.io/animejs/reference/animejs-shiny.md)
  and
  [`renderAnimejs()`](https://long39ng.github.io/animejs/reference/animejs-shiny.md)
  provide Shiny bindings.

### Bug fixes

- All user-facing functions now validate their inputs and raise
  structured, informative error messages.

- Parameterised elastic and back easings no longer trigger spurious
  browser console warnings.

- Easing specifications inside keyframes
  ([`anime_keyframes()`](https://long39ng.github.io/animejs/reference/anime_keyframes.md))
  and staggers (`anime_stagger(ease = )`) are now serialised and
  resolved correctly; previously they were dropped by Anime.js.

- [`anime_from_to()`](https://long39ng.github.io/animejs/reference/anime_from_to.md)
  no longer converts numeric values to strings when `unit` is `NULL`.

- `anime_playback(controls = TRUE)` no longer overwrites `onUpdate` and
  `onComplete` callbacks registered with
  [`anime_on()`](https://long39ng.github.io/animejs/reference/anime_on.md);
  the controls bar now chains them.

## animejs 0.1.1

- Fix icons for play/pause button

## animejs 0.1.0

CRAN release: 2026-03-26

- Initial CRAN submission.
