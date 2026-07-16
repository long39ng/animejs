# anime_stagger() validates its inputs

    Code
      anime_stagger("fast")
    Condition
      Error in `anime_stagger()`:
      ! `value` must be a single number.
      x You supplied a string.

---

    Code
      anime_stagger(100, from = "middle")
    Condition
      Error in `anime_stagger()`:
      ! `from` must be one of "first", "last", or "center", not "middle".

---

    Code
      anime_stagger(100, from = -1)
    Condition
      Error in `anime_stagger()`:
      ! `from` must be "first", "last", "center", or a non-negative integer index.
      x You supplied -1.

---

    Code
      anime_stagger(100, from = TRUE)
    Condition
      Error in `anime_stagger()`:
      ! `from` must be "first", "last", "center", or a non-negative integer index.
      x You supplied `TRUE`.

---

    Code
      anime_stagger(100, grid = c(1, 2, 3))
    Condition
      Error in `anime_stagger()`:
      ! `grid` must be an integer vector of length 2, `c(rows, cols)`.
      x You supplied a double vector.

---

    Code
      anime_stagger(100, axis = "z")
    Condition
      Error in `anime_stagger()`:
      ! `axis` must be one of "x" or "y", not "z".

---

    Code
      anime_stagger(100, ease = 42)
    Condition
      Error in `anime_stagger()`:
      ! `ease` must be an <anime_easing> object or an Anime.js easing name string.
      x You supplied a number.
      i See `anime_easing()` for the available constructors.

