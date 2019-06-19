context("test-utils")

test_that("it guesses prefix correctly", {
    expect_equal(guess_prefix(paste0("a11y_", 11:13)), "a11y_")
})
