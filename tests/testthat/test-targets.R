test_that("anime_target_id() returns a data-animejs-id attribute selector", {
  expect_equal(anime_target_id("c1"), "[data-animejs-id='c1']")
  expect_equal(anime_target_id("aj-42"), "[data-animejs-id='aj-42']")
})

test_that("anime_target_class() returns a class selector with leading dot", {
  expect_equal(anime_target_class("circle"), ".circle")
  expect_equal(anime_target_class("bar-segment"), ".bar-segment")
})

test_that("anime_target_layer() returns a data-layer attribute selector", {
  expect_equal(anime_target_layer(1L), "[data-layer='1']")
  expect_equal(anime_target_layer(2L), "[data-layer='2']")
})

test_that("anime_target_css() passes selectors through unchanged", {
  expect_equal(anime_target_css(".my-class > rect"), ".my-class > rect")
  expect_equal(anime_target_css("circle"), "circle")
})

test_that("anime_target_id() rejects non-string input", {
  expect_snapshot(error = TRUE, anime_target_id(1L))
  expect_snapshot(error = TRUE, anime_target_id(NULL))
  expect_snapshot(error = TRUE, anime_target_id(character(0L)))
  expect_snapshot(error = TRUE, anime_target_id(c("a", "b")))
})

test_that("anime_target_class() rejects non-string input", {
  expect_snapshot(error = TRUE, anime_target_class(1L))
  expect_snapshot(error = TRUE, anime_target_class(NULL))
  expect_snapshot(error = TRUE, anime_target_class(c("a", "b")))
})

test_that("anime_target_class() rejects a leading dot with a hint", {
  expect_snapshot(error = TRUE, anime_target_class(".circle"))
})

test_that("anime_target_layer() rejects non-count input", {
  expect_snapshot(error = TRUE, anime_target_layer(0L))
  expect_snapshot(error = TRUE, anime_target_layer(1.5))
  expect_snapshot(error = TRUE, anime_target_layer("1"))
})

test_that("anime_target_css() rejects non-string input", {
  expect_snapshot(error = TRUE, anime_target_css(NULL))
  expect_snapshot(error = TRUE, anime_target_css(c(".a", ".b")))
})
