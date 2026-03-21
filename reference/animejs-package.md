# animejs: R Bindings to the Anime.js Animation Library

`animejs` provides a pipe-friendly R interface to [Anime.js
v4](https://animejs.com/), a JavaScript animation library. Timelines are
authored in R and serialised to JSON; the htmlwidgets infrastructure
renders them in a browser environment.

The central workflow is:

1.  Create a timeline with
    [`anime_timeline()`](https://long39ng.github.io/animejs/reference/anime_timeline.md).

2.  Add animation segments with
    [`anime_add()`](https://long39ng.github.io/animejs/reference/anime_add.md).

3.  Configure playback with
    [`anime_playback()`](https://long39ng.github.io/animejs/reference/anime_playback.md)
    and attach event callbacks with
    [`anime_on()`](https://long39ng.github.io/animejs/reference/anime_on.md).

4.  Render to an htmlwidget with
    [`anime_render()`](https://long39ng.github.io/animejs/reference/anime_render.md).

Property values are specified via
[`anime_from_to()`](https://long39ng.github.io/animejs/reference/anime_from_to.md)
and
[`anime_keyframes()`](https://long39ng.github.io/animejs/reference/anime_keyframes.md).
Per-element delay offsets are specified via
[`anime_stagger()`](https://long39ng.github.io/animejs/reference/anime_stagger.md).
Easing functions are specified via the `anime_easing_*()` family. Target
selectors are constructed via the `anime_target_*()` family.

## Package options

None currently. All configuration is per-timeline.

## See also

Useful links:

- <https://github.com/long39ng/animejs>

- <https://long39ng.github.io/animejs/>

- Report bugs at <https://github.com/long39ng/animejs/issues>

## Author

**Maintainer**: Long Nguyen <nguyen@dezim-institut.de>
([ORCID](https://orcid.org/0000-0001-8878-7386))
