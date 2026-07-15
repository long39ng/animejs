# anime_render() errors informatively on unsupported input

    Code
      anime_render(list())
    Condition
      Error in `anime_render()`:
      ! `x` must be an <anime_timeline> or <anime_animation> object.
      x You supplied an empty list.

---

    Code
      anime_render("not a timeline")
    Condition
      Error in `anime_render()`:
      ! `x` must be an <anime_timeline> or <anime_animation> object.
      x You supplied a string.

