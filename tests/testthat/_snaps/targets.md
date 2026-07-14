# anime_target_id() rejects non-string input

    Code
      anime_target_id(1L)
    Condition
      Error in `anime_target_id()`:
      ! `id` must be a single string.
      x You supplied an integer.

---

    Code
      anime_target_id(NULL)
    Condition
      Error in `anime_target_id()`:
      ! `id` must be a single string.
      x You supplied NULL.

---

    Code
      anime_target_id(character(0L))
    Condition
      Error in `anime_target_id()`:
      ! `id` must be a single string.
      x You supplied an empty character vector.

---

    Code
      anime_target_id(c("a", "b"))
    Condition
      Error in `anime_target_id()`:
      ! `id` must be a single string.
      x You supplied a character vector.

# anime_target_class() rejects non-string input

    Code
      anime_target_class(1L)
    Condition
      Error in `anime_target_class()`:
      ! `cls` must be a single string.
      x You supplied an integer.

---

    Code
      anime_target_class(NULL)
    Condition
      Error in `anime_target_class()`:
      ! `cls` must be a single string.
      x You supplied NULL.

---

    Code
      anime_target_class(c("a", "b"))
    Condition
      Error in `anime_target_class()`:
      ! `cls` must be a single string.
      x You supplied a character vector.

# anime_target_class() rejects a leading dot with a hint

    Code
      anime_target_class(".circle")
    Condition
      Error in `anime_target_class()`:
      ! `cls` must be a class name without the leading dot.
      i Did you mean "circle"?

# anime_target_layer() rejects non-count input

    Code
      anime_target_layer(0L)
    Condition
      Error in `anime_target_layer()`:
      ! `layer_index` must be a single positive integer.
      x You supplied 0.

---

    Code
      anime_target_layer(1.5)
    Condition
      Error in `anime_target_layer()`:
      ! `layer_index` must be a single positive integer.
      x You supplied 1.5.

---

    Code
      anime_target_layer("1")
    Condition
      Error in `anime_target_layer()`:
      ! `layer_index` must be a single positive integer.
      x You supplied a string.

# anime_target_css() rejects non-string input

    Code
      anime_target_css(NULL)
    Condition
      Error in `anime_target_css()`:
      ! `selector` must be a single string.
      x You supplied NULL.

---

    Code
      anime_target_css(c(".a", ".b"))
    Condition
      Error in `anime_target_css()`:
      ! `selector` must be a single string.
      x You supplied a character vector.

