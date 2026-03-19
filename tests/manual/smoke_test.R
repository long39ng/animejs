# Non-automated smoke test. Run interactively; inspect output in a browser.

library(animejs)

svg_src <- '
<svg viewBox="0 0 500 200" xmlns="http://www.w3.org/2000/svg">
  <circle class="dot" data-animejs-id="c1" cx="60"  cy="100" r="20" fill="#4e79a7"/>
  <circle class="dot" data-animejs-id="c2" cx="140" cy="100" r="20" fill="#f28e2b"/>
  <circle class="dot" data-animejs-id="c3" cx="220" cy="100" r="20" fill="#e15759"/>
  <rect   class="bar" data-animejs-id="r1" x="300" y="60"  width="0" height="80" fill="#76b7b2"/>
  <rect   class="bar" data-animejs-id="r2" x="360" y="60"  width="0" height="80" fill="#59a14f"/>
</svg>
'

anime_timeline(
  duration = 800,
  easing = "easeOutElastic",
  loop = TRUE
) |>
  # 1. anime_from_to: staggered entrance of circles
  anime_add(
    selector = anime_target_class("dot"),
    props = list(
      translateY = anime_from_to(-60, 0),
      opacity = anime_from_to(0, 1)
    ),
    stagger = anime_stagger(150, from = "first"),
    offset = "+=0"
  ) |>
  # 2. anime_keyframes: bounce c2 up and back
  anime_add(
    selector = anime_target_id("c2"),
    props = list(
      translateY = anime_keyframes(0, -40, 0),
      r = anime_keyframes(
        list(to = 20),
        list(to = 30, ease = "easeOutQuad"),
        list(to = 20, ease = "easeInQuad", duration = 200)
      )
    ),
    offset = "+=300"
  ) |>
  # 3. anime_from_to with unit: grow bar widths
  anime_add(
    selector = anime_target_class("bar"),
    props = list(width = anime_from_to(0, 120, unit = "px")),
    stagger = anime_stagger(100, from = "first"),
    easing = "easeOutCubic",
    offset = "+=0"
  ) |>
  # 4. Playback controls + autoplay
  anime_playback(
    autoplay = TRUE,
    loop = TRUE,
    direction = "alternate",
    controls = TRUE
  ) |>
  anime_render(svg = svg_src)
