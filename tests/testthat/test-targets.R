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

test_that("anime_target_css() is an identity function", {
  expect_equal(anime_target_css(".my-class > rect"), ".my-class > rect")
  expect_equal(anime_target_css("circle"), "circle")
})

test_that("anime_target_id() rejects non-character input", {
  expect_error(anime_target_id(1L), class = "rlang_error")
  expect_error(anime_target_id(NULL), class = "rlang_error")
})

test_that("anime_target_id() rejects length-0 character input", {
  expect_error(anime_target_id(character(0L)), class = "rlang_error")
})

test_that("anime_target_class() rejects non-character input", {
  expect_error(anime_target_class(1L), class = "rlang_error")
  expect_error(anime_target_class(NULL), class = "rlang_error")
})

test_that("anime_target_class() rejects length-0 character input", {
  expect_error(anime_target_class(character(0L)), class = "rlang_error")
})
