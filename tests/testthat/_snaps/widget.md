# animejs_widget() validates its inputs

    Code
      animejs_widget(svg = 1, config = list())
    Condition
      Error in `animejs_widget()`:
      ! `svg` must be a single string.
      x You supplied a number.

---

    Code
      animejs_widget(svg = "", config = "nope")
    Condition
      Error in `animejs_widget()`:
      ! `config` must be a list.
      x You supplied a string.

