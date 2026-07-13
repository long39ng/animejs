# anime_easing() rejects unrecognised family and direction names

    Code
      anime_easing("Quadratic")
    Condition
      Error in `anime_easing()`:
      ! `family` must be one of "linear", "Quad", "Cubic", "Quart", "Quint", "Sine", "Expo", "Circ", or "Bounce", not "Quadratic".

---

    Code
      anime_easing("Elastic")
    Condition
      Error in `anime_easing()`:
      ! `family` must be one of "linear", "Quad", "Cubic", "Quart", "Quint", "Sine", "Expo", "Circ", or "Bounce", not "Elastic".

---

    Code
      anime_easing("Quad", "Both")
    Condition
      Error in `anime_easing()`:
      ! `direction` must be one of "in", "out", "inOut", or "outIn", not "Both".

# anime_easing_elastic() validates its parameters

    Code
      anime_easing_elastic("Both")
    Condition
      Error in `anime_easing_elastic()`:
      ! `direction` must be one of "in", "out", "inOut", or "outIn", not "Both".

---

    Code
      anime_easing_elastic(amplitude = 0.5)
    Condition
      Error in `anime_easing_elastic()`:
      ! `amplitude` must be between 1 and 10.
      x You supplied 0.5.

---

    Code
      anime_easing_elastic(amplitude = 11)
    Condition
      Error in `anime_easing_elastic()`:
      ! `amplitude` must be between 1 and 10.
      x You supplied 11.

---

    Code
      anime_easing_elastic(period = 3)
    Condition
      Error in `anime_easing_elastic()`:
      ! `period` must be between 0 and 2.
      x You supplied 3.

# anime_easing_back() validates its parameters

    Code
      anime_easing_back("Sideways")
    Condition
      Error in `anime_easing_back()`:
      ! `direction` must be one of "in", "out", "inOut", or "outIn", not "Sideways".

---

    Code
      anime_easing_back(overshoot = "far")
    Condition
      Error in `anime_easing_back()`:
      ! `overshoot` must be a single number.
      x You supplied a string.

# anime_easing_steps() validates its parameters

    Code
      anime_easing_steps()
    Condition
      Error in `anime_easing_steps()`:
      ! `count` is absent but must be supplied.

---

    Code
      anime_easing_steps(0)
    Condition
      Error in `anime_easing_steps()`:
      ! `count` must be a single positive integer.
      x You supplied 0.

---

    Code
      anime_easing_steps(-1)
    Condition
      Error in `anime_easing_steps()`:
      ! `count` must be a single positive integer.
      x You supplied -1.

---

    Code
      anime_easing_steps(2.5)
    Condition
      Error in `anime_easing_steps()`:
      ! `count` must be a single positive integer.
      x You supplied 2.5.

---

    Code
      anime_easing_steps(10, from_start = "yes")
    Condition
      Error in `anime_easing_steps()`:
      ! `from_start` must be TRUE or FALSE.
      x You supplied a string.

# anime_easing_spring() validates its parameters

    Code
      anime_easing_spring(bounce = 2)
    Condition
      Error in `anime_easing_spring()`:
      ! `bounce` must be between -1 and 1.
      x You supplied 2.

---

    Code
      anime_easing_spring(bounce = c(0.1, 0.2))
    Condition
      Error in `anime_easing_spring()`:
      ! `bounce` must be a single number.
      x You supplied a double vector.

---

    Code
      anime_easing_spring(duration = 5)
    Condition
      Error in `anime_easing_spring()`:
      ! `duration` must be between 10 and 10000.
      x You supplied 5.

---

    Code
      anime_easing_spring(duration = 20000)
    Condition
      Error in `anime_easing_spring()`:
      ! `duration` must be between 10 and 10000.
      x You supplied 20000.

# anime_easing_bezier() validates its parameters

    Code
      anime_easing_bezier(-0.1, 0, 0.2, 1)
    Condition
      Error in `anime_easing_bezier()`:
      ! `x1` must be between 0 and 1.
      x You supplied -0.1.

---

    Code
      anime_easing_bezier(1.1, 0, 0.2, 1)
    Condition
      Error in `anime_easing_bezier()`:
      ! `x1` must be between 0 and 1.
      x You supplied 1.1.

---

    Code
      anime_easing_bezier(0.4, 0, -0.1, 1)
    Condition
      Error in `anime_easing_bezier()`:
      ! `x2` must be between 0 and 1.
      x You supplied -0.1.

---

    Code
      anime_easing_bezier(0.4, 0, 1.1, 1)
    Condition
      Error in `anime_easing_bezier()`:
      ! `x2` must be between 0 and 1.
      x You supplied 1.1.

---

    Code
      anime_easing_bezier(0.4, 0, 0.2)
    Condition
      Error in `anime_easing_bezier()`:
      ! `y2` is absent but must be supplied.

# easing_to_config() errors on unsupported input

    Code
      easing_to_config(42)
    Condition
      Error:
      ! `ease` must be an <anime_easing> object or an Anime.js easing name string.
      x You supplied a number.

---

    Code
      easing_to_config(list())
    Condition
      Error:
      ! `ease` must be an <anime_easing> object or an Anime.js easing name string.
      x You supplied an empty list.

