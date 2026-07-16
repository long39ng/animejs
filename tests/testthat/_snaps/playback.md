# anime_playback() validates its inputs

    Code
      anime_playback(list(), loop = TRUE)
    Condition
      Error in `anime_playback()`:
      ! `x` must be an <anime_timeline> or <anime_animation> object.
      x You supplied an empty list.

---

    Code
      anime_playback(tl, autoplay = "yes")
    Condition
      Error in `anime_playback()`:
      ! `autoplay` must be TRUE or FALSE.
      x You supplied a string.

---

    Code
      anime_playback(tl, loop = -1)
    Condition
      Error in `anime_playback()`:
      ! `loop` must be TRUE, FALSE, or a positive integer number of iterations.
      x You supplied -1.

---

    Code
      anime_playback(tl, loop_delay = -100)
    Condition
      Error in `anime_playback()`:
      ! `loop_delay` must be at least 0.
      x You supplied -100.

---

    Code
      anime_playback(tl, playback_rate = "fast")
    Condition
      Error in `anime_playback()`:
      ! `playback_rate` must be a single number.
      x You supplied a string.

---

    Code
      anime_playback(tl, controls = 1)
    Condition
      Error in `anime_playback()`:
      ! `controls` must be TRUE or FALSE.
      x You supplied a number.

