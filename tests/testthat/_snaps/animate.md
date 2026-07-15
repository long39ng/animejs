# anime_animate() validates its inputs

    Code
      anime_animate(1, props = list(opacity = 1))
    Condition
      Error in `anime_animate()`:
      ! `selector` must be a single string.
      x You supplied a number.

---

    Code
      anime_animate(".dot", props = list(1))
    Condition
      Error in `anime_animate()`:
      ! `props` must be a named list of property animations.
      i For example `list(opacity = anime_from_to(0, 1))`.

---

    Code
      anime_animate(".dot", props = list(opacity = 1), duration = -1)
    Condition
      Error in `anime_animate()`:
      ! `duration` must be at least 0.
      x You supplied -1.

---

    Code
      anime_animate(".dot", props = list(opacity = 1), ease = 42)
    Condition
      Error in `anime_animate()`:
      ! `ease` must be an <anime_easing> object or an Anime.js easing name string.
      x You supplied a number.
      i See `anime_easing()` for the available constructors.

---

    Code
      anime_animate(".dot", props = list(opacity = 1), loop = "yes")
    Condition
      Error in `anime_animate()`:
      ! `loop` must be TRUE, FALSE, or a positive integer number of iterations.
      x You supplied a string.

---

    Code
      anime_animate(".dot", props = list(opacity = 1), stagger = 100)
    Condition
      Error in `anime_animate()`:
      ! `stagger` must be an <anime_stagger> object.
      x You supplied a number.
      i Create one with `anime_stagger()`.

