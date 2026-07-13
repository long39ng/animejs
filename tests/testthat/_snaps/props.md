# anime_keyframes() rejects malformed keyframes

    Code
      anime_keyframes(list(from = 0))
    Condition
      Error in `anime_keyframes()`:
      ! Each keyframe must be a bare atomic value or a list with a to element.
      x Keyframe 1 is a list.

---

    Code
      anime_keyframes(0, c(1, 2))
    Condition
      Error in `anime_keyframes()`:
      ! Each keyframe must be a bare atomic value or a list with a to element.
      x Keyframe 2 is a double vector.

---

    Code
      anime_keyframes(list(to = 1, ease = 42))
    Condition
      Error in `anime_keyframes()`:
      ! `ease` must be an <anime_easing> object or an Anime.js easing name string.
      x You supplied a number.
      i See `anime_easing()` for the available constructors.

# anime_from_to() validates ease

    Code
      anime_from_to(0, 1, ease = 42)
    Condition
      Error in `anime_from_to()`:
      ! `ease` must be an <anime_easing> object or an Anime.js easing name string.
      x You supplied a number.
      i See `anime_easing()` for the available constructors.

