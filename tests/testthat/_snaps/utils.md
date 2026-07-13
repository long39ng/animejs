# validate_duration() rejects invalid input

    Code
      validate_duration("fast")
    Condition
      Error:
      ! `duration` must be a single number.
      x You supplied a string.

---

    Code
      validate_duration(TRUE)
    Condition
      Error:
      ! `duration` must be a single number.
      x You supplied `TRUE`.

---

    Code
      validate_duration(NULL)
    Condition
      Error:
      ! `duration` must be a single number.
      x You supplied NULL.

---

    Code
      validate_duration(-1)
    Condition
      Error:
      ! `duration` must be at least 0.
      x You supplied -1.

---

    Code
      validate_duration(c(100, 200))
    Condition
      Error:
      ! `duration` must be a single number.
      x You supplied a double vector.

---

    Code
      validate_duration("x", arg = "delay")
    Condition
      Error:
      ! `delay` must be a single number.
      x You supplied a string.

