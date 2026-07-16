# anime_timeline() validates its inputs

    Code
      anime_timeline(duration = "fast")
    Condition
      Error in `anime_timeline()`:
      ! `duration` must be a single number.
      x You supplied a string.

---

    Code
      anime_timeline(duration = -1)
    Condition
      Error in `anime_timeline()`:
      ! `duration` must be at least 0.
      x You supplied -1.

---

    Code
      anime_timeline(delay = c(100, 200))
    Condition
      Error in `anime_timeline()`:
      ! `delay` must be a single number.
      x You supplied a double vector.

---

    Code
      anime_timeline(ease = 42)
    Condition
      Error in `anime_timeline()`:
      ! `ease` must be an <anime_easing> object or an Anime.js easing name string.
      x You supplied a number.
      i See `anime_easing()` for the available constructors.

---

    Code
      anime_timeline(loop = 1.5)
    Condition
      Error in `anime_timeline()`:
      ! `loop` must be TRUE, FALSE, or a positive integer number of iterations.
      x You supplied 1.5.

# anime_add() validates its inputs

    Code
      anime_add(list(), selector = ".x", props = list(opacity = 1))
    Condition
      Error in `anime_add()`:
      ! `timeline` must be an <anime_timeline> object.
      x You supplied an empty list.
      i Create one with `anime_timeline()`.

---

    Code
      anime_add(tl, selector = 1, props = list(opacity = 1))
    Condition
      Error in `anime_add()`:
      ! `selector` must be a single string.
      x You supplied a number.

---

    Code
      anime_add(tl, selector = ".x", props = list(1))
    Condition
      Error in `anime_add()`:
      ! `props` must be a named list of property animations.
      i For example `list(opacity = anime_from_to(0, 1))`.

---

    Code
      anime_add(tl, selector = ".x", props = list(opacity = 1), duration = -1)
    Condition
      Error in `anime_add()`:
      ! `duration` must be at least 0.
      x You supplied -1.

---

    Code
      anime_add(tl, selector = ".x", props = list(opacity = 1), ease = 42)
    Condition
      Error in `anime_add()`:
      ! `ease` must be an <anime_easing> object or an Anime.js easing name string.
      x You supplied a number.
      i See `anime_easing()` for the available constructors.

---

    Code
      anime_add(tl, selector = ".x", props = list(opacity = 1), stagger = 100)
    Condition
      Error in `anime_add()`:
      ! `stagger` must be an <anime_stagger> object.
      x You supplied a number.
      i Create one with `anime_stagger()`.

