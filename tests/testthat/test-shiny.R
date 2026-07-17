test_that("animejsOutput() returns a Shiny output tag list", {
  skip_if_not_installed("shiny")
  out <- animejsOutput("anim")
  expect_s3_class(out, "shiny.tag.list")
})

test_that("animejsOutput() applies width and height", {
  skip_if_not_installed("shiny")
  out <- animejsOutput("anim", width = "50%", height = "200px")
  html <- as.character(out)
  expect_match(html, "width:\\s*50%")
  expect_match(html, "height:\\s*200px")
})

test_that("renderAnimejs() returns a Shiny render function", {
  skip_if_not_installed("shiny")
  rf <- renderAnimejs({
    anime_render(anime_timeline())
  })
  expect_s3_class(rf, "shiny.render.function")
})
