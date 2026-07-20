# animejs 1.0.0

## Breaking changes

* The easing serialisation protocol now matches the Anime.js v4 API. Anime.js
  v4 removed the string syntax for cubic bezier, steps, and spring easings, so
  these are now serialised as structured payloads and reconstructed as
  `anime.cubicBezier()`, `anime.steps()`, and `anime.spring()` calls in
  JavaScript. Spring parameters (previously silently ignored) now actually
  take effect.

* `anime_on()`, `anime_playback()`, and `anime_render()` now take `x` as the
  name of their first argument (previously `timeline`), since they also
  accept the new `anime_animation` objects.

* `anime_playback()` arguments now default to `NULL`, meaning "leave the
  current setting unchanged", instead of overwriting all playback settings on
  every call.

* `anime_target_class()` and `anime_target_id()` now require a single string;
  `anime_target_class()` rejects class names with a leading dot instead of
  silently producing a broken selector.

* `animejs_widget()` argument `timeline_config` has been renamed to `config`.

## New features

* `anime_animate()` creates a single animation without a timeline, mirroring
  Anime.js v4's `animate()`. It works with `anime_playback()`, `anime_on()`,
  and `anime_render()`.

* `anime_easing_steps()` gains a `from_start` argument to jump at the start
  of each step (CSS `jump-start` behaviour).

* `anime_from_to()` gains an `ease` argument for per-property easing.

* `anime_on()` supports all seven Anime.js v4 callbacks, adding
  `"onBeforeUpdate"`, `"onRender"`, and `"onPause"`.

* `anime_playback()` gains `loop_delay` and `playback_rate` arguments.

* `anime_stagger()` gains `start` and `reversed` arguments.

* `animejsOutput()` and `renderAnimejs()` provide Shiny bindings.

## Bug fixes

* All user-facing functions now validate their inputs and raise structured,
  informative error messages.

* Parameterised elastic and back easings no longer trigger spurious browser
  console warnings.

* Easing specifications inside keyframes (`anime_keyframes()`) and staggers
  (`anime_stagger(ease = )`) are now serialised and resolved correctly;
  previously they were dropped by Anime.js.

* `anime_from_to()` no longer converts numeric values to strings when `unit`
  is `NULL`.

* `anime_playback(controls = TRUE)` no longer overwrites `onUpdate` and
  `onComplete` callbacks registered with `anime_on()`; the controls bar now
  chains them.

# animejs 0.1.1

* Fix icons for play/pause button

# animejs 0.1.0

* Initial CRAN submission.
