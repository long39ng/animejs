# anime_on() validates its inputs

    Code
      anime_on(tl, "onUnknown", "cb")
    Condition
      Error in `anime_on()`:
      ! `event` must be one of "onBegin", "onBeforeUpdate", "onUpdate", "onRender", "onLoop", "onPause", or "onComplete", not "onUnknown".

---

    Code
      anime_on(tl, "complete", "cb")
    Condition
      Error in `anime_on()`:
      ! `event` must be one of "onBegin", "onBeforeUpdate", "onUpdate", "onRender", "onLoop", "onPause", or "onComplete", not "complete".
      i Did you mean "onComplete"?

---

    Code
      anime_on(list(), "onComplete", "cb")
    Condition
      Error in `anime_on()`:
      ! `x` must be an <anime_timeline> or <anime_animation> object.
      x You supplied an empty list.

---

    Code
      anime_on(tl, "onComplete", 42)
    Condition
      Error in `anime_on()`:
      ! `callback` must be a single string.
      x You supplied a number.

