# anime_text() rejects non-atomic or empty input

    Code
      anime_text(list("a", "b"))
    Condition
      Error in `anime_text()`:
      ! `values` must be a non-empty atomic vector.
      x You supplied a list.

---

    Code
      anime_text(character(0))
    Condition
      Error in `anime_text()`:
      ! `values` must be a non-empty atomic vector.
      x You supplied an empty character vector.

---

    Code
      anime_text()
    Condition
      Error in `anime_text()`:
      ! `values` is absent but must be supplied.

